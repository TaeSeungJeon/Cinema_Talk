package Service.Movie.Recommend;

import java.util.List;
import java.util.Map;

import DAO.Movie.Recommend.MovieRecDAO;
import DAO.Movie.Recommend.MovieRecDAOImpl;
import DTO.Movie.Recommend.GenreMovieSection;
import DTO.Movie.Recommend.MovieRecResponse;

public class MovieRecServiceImpl implements MovieRecService {

	private MovieRecDAO movieRecDAO = MovieRecDAOImpl.getInstance();

	@Override
	public List<MovieRecResponse> getPopularRecList() {
		return movieRecDAO.getPopularRecList();
	}

	@Override
	public List<MovieRecResponse> getLikeRecList(int memNo) {
		return movieRecDAO.getLikeRecList(memNo);
	}

	@Override
	public List<GenreMovieSection> getGenreRecList(int memNo) {
		return movieRecDAO.getGenreRecList(memNo);
	}
}