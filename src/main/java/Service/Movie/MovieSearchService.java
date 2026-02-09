package Service.Movie;

import java.util.List;

import DTO.Movie.MovieDTO;

public interface MovieSearchService {
	List<MovieDTO> getMovieDTOList_at_genre(String search_words);
	List<MovieDTO> getMovieDTOList_at_title(String search_words);
	List<MovieDTO> getMovieDTOList_at_director(String search_words);
	List<MovieDTO> getMovieDTOList_at_actor(String search_words);
}
