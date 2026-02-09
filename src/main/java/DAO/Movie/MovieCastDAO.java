package DAO.Movie;

import DTO.Movie.MovieCastDTO;
import java.util.List;

public interface MovieCastDAO {
	void insertMovieCast(MovieCastDTO movieCast);
	void insertMovieCastBatch(List<MovieCastDTO> movieCasts);
	void mergeMovieCast(MovieCastDTO movieCast);
	boolean existsMovieCast(String personId, String movieId);
}
