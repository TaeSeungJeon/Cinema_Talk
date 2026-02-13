package Service;

import java.util.List;

import DTO.Movie.Recommend.MovieRecResponse;

public interface HomeService {

	List<MovieRecResponse> getIndexGenreList(int memNo);

}
