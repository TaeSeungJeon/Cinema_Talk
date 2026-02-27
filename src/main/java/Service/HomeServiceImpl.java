package Service;

import java.util.List;

import DAO.HomeDAO;
import DAO.HomeDAOImpl;
import DAO.Movie.Recommend.MovieRecDAO;
import DAO.Movie.Recommend.MovieRecDAOImpl;
import DTO.Movie.Recommend.MovieRecResponse;

public class HomeServiceImpl implements HomeService {

	private MovieRecDAO movieRecDAO = MovieRecDAOImpl.getInstance();
	private HomeDAO homeDAO = HomeDAOImpl.getInstance();
	
	@Override
	public List<MovieRecResponse> getIndexGenreList(int memNo) {
		return movieRecDAO.getIndexGenreList(memNo);
	}

	@Override
	public List<MovieRecResponse> getIndexTrendList() {
		return movieRecDAO.getIndexTrendList();
	}

	@Override
	public void increaseTodayDau() {
		homeDAO.increaseTodayDau();
	}

}
