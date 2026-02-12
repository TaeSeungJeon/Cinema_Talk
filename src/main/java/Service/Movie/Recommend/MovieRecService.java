package Service.Movie.Recommend;

import java.util.List;
import java.util.Map;

import DTO.Movie.Recommend.MovieRecResponse;

public interface MovieRecService {

	Map<Integer, List<MovieRecResponse>> getGenreRecList(int memNo);

	List<MovieRecResponse> getPopularRecList();

	List<MovieRecResponse> getLikeRecList(int memNo);

}
