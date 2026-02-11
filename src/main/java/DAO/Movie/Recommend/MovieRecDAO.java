package DAO.Movie.Recommend;

import java.util.List;
import java.util.Map;

import DTO.Movie.Recommend.MovieRecResponse;

public interface MovieRecDAO {

	Map<Integer, List<MovieRecResponse>> getGenreRecList(int mem_no);

	List<MovieRecResponse> getPopularRecList();

	List<MovieRecResponse> getLikeRecList(int mem_no);

}
