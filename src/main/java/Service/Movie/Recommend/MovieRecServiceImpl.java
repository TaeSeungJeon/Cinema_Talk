package Service.Movie.Recommend;

import java.util.*;

import DAO.Movie.Recommend.MovieRecDAO;
import DAO.Movie.Recommend.MovieRecDAOImpl;
import DTO.Movie.Recommend.GenreMovieSection;
import DTO.Movie.Recommend.MovieRecResponse;

public class MovieRecServiceImpl implements MovieRecService {

	private MovieRecDAO movieRecDAO = MovieRecDAOImpl.getInstance();
	public static final int GENRESELECT = 4; //장르 선택 개수
	public static final int MOVIELIMIT = 20; //장르당 영화 선택 개수(최대)
	
	// 인기 영화 추천 목록 조회
	@Override
	public List<MovieRecResponse> getPopularRecList() {
		return movieRecDAO.getPopularRecList(MOVIELIMIT);
	}

	// 선호 장르 기반 영화 추천 목록 조회
	@Override
	public List<MovieRecResponse> getLikeRecList(int memNo) {
		
		// 비로그인이면 랜덤 장르 선정
	    if(memNo <= 0) {
	        return movieRecDAO.getRandomRecList(MOVIELIMIT);
	    }

	    List<Integer> likeGenreIds = movieRecDAO.getMemberLikeGenres(memNo);

	    // 선호 장르 없음 → 랜덤
	    if(likeGenreIds == null || likeGenreIds.isEmpty()) {
	        return movieRecDAO.getRandomRecList(MOVIELIMIT);
	    }

	    // 선호 장르 기반 추천
	    return movieRecDAO.getLikeGenreRecList(likeGenreIds, MOVIELIMIT);
	}

	// 선호 장르를 제외한 영화 추천 목록 조회
	@Override
	public List<GenreMovieSection> getRecGenreList(int memNo) {
		List<Integer> likeGenres = null;

	    // 로그인 상태면 선호 장르 조회
	    if(memNo > 0) {
	        likeGenres = movieRecDAO.getMemberLikeGenres(memNo);
	    }

	    // 추천 장르 선정
	    List<Integer> genreIds =
	        movieRecDAO.selRecGenres(likeGenres, GENRESELECT);

	    // 추천 장르 없음 → 빈 리스트 반환
	    if(genreIds == null || genreIds.isEmpty()) {
	        return Collections.emptyList();
	    }

	    // 영화 조회
	    List<MovieRecResponse> rows =
	        movieRecDAO.selGenreMovies(genreIds, MOVIELIMIT);

	    // 섹션 그룹핑하여 반환
	    return groupByGenre(rows);
	}
	
	// 영화 목록을 장르별로 그룹핑
	private List<GenreMovieSection> groupByGenre(List<MovieRecResponse> rows) {
		// 리스트가 null이거나 비어있으면 빈 리스트 반환
	    if (rows == null || rows.isEmpty()) {
	        return Collections.emptyList();
	    }
		
	    Map<Integer, GenreMovieSection> sectionMap = new LinkedHashMap<>();

	    for(MovieRecResponse row : rows) {
	    	if (row == null) continue;
	        GenreMovieSection section =
	            sectionMap.computeIfAbsent(
	                row.getGenreId(),
	                id -> {
	                    GenreMovieSection s = new GenreMovieSection();
	                    s.setGenreId(id);
	                    s.setSectionGenreName(row.getSectionGenreName());
	                    return s;
	                }
	            );
	        section.getMovies().add(row);
	    }

	    return new ArrayList<>(sectionMap.values());
	}
}