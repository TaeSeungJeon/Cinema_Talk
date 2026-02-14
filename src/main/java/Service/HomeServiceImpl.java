package Service;

import java.util.List;

import DAO.Movie.Recommend.MovieRecDAO;
import DAO.Movie.Recommend.MovieRecDAOImpl;
import DTO.Movie.Recommend.MovieRecResponse;

public class HomeServiceImpl implements HomeService {

	MovieRecDAO movieRecDAO = new MovieRecDAOImpl();
	
	@Override
	public List<MovieRecResponse> getIndexGenreList(int memNo) {
		return movieRecDAO.getIndexGenreList(memNo);
	}

	@Override
	public List<MovieRecResponse> getIndexTrendList() {
		return movieRecDAO.getIndexTrendList();
	}

}
