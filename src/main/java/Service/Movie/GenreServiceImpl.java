package Service.Movie;

import java.util.List;

import DAO.Movie.GenreDAO;
import DAO.Movie.GenreDAOImpl;
import DTO.Movie.GenreDTO;

public class GenreServiceImpl implements GenreService {

	private GenreDAO genreDAO = GenreDAOImpl.getInstance();
	
	@Override
	public List<GenreDTO> getAllGenres() {
		return genreDAO.getAllGenres();
	}

}
