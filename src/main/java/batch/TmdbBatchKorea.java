package batch;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;

import DTO.Movie.GenreDTO;
import DTO.Movie.MovieCastDTO;
import DTO.Movie.MovieCrewDTO;
import DTO.Movie.MovieDTO;
import DTO.Movie.MovieGenreDTO;
import DTO.Movie.PersonDTO;
import mybatis.BatchDBService;

/**
 * TMDB 한국 영화 전용 배치 프로세싱
 * - TMDB discover API의 with_origin_country=KR 필터를 사용하여 한국 영화만 수집
 * - 자동 UPSERT (DB MERGE로 처리)
 * - 배치 트랜잭션 관리 (청크 단위 커밋)
 * - 병렬 처리로 성능 최적화
 * - BackdropPath가 null인 영화는 저장하지 않음
 */
public class TmdbBatchKorea {

	// TMDB API 설정
	private static final String BASE_URL = "https://api.themoviedb.org/3";
	private static String API_KEY;

	// 배치 처리 설정 (기본값)
	private static int MOVIE_COUNT = 5;
	private static int BATCH_COMMIT_SIZE = 500;
	private static int THREAD_POOL_SIZE_MOVIES = 4;
	private static int THREAD_POOL_SIZE_PERSONS = 8;
	private static int MAX_RETRY_ATTEMPTS = 3;
	private static long RETRY_DELAY_MS = 1000;

	private long totalGenresProcessed = 0;
	private long totalMoviesProcessed = 0;
	private long totalPersonsProcessed = 0;
	private long totalMovieCastsProcessed = 0;

	// 설정 파일에서 값 로드
	static {
		loadConfiguration();
	}

	private static void loadConfiguration() {
		Properties props = new Properties();
		try (InputStream is = TmdbBatchKorea.class.getClassLoader()
				.getResourceAsStream("batch.properties")) {
			if (is != null) {
				props.load(is);

				API_KEY = props.getProperty("tmdb.api.key", "YOUR_API_KEY_HERE");

				MOVIE_COUNT = Integer.parseInt(props.getProperty("batch.movie.count"));
				BATCH_COMMIT_SIZE = Integer.parseInt(props.getProperty("batch.commit.size"));
				THREAD_POOL_SIZE_MOVIES = Integer.parseInt(props.getProperty("batch.thread.movies"));
				THREAD_POOL_SIZE_PERSONS = Integer.parseInt(props.getProperty("batch.thread.persons"));
				MAX_RETRY_ATTEMPTS = Integer.parseInt(props.getProperty("api.max.retry"));
				RETRY_DELAY_MS = Long.parseLong(props.getProperty("api.retry.delay.ms"));

				System.out.println("[한국영화 배치] 배치 설정 로드 완료 (batch.properties)");
			} else {
				System.out.println("[한국영화 배치] batch.properties 파일 없음.");
			}
		} catch (Exception e) {
			System.err.println("[한국영화 배치] 설정 파일 로드 실패: " + e.getMessage());
			API_KEY = System.getenv("TMDB_API_KEY");
			if (API_KEY == null) {
				API_KEY = "YOUR_API_KEY_HERE";
			}
		}
	}

	public static void main(String[] args) {
		System.out.println("\n" + "=".repeat(70));
		System.out.println("TMDB 한국 영화 배치 프로세싱 시작");
		System.out.println("시작 시간: " + java.time.LocalDateTime.now());
		System.out.println("=".repeat(70) + "\n");

		long startTime = System.currentTimeMillis();

		try {
			TmdbBatchKorea batch = new TmdbBatchKorea();
			batch.executeBatch();

			long endTime = System.currentTimeMillis();
			long duration = (endTime - startTime) / 1000;

			System.out.println("\n" + "=".repeat(70));
			System.out.println("TMDB 한국 영화 배치 프로세싱 완료");
			System.out.println("종료 시간: " + java.time.LocalDateTime.now());
			System.out.println("소요 시간: " + duration + "초");
			System.out.println("=".repeat(70) + "\n");

		} catch (Exception e) {
			System.err.println("\n" + "=".repeat(70));
			System.err.println("TMDB 한국 영화 배치 프로세싱 중 오류 발생");
			System.err.println("=".repeat(70));
			e.printStackTrace();
			System.err.println();
			System.exit(1);
		}
	}

