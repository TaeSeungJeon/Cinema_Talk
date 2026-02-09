package DAO.Movie;

import DTO.Movie.MovieSimilarDTO;
import java.util.List;

public interface MovieSimilarDAO {
	void insertMovieSimilar(MovieSimilarDTO movieSimilar);
	void insertMovieSimilarBatch(List<MovieSimilarDTO> movieSimilars);
	void mergeMovieSimilar(MovieSimilarDTO movieSimilar);
	boolean existsMovieSimilar(String similarMovieId, String movieId);
}
