package DAO.Movie;

import DTO.Movie.GenreDTO;
import java.util.List;

public interface GenreDAO {
	void insertGenre(GenreDTO genre);
	void insertGenreBatch(List<GenreDTO> genres);
	void mergeGenre(GenreDTO genre);
	boolean existsGenre(int genreId);
	GenreDTO getGenreById(int genreId);
	List<GenreDTO> getAllGenres();
}