	/**
	 * 한국 영화 배치 작업 실행
	 */
	public void executeBatch() throws Exception {
		resetStatistics();
		try {
			System.out.println("=== 1단계: 장르 정보 수집 및 저장 ===");
			loadAndSaveGenres();

			System.out.println("\n=== 2단계: 한국 영화 목록 수집 ===");
			List<Integer> movieIds = fetchKoreanMovieIds(MOVIE_COUNT);

			System.out.println("\n=== 3단계: 영화 상세 정보 및 출연진 수집 (병렬 처리) ===");
			List<MovieDTO> movies = new CopyOnWriteArrayList<>();
			List<MovieCastDTO> casts = new CopyOnWriteArrayList<>();
			List<MovieCrewDTO> crews = new CopyOnWriteArrayList<>();
			List<MovieGenreDTO> movieGenres = new CopyOnWriteArrayList<>();
			Set<Integer> personIds = Collections.synchronizedSet(new HashSet<>());

			processMoviesInParallel(movieIds, movies, casts, crews, movieGenres, personIds);

			System.out.println("\n=== 4단계: 출연인물 정보 수집 (병렬 처리) ===");
			List<PersonDTO> persons = new CopyOnWriteArrayList<>();
			processPersonsInParallel(personIds, persons);

			System.out.println("\n=== 5단계: 데이터베이스에 저장 (배치 커밋) ===");
			saveBatchData(movies, persons, casts, crews, movieGenres);

			printStatistics();

		} catch (Exception e) {
			System.err.println("[한국영화 배치] 배치 처리 중 오류 발생: " + e.getMessage());
			throw new RuntimeException("TMDB 한국 영화 데이터 배치 처리 실패", e);
		}
	}

	// ==================== 한국 영화 수집 ====================

	/**
	 * TMDB discover API를 사용하여 한국 영화 ID 목록 수집
	 * with_origin_country=KR 필터로 한국 영화만 가져옴
	 */
	private List<Integer> fetchKoreanMovieIds(int count) throws Exception {
		Set<Integer> movieIdSet = new HashSet<>();
		int page = 1;
		int totalPages = 1;

		System.out.println("한국 영화 " + count + "개 수집 목표...");

		while (movieIdSet.size() < count && page <= totalPages) {
			try {
				String url = BASE_URL + "/discover/movie?language=ko-KR&with_origin_country=KR"
						+ "&sort_by=popularity.desc&page=" + page;
				String jsonResponse = makeHttpRequest(url);
				JSONObject json = new JSONObject(jsonResponse);

				if (page == 1) {
					totalPages = Math.min(json.optInt("total_pages", 1), 500);
					System.out.println("한국 영화 총 페이지 수: " + totalPages);
				}

				JSONArray results = json.getJSONArray("results");
				System.out.println("페이지 " + page + "에서 " + results.length() + "개 한국 영화 로드");

				for (int i = 0; i < results.length(); i++) {
					movieIdSet.add(results.getJSONObject(i).getInt("id"));
					if (movieIdSet.size() >= count) break;
				}

				page++;

				// Rate limit 방지를 위한 대기
				if (page <= totalPages && movieIdSet.size() < count) {
					try { Thread.sleep(150); } catch (InterruptedException ie) { /* ignore */ }
				}
			} catch (Exception e) {
				System.err.println("페이지 " + page + " 수집 중 오류: " + e.getMessage());
				page++;
			}
		}

		List<Integer> result = new ArrayList<>(movieIdSet);
		System.out.println("한국 영화 " + result.size() + "개 수집 완료");

		// Diagnostic summary
		int sampleLimit = Math.min(10, result.size());
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < sampleLimit; i++) {
			if (i > 0) sb.append(",");
			sb.append(result.get(i));
		}
		System.out.println("{\"koreanMovieCount\":" + result.size()
				+ ",\"sampleIds\":[" + sb.toString() + "]}");

