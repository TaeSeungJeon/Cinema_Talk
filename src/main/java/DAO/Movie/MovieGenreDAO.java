package DAO.Movie;

import java.util.List;
import DTO.Movie.MovieGenreDTO;

public interface MovieGenreDAO {
	void insertMovieGenre(MovieGenreDTO movieGenre);
	void insertMovieGenreBatch(List<MovieGenreDTO> movieGenres);
	void mergeMovieGenre(MovieGenreDTO movieGenre);
	boolean existsMovieGenre(int genreId, int movieId);
	List<Integer> getGenreIdsByMovieId(int movie_id);
}
