package DAO.Movie;

import DTO.Movie.MovieDTO;
import java.util.List;

public interface MovieDAO {
	void insertMovie(MovieDTO movie);
	void insertMovieBatch(List<MovieDTO> movies);
	void mergeMovie(MovieDTO movie);
	boolean existsMovie(String movieId);
	MovieDTO getMovieById(String movieId);
}
