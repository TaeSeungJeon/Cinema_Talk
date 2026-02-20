package DAO.Movie.Recommend;

import java.util.List;
import java.util.Map;

import DTO.Movie.Recommend.GenreMovieSection;
import DTO.Movie.Recommend.MovieRecResponse;

public interface MovieRecDAO {

	List<MovieRecResponse> getPopularRecList();

	List<MovieRecResponse> getLikeRecList(int memNo);
	
	List<GenreMovieSection> getGenreRecList(int memNo);

	List<MovieRecResponse> getIndexGenreList(int memNo);

	List<MovieRecResponse> getIndexTrendList();

}
