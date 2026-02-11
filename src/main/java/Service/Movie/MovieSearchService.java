package Service.Movie;

import java.util.List;

import DTO.Movie.MovieDTO;

public interface MovieSearchService {
	List<MovieDTO> getMovieDTOList(MovieDTO search_words, int search_option);

	int getRowCount(MovieDTO movie, int search_option);
}