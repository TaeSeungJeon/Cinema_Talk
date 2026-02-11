package DAO.Movie;

import DTO.Movie.MovieDTO;
import java.util.List;

public interface MovieDAO {
	void insertMovie(MovieDTO movie);
	void insertMovieBatch(List<MovieDTO> movies);
	void mergeMovie(MovieDTO movie);
	boolean existsMovie(int movieId);
	MovieDTO getMovieById(int movieId);
	
	List<MovieDTO> getMovieDTOList(List<String> search_words, int search_option, int startrow, int endrow);
	int getRowCount(List<String> words, int search_option);
	MovieDTO getMovieDetail(int movie_id);
}