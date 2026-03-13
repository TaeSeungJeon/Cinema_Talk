package Service.Movie.Recommend;

import java.util.List;
import java.util.Map;

import DTO.Movie.Recommend.GenreMovieSection;
import DTO.Movie.Recommend.MovieRecResponse;

public interface MovieRecService {

	// 인기 영화 추천 리스트 조회
	List<MovieRecResponse> getPopularRecList();

	// 회원 선호 영화 추천 리스트 조회
	List<MovieRecResponse> getLikeRecList(int memNo);
	
	// 회원 선호 제외 장르별 영화 추천 리스트 조회
	List<GenreMovieSection> getRecGenreList(int memNo);

}
