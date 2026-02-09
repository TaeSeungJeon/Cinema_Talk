package Service.Movie;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.CopyOnWriteArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.Collections;

import DAO.Movie.GenreDAO;
import DAO.Movie.GenreDAOImpl;
import DAO.Movie.MovieCastDAO;
import DAO.Movie.MovieCastDAOImpl;
import DAO.Movie.MovieDAO;
import DAO.Movie.MovieDAOImpl;
import DAO.Movie.PersonDAO;
import DAO.Movie.PersonDAOImpl;
import DTO.Movie.GenreDTO;
import DTO.Movie.MovieCastDTO;
import DTO.Movie.MovieDTO;
import DTO.Movie.PersonDTO;


public class TMDB_Data_Preload_ServiceImpl implements TMDB_Data_Preload_Service {
	private static TMDB_Data_Preload_ServiceImpl instance = null;
	
	// 하드코딩된 영화 개수
	private static final int MOVIE_COUNT = 5;
	
	public TMDB_Data_Preload_ServiceImpl() {}
	
	public static TMDB_Data_Preload_ServiceImpl getInstance() {
		if(instance == null) {
			instance = new TMDB_Data_Preload_ServiceImpl();
		}
		return instance;
	}

	@Override
	public void preloadTMDBData() {
		try {
			System.out.println("=== TMDB 데이터 수집 시작 ===");
			
			// 1. 모든 장르 정보 수집 및 저장 (중복 검사 포함)
			System.out.println("1단계: 장르 정보 수집 중...");
			List<GenreDTO> allGenres = fetchAllGenres();
			List<GenreDTO> newGenres = new ArrayList<>();
			GenreDAO genreDAO = new GenreDAOImpl();
			
			for (GenreDTO genre : allGenres) {
				if (!genreDAO.existsGenre(genre.getGenreId())) {
					newGenres.add(genre);
				} else {
					System.out.println("장르 ID " + genre.getGenreId() + "(" + genre.getGenreName() + ")는 이미 존재합니다. 스킵.");
				}
			}
			
			if (newGenres.size() > 0) {
				saveGenres(newGenres);
				System.out.println("새 장르 정보 저장 완료: " + newGenres.size() + "개");
			} else {
				System.out.println("저장할 새 장르가 없습니다.");
			}
			
			// 2. 무작위 영화 선택
			System.out.println("2단계: 무작위 영화 " + MOVIE_COUNT + "개 선택 중...");
			List<Integer> movieIds = selectRandomMovieIds(MOVIE_COUNT);
			
			// 3. 선택된 영화의 상세 정보 및 출연진 수집 (병렬 처리로 최적화)
			System.out.println("3단계: 영화 상세 정보 및 출연진 수집 중 (병렬 처리)...");
			List<MovieDTO> newMovies = new CopyOnWriteArrayList<>();
			List<MovieCastDTO> newCasts = new CopyOnWriteArrayList<>();
			Set<String> personIds = Collections.synchronizedSet(new HashSet<>());
			MovieDAO movieDAO = new MovieDAOImpl();
			MovieCastDAO movieCastDAO = new MovieCastDAOImpl();
			
			// 스레드 풀 생성 (CPU 코어 수에 따라 동적 설정, 최대 4개)
			ExecutorService executor = Executors.newFixedThreadPool(Math.min(4, Runtime.getRuntime().availableProcessors()));
			List<Future<?>> futures = new ArrayList<>();
			
			for (int movieId : movieIds) {
				// 각 영화별 처리를 별도 스레드에서 실행
				futures.add(executor.submit(() -> {
					try {
						MovieDTO movie = fetchMovieDetails(movieId);
						if (movie != null) {
							// 이미 DB에 존재하는 영화는 스킵
							if (movieDAO.existsMovie(movie.getMovieId())) {
								System.out.println("영화 ID " + movie.getMovieId() + "는 이미 존재합니다. 스킵.");
								return;
							}
							
							newMovies.add(movie);
							
							// 출연진 정보 수집
							List<MovieCastDTO> casts = fetchMovieCasts(movieId);
							for (MovieCastDTO cast : casts) {
								// 영화-인물 조합이 이미 존재하지 않으면 추가
								if (!movieCastDAO.existsMovieCast(cast.getPersonId(), cast.getMovieId())) {
									newCasts.add(cast);
									personIds.add(cast.getPersonId());
								}
							}
						}
					} catch (Exception e) {
						System.err.println("영화 ID " + movieId + " 수집 중 오류: " + e.getMessage());
					}
				}));
			}
			
			// 모든 영화 처리 작업 완료 대기
			for (Future<?> future : futures) {
				try {
					future.get();
				} catch (Exception e) {
					System.err.println("영화 병렬 처리 중 오류: " + e.getMessage());
				}
			}
			executor.shutdown();

			
			// 4. 선택된 영화의 출연인물 상세 정보 수집 (중복 검사 포함, 병렬 처리)
			System.out.println("4단계: 출연인물 정보 수집 중 (병렬 처리)...");
			System.out.println("총 " + personIds.size() + "명의 출연인물 정보 수집 예정");
			List<PersonDTO> newPersons = new CopyOnWriteArrayList<>();
			PersonDAO personDAO = new PersonDAOImpl();
			
			// 출연인물 정보 수집용 스레드 풀 (최대 8개 스레드)
			ExecutorService personExecutor = Executors.newFixedThreadPool(Math.min(8, Runtime.getRuntime().availableProcessors()));
			List<Future<?>> personFutures = new ArrayList<>();
			
			for (String personId : personIds) {
				personFutures.add(personExecutor.submit(() -> {
					try {
						// 이미 DB에 존재하는 인물은 스킵
						if (personDAO.existsPerson(personId)) {
							System.out.println("인물 ID " + personId + "는 이미 존재합니다. 스킵.");
							return;
						}
						
						PersonDTO person = fetchPersonDetails(personId);
						if (person != null) {
							newPersons.add(person);
						}
					} catch (Exception e) {
						System.err.println("인물 ID " + personId + " 수집 중 오류: " + e.getMessage());
					}
				}));
			}
			
			// 모든 출연인물 처리 작업 완료 대기
			for (Future<?> future : personFutures) {
				try {
					future.get();
				} catch (Exception e) {
					System.err.println("출연인물 병렬 처리 중 오류: " + e.getMessage());
				}
			}
			personExecutor.shutdown();
			
			// 5. DB에 저장
			System.out.println("5단계: 데이터베이스에 저장 중...");
			
			if (newMovies.size() > 0) {
				saveMovies(newMovies);
				System.out.println("새 영화 정보 저장 완료: " + newMovies.size() + "개");

			} else {
				System.out.println("저장할 새 영화가 없습니다.");
			}
			
			if (newPersons.size() > 0) {
				savePersons(newPersons);
				System.out.println("새 출연인물 정보 저장 완료: " + newPersons.size() + "개");
			} else {
				System.out.println("저장할 새 출연인물이 없습니다.");
			}
			
			if (newCasts.size() > 0) {
				saveMovieCasts(newCasts);
				System.out.println("새 영화 출연진 정보 저장 완료: " + newCasts.size() + "개");
			} else {
				System.out.println("저장할 새 영화 출연진이 없습니다.");
			}
			
			System.out.println("=== TMDB 데이터 수집 완료 ===");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("TMDB 데이터 수집 중 오류 발생", e);
		}
	}
	
