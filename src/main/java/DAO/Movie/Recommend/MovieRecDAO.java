package DAO.Movie.Recommend;

import java.util.List;
import java.util.Map;

import DTO.Movie.Recommend.GenreMovieSection;
import DTO.Movie.Recommend.MovieRecResponse;

public interface MovieRecDAO {

	List<MovieRecResponse> getPopularRecList(int movieLimit);
	
	List<MovieRecResponse> getRandomRecList(int movieLimit);

	List<Integer> getMemberLikeGenres(int memNo);

	List<MovieRecResponse> getLikeGenreRecList(List<Integer> likeGenreIds, int movieLimit);

	List<Integer> selRecGenres(List<Integer> likeGenres, int genreSelect);

	List<MovieRecResponse> selGenreMovies(List<Integer> genreIds, int movieLimit);
		
	List<MovieRecResponse> getIndexGenreList(int memNo);

	List<MovieRecResponse> getIndexTrendList();
	
}