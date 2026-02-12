package Service.Movie;

import java.util.List;

import DTO.Movie.MovieDTO;

public interface MovieSearchService {
	List<MovieDTO> getMovieDTOList(MovieDTO searchWords, int searchOption);

	int getRowCount(MovieDTO movie, int searchOption);
}