	/**
	 * 모든 장르 정보를 TMDB API에서 수집
	 */
	private List<GenreDTO> fetchAllGenres() throws Exception {
		String url = BASE_URL + "/genre/movie/list?api_key=" + API_KEY + "&language=ko-KR";
		String jsonResponse = makeHttpRequest(url);
		
		List<GenreDTO> genres = new ArrayList<>();
		JSONObject json = new JSONObject(jsonResponse);
		JSONArray genreArray = json.getJSONArray("genres");
		
		for (int i = 0; i < genreArray.length(); i++) {
			JSONObject genreJson = genreArray.getJSONObject(i);
			GenreDTO genre = new GenreDTO();
			genre.setGenreId(String.valueOf(genreJson.getInt("id")));
			genre.setGenreName(genreJson.getString("name"));
			genres.add(genre);
		}
		
		return genres;
	}
	
	/**
	 * 무작위로 영화 ID를 선택
	 */
	private List<Integer> selectRandomMovieIds(int count) throws Exception {
		Set<Integer> randomIds = new HashSet<>();
		Random random = new Random();
		
		// TMDB의 인기 영화 목록에서 무작위로 선택
		// 20개 영화 = 1 페이지, 필요한 최소 페이지만 로드
		int pageCount = Math.max(1, (count + 19) / 20); // ceil(count / 20)
		List<Integer> candidateIds = new ArrayList<>();
		
		System.out.println("영화 ID 선택을 위해 " + pageCount + "개 페이지 요청");
		
		for (int page = 1; page <= pageCount; page++) {
			try {
				String url = BASE_URL + "/movie/popular?api_key=" + API_KEY 
					+ "&language=ko-KR&page=" + page;
				String jsonResponse = makeHttpRequest(url);
				
				JSONObject json = new JSONObject(jsonResponse);
				JSONArray results = json.getJSONArray("results");
				
				System.out.println("페이지 " + page + "에서 " + results.length() + "개 영화 로드");
				
				for (int i = 0; i < results.length(); i++) {
					candidateIds.add(results.getJSONObject(i).getInt("id"));
				}
			} catch (Exception e) {
				System.err.println("페이지 " + page + " 수집 중 오류: " + e.getMessage());
			}
		}
		
		// 무작위 선택
		System.out.println("총 " + candidateIds.size() + "개 후보 영화 중 " + count + "개 무작위 선택");
		while (randomIds.size() < Math.min(count, candidateIds.size())) {
			randomIds.add(candidateIds.get(random.nextInt(candidateIds.size())));
		}
		
		return new ArrayList<>(randomIds);
	}
	
