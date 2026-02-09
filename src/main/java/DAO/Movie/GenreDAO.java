package DAO.Movie;

import DTO.Movie.GenreDTO;
import java.util.List;

public interface GenreDAO {
	void insertGenre(GenreDTO genre);
	void insertGenreBatch(List<GenreDTO> genres);
	void mergeGenre(GenreDTO genre);
	boolean existsGenre(String genreId);
	GenreDTO getGenreById(String genreId);
}
