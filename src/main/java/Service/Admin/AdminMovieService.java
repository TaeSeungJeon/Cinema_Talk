package Service.Admin;

import DTO.Admin.Movie.MovieSaveDTO;

public interface AdminMovieService {

	void updateMovie(MovieSaveDTO saveDTO);

	void deleteMovie(int movieId);
}