	/**
	 * 영화의 상세 정보 수집
	 */
	private MovieDTO fetchMovieDetails(int movieId) throws Exception {
		String url = BASE_URL + "/movie/" + movieId + "?api_key=" + API_KEY + "&language=ko-KR";
		String jsonResponse = makeHttpRequest(url);
		
		JSONObject json = new JSONObject(jsonResponse);
		
		MovieDTO movie = new MovieDTO();
		movie.setMovieId(String.valueOf(json.getInt("id")));
		movie.setMovieTitle(json.optString("title", ""));
		movie.setMovieOriginalTitle(json.optString("original_title", ""));
		movie.setMovieOverview(json.optString("overview", ""));
		movie.setMovieReleaseDate(json.optString("release_date", null));
		movie.setMovieRuntime(json.optInt("runtime", 0));
		movie.setMoviePosterPath(json.optString("poster_path", null));
		movie.setMovieBackdropPath(json.optString("backdrop_path", null));
		movie.setMovieRatingAverage(json.optDouble("vote_average", 0.0));
		movie.setMovieRatingCount(json.optInt("vote_count", 0));
		
		return movie;
	}
	
	/**
	 * 영화의 출연진 정보 수집 (상위 10명만)
	 */
	private List<MovieCastDTO> fetchMovieCasts(int movieId) throws Exception {
		String url = BASE_URL + "/movie/" + movieId + "/credits?api_key=" + API_KEY;
		String jsonResponse = makeHttpRequest(url);
		
		List<MovieCastDTO> casts = new ArrayList<>();
		JSONObject json = new JSONObject(jsonResponse);
		JSONArray castArray = json.getJSONArray("cast");
		
		// 상위 10명의 출연진만 수집하여 데이터 양 최소화
		int limit = Math.min(10, castArray.length());
		System.out.println("영화 ID " + movieId + ": " + castArray.length() + "명 중 상위 " + limit + "명만 수집");
		
		for (int i = 0; i < limit; i++) {
			JSONObject castJson = castArray.getJSONObject(i);
			MovieCastDTO cast = new MovieCastDTO();
			cast.setPersonId(String.valueOf(castJson.getInt("id")));
			cast.setMovieId(String.valueOf(movieId));
			cast.setCharacterName(castJson.optString("character", ""));
			cast.setCastOrder(castJson.optInt("order", i));
			casts.add(cast);
		}
		
		return casts;
	}
	
