package DAO.Movie;

import DTO.Movie.MovieCrewDTO;
import java.util.List;

public interface MovieCrewDAO {
	void insertMovieCrew(MovieCrewDTO movieCrew);
	void insertMovieCrewBatch(List<MovieCrewDTO> movieCrews);
	void mergeMovieCrew(MovieCrewDTO movieCrew);
	boolean existsMovieCrew(String personId, String movieId);
}