		return result;
	}

	// ==================== 장르 처리 ====================

	private void loadAndSaveGenres() throws Exception {
		System.out.println("장르 정보 수집 중...");
		List<GenreDTO> genres = fetchAllGenres();

		if (genres.isEmpty()) {
			System.out.println("수집된 장르가 없습니다.");
			return;
		}

		System.out.println("총 " + genres.size() + "개 장르 정보 수집 완료");
		System.out.println("장르 정보를 데이터베이스에 저장 중...");

		SqlSession session = BatchDBService.openBatchSession();
		try {
			int count = 0;
			for (GenreDTO genre : genres) {
				session.insert("DAO.Movie.GenreDAO.mergeGenre", genre);
				count++;
				if (count % BATCH_COMMIT_SIZE == 0) {
					session.flushStatements();
					session.commit();
					System.out.println("  - 장르 " + count + "개 커밋 완료");
				}
			}
			session.flushStatements();
			session.commit();
			totalGenresProcessed = genres.size();
			System.out.println("장르 정보 저장 완료: " + genres.size() + "개");
		} catch (Exception e) {
			session.rollback();
			throw e;
		} finally {
			session.close();
		}
	}

	private List<GenreDTO> fetchAllGenres() throws Exception {
		String url = BASE_URL + "/genre/movie/list?language=ko-KR";
		String jsonResponse = makeHttpRequest(url);

		List<GenreDTO> genres = new ArrayList<>();
		JSONObject json = new JSONObject(jsonResponse);
		JSONArray genreArray = json.getJSONArray("genres");

		for (int i = 0; i < genreArray.length(); i++) {
			JSONObject genreJson = genreArray.getJSONObject(i);
			GenreDTO genre = new GenreDTO();
			genre.setGenreId(genreJson.getInt("id"));
			genre.setGenreName(genreJson.getString("name"));
			genres.add(genre);
		}

		return genres;
	}

	// ==================== 영화 병렬 처리 ====================

	private void processMoviesInParallel(List<Integer> movieIds, List<MovieDTO> movies,
			List<MovieCastDTO> casts, List<MovieCrewDTO> crews, List<MovieGenreDTO> movieGenres,
			Set<Integer> personIds) throws Exception {

		ExecutorService executor = Executors.newFixedThreadPool(THREAD_POOL_SIZE_MOVIES);
		List<Future<?>> futures = new ArrayList<>();

		for (int movieId : movieIds) {
			futures.add(executor.submit(() -> {
				try {
					System.out.println("[한국영화] 영화 ID " + movieId + " 처리 중...");

					MovieDTO movie = fetchMovieDetails(movieId);
					if (movie != null && movie.getMovieBackdropPath() != null && !movie.getMovieBackdropPath().isEmpty()
							&& movie.getMoviePosterPath() != null && !movie.getMoviePosterPath().isEmpty()) {
						movies.add(movie);
						System.out.println("  - 영화 ID " + movieId + " 정보 수집 완료");

						// 출연진 정보 수집
						List<MovieCastDTO> movieCasts = fetchMovieCasts(movieId);
						casts.addAll(movieCasts);
						for (MovieCastDTO cast : movieCasts) {
							personIds.add(cast.getPersonId());
						}
						System.out.println("    - 출연진 " + movieCasts.size() + "명 수집");

						// 크루 정보 수집
						List<MovieCrewDTO> movieCrews = fetchMovieCrews(movieId);
						crews.addAll(movieCrews);
						for (MovieCrewDTO crew : movieCrews) {
							personIds.add(crew.getPersonId());
						}
						System.out.println("    - 크루 " + movieCrews.size() + "명 수집");

						// 장르 정보 수집
						List<MovieGenreDTO> genreList = fetchMovieGenres(movieId);
						movieGenres.addAll(genreList);
						System.out.println("    - 장르 " + genreList.size() + "개 수집");
					} else if (movie != null) {
						System.out.println("  - 영화 ID " + movieId + " BackdropPath가 null이므로 저장 건너뜀");
					} else {
						System.err.println("{\"movieId\":" + movieId + ",\"status\":\"fetch_null\"}");
					}
				} catch (Exception e) {
					System.err.println("[한국영화] 영화 ID " + movieId + " 처리 중 오류: " + e.getMessage());
				}
			}));
		}

		for (Future<?> future : futures) {
			try {
				future.get();
			} catch (Exception e) {
				System.err.println("병렬 처리 중 오류: " + e.getMessage());
			}
		}
		executor.shutdown();

		totalMoviesProcessed = movies.size();
		System.out.println("[한국영화] 영화 처리 완료: " + movies.size() + "개");
		System.out.println("[한국영화] 출연인물 수집 예정: " + personIds.size() + "명");
	}

	// ==================== 인물 병렬 처리 ====================

	private void processPersonsInParallel(Set<Integer> personIds, List<PersonDTO> persons) throws Exception {
		if (personIds.isEmpty()) {
			System.out.println("수집할 출연인물이 없습니다.");
			return;
		}

		ExecutorService executor = Executors.newFixedThreadPool(THREAD_POOL_SIZE_PERSONS);
		List<Future<?>> futures = new ArrayList<>();
		int personCount = 0;

		for (Integer personId : personIds) {
			personCount++;
			final int currentCount = personCount;

			futures.add(executor.submit(() -> {
				try {
					PersonDTO person = fetchPersonDetails(personId);
					if (person != null) {
						persons.add(person);
						if (currentCount % 10 == 0) {
							System.out.println("  - " + currentCount + "명 처리 중...");
						}
					}
				} catch (Exception e) {
					System.err.println("인물 ID " + personId + " 처리 중 오류: " + e.getMessage());
				}
			}));
		}

		for (Future<?> future : futures) {
			try {
				future.get();
			} catch (Exception e) {
				System.err.println("병렬 처리 중 오류: " + e.getMessage());
			}
		}
		executor.shutdown();

		totalPersonsProcessed = persons.size();
		System.out.println("출연인물 처리 완료: " + persons.size() + "명");
	}

	// ==================== DB 저장 ====================

	private void saveBatchData(List<MovieDTO> movies, List<PersonDTO> persons,
			List<MovieCastDTO> casts, List<MovieCrewDTO> crews, List<MovieGenreDTO> movieGenres) {

		SqlSession session = BatchDBService.openBatchSession();
		try {
			// 영화 저장
			System.out.println("영화 정보 저장 중: " + movies.size() + "개");
			int count = 0;
			for (MovieDTO movie : movies) {
				session.insert("DAO.Movie.MovieDAO.mergeMovie", movie);
				count++;
				if (count % BATCH_COMMIT_SIZE == 0) {
					session.flushStatements();
					session.commit();
					System.out.println("  - " + count + "개 영화 커밋 완료");
				}
			}
			session.flushStatements();
			session.commit();
			System.out.println("  - 총 " + count + "개 영화 저장 완료");

			// 인물 저장
			System.out.println("출연인물 정보 저장 중: " + persons.size() + "명");
			count = 0;
			for (PersonDTO person : persons) {
				session.insert("DAO.Movie.PersonDAO.mergePerson", person);
				count++;
				if (count % BATCH_COMMIT_SIZE == 0) {
					session.flushStatements();
					session.commit();
					System.out.println("  - " + count + "명 커밋 완료");
				}
			}
			session.flushStatements();
			session.commit();
			System.out.println("  - 총 " + count + "명 저장 완료");

			// 영화 출연진 저장
			System.out.println("영화 출연진 정보 저장 중: " + casts.size() + "개");
			count = 0;
			for (MovieCastDTO cast : casts) {
				session.insert("DAO.Movie.MovieCastDAO.mergeMovieCast", cast);
				count++;
				if (count % BATCH_COMMIT_SIZE == 0) {
					session.flushStatements();
					session.commit();
					System.out.println("  - " + count + "개 커밋 완료");
				}
			}
			session.flushStatements();
			session.commit();
			totalMovieCastsProcessed = casts.size();
			System.out.println("  - 총 " + count + "개 저장 완료");

			// 영화 크루 저장
			System.out.println("영화 크루 정보 저장 중: " + crews.size() + "개");
			count = 0;
			for (MovieCrewDTO crew : crews) {
				session.insert("DAO.Movie.MovieCrewDAO.mergeMovieCrew", crew);
				count++;
				if (count % BATCH_COMMIT_SIZE == 0) {
					session.flushStatements();
					session.commit();
					System.out.println("  - " + count + "개 커밋 완료");
				}
			}
			session.flushStatements();
			session.commit();
			System.out.println("  - 총 " + count + "개 저장 완료");

			// 영화 장르 저장
			System.out.println("영화 장르 정보 저장 중: " + movieGenres.size() + "개");
			count = 0;
			for (MovieGenreDTO genre : movieGenres) {
				session.insert("DAO.Movie.MovieGenreDAO.mergeMovieGenre", genre);
				count++;
				if (count % BATCH_COMMIT_SIZE == 0) {
					session.flushStatements();
					session.commit();
					System.out.println("  - " + count + "개 커밋 완료");
				}
			}
			session.flushStatements();
			session.commit();
			System.out.println("  - 총 " + count + "개 저장 완료");

		} catch (Exception e) {
			session.rollback();
			System.err.println("데이터 저장 중 오류 발생, 롤백 수행: " + e.getMessage());
			throw new RuntimeException("데이터 저장 실패", e);
		} finally {
			session.close();
		}
	}

	// ==================== TMDB API 호출 ====================

	private MovieDTO fetchMovieDetails(int movieId) throws Exception {
		String url = BASE_URL + "/movie/" + movieId + "?language=ko-KR";
		String jsonResponse = makeHttpRequest(url);

		JSONObject json = new JSONObject(jsonResponse);

		MovieDTO movie = new MovieDTO();
		movie.setMovieId(json.getInt("id"));
		movie.setMovieTitle(json.optString("title", ""));
		movie.setMovieOriginalTitle(json.optString("original_title", ""));
		movie.setMovieOverview(json.optString("overview", ""));
		movie.setMovieReleaseDate(json.optString("release_date", null));
		movie.setMovieRuntime(json.optInt("runtime", 0));
		movie.setMoviePosterPath(json.optString("poster_path", null));
		movie.setMovieBackdropPath(json.optString("backdrop_path", null));
		movie.setMovieRatingAverage(json.optDouble("vote_average", 0.0));
		movie.setMovieRatingCount(json.optInt("vote_count", 0));

		String _title = movie.getMovieTitle();
		if (_title == null) _title = "";
		_title = _title.replace('"', '\'');
		System.out.println("{\"fetchedMovieId\":" + movie.getMovieId() + ",\"title\":\"" + _title + "\"}");

		return movie;
	}

	private List<MovieCastDTO> fetchMovieCasts(int movieId) throws Exception {
		String url = BASE_URL + "/movie/" + movieId + "/credits?language=ko-KR";
		String jsonResponse = makeHttpRequest(url);

		List<MovieCastDTO> casts = new ArrayList<>();
		JSONObject json = new JSONObject(jsonResponse);
		JSONArray castArray = json.getJSONArray("cast");

		int limit = Math.min(10, castArray.length());

		for (int i = 0; i < limit; i++) {
			JSONObject castJson = castArray.getJSONObject(i);
			MovieCastDTO cast = new MovieCastDTO();
			cast.setPersonId(castJson.getInt("id"));
			cast.setMovieId(movieId);
			cast.setCharacterName(castJson.optString("character", ""));
			cast.setCastOrder(castJson.optInt("order", i));
			casts.add(cast);
		}

		return casts;
	}

	private List<MovieCrewDTO> fetchMovieCrews(int movieId) throws Exception {
		String url = BASE_URL + "/movie/" + movieId + "/credits?language=ko-KR";
		String jsonResponse = makeHttpRequest(url);

		List<MovieCrewDTO> crews = new ArrayList<>();
		JSONObject json = new JSONObject(jsonResponse);
		JSONArray crewArray = json.getJSONArray("crew");

		Set<String> roles = new HashSet<>();
		roles.add("Director");
		roles.add("Screenplay");
		roles.add("Writer");

		for (int i = 0; i < crewArray.length(); i++) {
			JSONObject crewJson = crewArray.getJSONObject(i);
			String job = crewJson.optString("job", "");

			if (roles.contains(job)) {
				MovieCrewDTO crew = new MovieCrewDTO();
				crew.setPersonId(crewJson.getInt("id"));
				crew.setMovieId(movieId);
				crew.setCrewJob(job);
				crews.add(crew);
			}
		}

		return crews;
	}

	private List<MovieGenreDTO> fetchMovieGenres(int movieId) throws Exception {
		List<MovieGenreDTO> genres = new ArrayList<>();

		String url = BASE_URL + "/movie/" + movieId + "?language=ko-KR";
		String jsonResponse = makeHttpRequest(url);

		JSONObject json = new JSONObject(jsonResponse);
		JSONArray genreArray = json.optJSONArray("genres");

		if (genreArray != null) {
			for (int i = 0; i < genreArray.length(); i++) {
				JSONObject genreJson = genreArray.getJSONObject(i);
				MovieGenreDTO movieGenre = new MovieGenreDTO();
				movieGenre.setGenreId(genreJson.getInt("id"));
				movieGenre.setMovieId(movieId);
				genres.add(movieGenre);
			}
		}

		return genres;
	}

	private PersonDTO fetchPersonDetails(int personId) throws Exception {
		String url = BASE_URL + "/person/" + personId + "?language=ko-KR";
		String jsonResponse = makeHttpRequest(url);

		JSONObject json = new JSONObject(jsonResponse);

		PersonDTO person = new PersonDTO();
		person.setPersonId(json.getInt("id"));
		person.setPersonName(json.optString("name", ""));
		person.setBiography(json.optString("biography", ""));
		person.setProfilePath(json.optString("profile_path", null));

		return person;
	}

	// ==================== HTTP 요청 ====================

	private String makeHttpRequest(String urlString) throws Exception {
		int retryCount = 0;
		Exception lastException = null;

		while (retryCount < MAX_RETRY_ATTEMPTS) {
			try {
				URL url = new URL(urlString);
				HttpURLConnection connection = (HttpURLConnection) url.openConnection();
				try {
					connection.setRequestMethod("GET");
					connection.setConnectTimeout(5000);
					connection.setReadTimeout(5000);
					connection.setRequestProperty("User-Agent", "Mozilla/5.0");
					connection.setRequestProperty("Accept", "application/json");
					connection.setRequestProperty("Authorization", "Bearer " + API_KEY);

					int responseCode = connection.getResponseCode();

					if (responseCode != 200) {
						System.err.println("{\"url\":\"" + urlString + "\",\"responseCode\":" + responseCode + "}");
					}

					if (responseCode == 429) {
						retryCount++;
						if (retryCount < MAX_RETRY_ATTEMPTS) {
							long waitTime = RETRY_DELAY_MS * retryCount;
							System.out.println("Rate limit 발생. " + waitTime + "ms 후 재시도...");
							Thread.sleep(waitTime);
							continue;
						}
						throw new Exception("Rate limit exceeded after retries");
					}

					if (responseCode != 200) {
						throw new Exception("HTTP Error: " + responseCode);
					}

					try (BufferedReader reader = new BufferedReader(
							new InputStreamReader(connection.getInputStream(), "UTF-8"))) {
						StringBuilder response = new StringBuilder();
						String line;
						while ((line = reader.readLine()) != null) {
							response.append(line);
						}
						return response.toString();
					}
				} finally {
					connection.disconnect();
				}
			} catch (Exception e) {
				lastException = e;
				retryCount++;
				System.err.println("API request failed for url " + urlString + ": " + e.getMessage());
				if (retryCount < MAX_RETRY_ATTEMPTS) {
					System.out.println("API 요청 실패 (" + retryCount + "/" + MAX_RETRY_ATTEMPTS + "). 재시도...");
					Thread.sleep(500 * retryCount);
				}
			}
		}

		throw new Exception("HTTP 요청 실패 (최대 재시도 초과)", lastException);
	}

	// ==================== 통계 ====================

	private void resetStatistics() {
		totalGenresProcessed = 0;
		totalMoviesProcessed = 0;
		totalPersonsProcessed = 0;
		totalMovieCastsProcessed = 0;
	}

	private void printStatistics() {
		System.out.println("\n" + "=".repeat(70));
		System.out.println("[한국영화 배치] 배치 처리 통계");
		System.out.println("=".repeat(70));
		System.out.println("처리된 장르: " + totalGenresProcessed + "개");
		System.out.println("처리된 한국 영화: " + totalMoviesProcessed + "개");
		System.out.println("처리된 인물: " + totalPersonsProcessed + "명");
		System.out.println("처리된 영화-출연진 관계: " + totalMovieCastsProcessed + "개");
		System.out.println("=".repeat(70));
	}
}