	/**
	 * 인물의 상세 정보 수집
	 */
	private PersonDTO fetchPersonDetails(String personId) throws Exception {
		String url = BASE_URL + "/person/" + personId + "?api_key=" + API_KEY + "&language=ko-KR";
		String jsonResponse = makeHttpRequest(url);
		
		JSONObject json = new JSONObject(jsonResponse);
		
		PersonDTO person = new PersonDTO();
		person.setPersonId(String.valueOf(json.getInt("id")));
		person.setPersonName(json.optString("name", ""));
		person.setBiography(json.optString("biography", ""));
		person.setProfilePath(json.optString("profile_path", null));
		
		return person;
	}
	
	/**
	 * HTTP 요청 실행 (재시도 로직 포함)
	 */
	private String makeHttpRequest(String urlString) throws Exception {
		int maxRetries = 3;
		int retryCount = 0;
		Exception lastException = null;
		
		while (retryCount < maxRetries) {
			try {
				URL url = new URL(urlString);
				HttpURLConnection connection = (HttpURLConnection) url.openConnection();
				try {
					connection.setRequestMethod("GET");
					connection.setConnectTimeout(3000);  // 3초
					connection.setReadTimeout(3000);     // 3초
					connection.setRequestProperty("User-Agent", "Mozilla/5.0");
					
					int responseCode = connection.getResponseCode();
					
					// 429 Too Many Requests인 경우 재시도 대기
					if (responseCode == 429) {
						retryCount++;
						if (retryCount < maxRetries) {
							System.out.println("Rate limit 발생. " + (1000 * retryCount) + "ms 후 재시도...");
							Thread.sleep(1000 * retryCount);
							continue;
						}
						throw new Exception("Rate limit exceeded after retries");
					}
					
					if (responseCode != 200) {
						throw new Exception("HTTP Error: " + responseCode);
					}
					
					try (BufferedReader reader = new BufferedReader(
						new InputStreamReader(connection.getInputStream()))) {
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
				if (retryCount < maxRetries) {
					System.out.println("API 요청 실패 (" + retryCount + "/" + maxRetries + "). 재시도...");
					Thread.sleep(500 * retryCount);
				}
			}
		}
		
		throw new Exception("HTTP 요청 실패 (최대 재시도 초과)", lastException);
	}
	
	/**
	 * 장르 데이터 저장
	 */
	private void saveGenres(List<GenreDTO> genres) {
		GenreDAO genreDAO = new GenreDAOImpl();
		genreDAO.insertGenreBatch(genres);
	}
	
	/**
	 * 영화 데이터 저장
	 */
	private void saveMovies(List<MovieDTO> movies) {
		MovieDAO movieDAO = new MovieDAOImpl();
		movieDAO.insertMovieBatch(movies);
	}
	
	/**
	 * 출연인물 데이터 저장
	 */
	private void savePersons(List<PersonDTO> persons) {
		PersonDAO personDAO = new PersonDAOImpl();
		personDAO.insertPersonBatch(persons);
	}
	
	/**
	 * 영화 출연진 데이터 저장
	 */
	private void saveMovieCasts(List<MovieCastDTO> casts) {
		MovieCastDAO movieCastDAO = new MovieCastDAOImpl();
		movieCastDAO.insertMovieCastBatch(casts);
	}
}
