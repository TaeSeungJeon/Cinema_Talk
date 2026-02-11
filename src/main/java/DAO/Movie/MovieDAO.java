package DAO.Movie;

import DTO.Movie.MovieDTO;
import java.util.List;

public interface MovieDAO {
	void insertMovie(MovieDTO movie);
	void insertMovieBatch(List<MovieDTO> movies);
	void mergeMovie(MovieDTO movie);
	boolean existsMovie(int movieId);
	MovieDTO getMovieById(int movieId);
	
	List<MovieDTO> getMovieDTOList(List<String> searchWords, int searchOption, int startrow, int endrow);
	int getRowCount(List<String> words, int searchOption);
	MovieDTO getMovieDetail(int movieId);
}