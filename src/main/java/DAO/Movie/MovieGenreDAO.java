package DAO.Movie;

import DTO.Movie.MovieGenreDTO;
import java.util.List;

public interface MovieGenreDAO {
	void insertMovieGenre(MovieGenreDTO movieGenre);
	void insertMovieGenreBatch(List<MovieGenreDTO> movieGenres);
	void mergeMovieGenre(MovieGenreDTO movieGenre);
	boolean existsMovieGenre(String genreId, String movieId);
}
