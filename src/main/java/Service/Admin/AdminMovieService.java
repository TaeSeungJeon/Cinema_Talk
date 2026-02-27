package Service.Admin;

import DTO.Admin.MovieSaveDTO;

public interface AdminMovieService {

	void updateMovie(MovieSaveDTO saveDTO);

	void deleteMovie(int movieId);
}
