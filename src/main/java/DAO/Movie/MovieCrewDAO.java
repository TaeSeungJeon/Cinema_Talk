package DAO.Movie;

import DTO.Movie.MovieCrewDTO;
import DTO.Movie.MovieDetailDTO.CrewInfoDTO;
import java.util.List;

public interface MovieCrewDAO {
	void insertMovieCrew(MovieCrewDTO movieCrew);
	void insertMovieCrewBatch(List<MovieCrewDTO> movieCrews);
	void mergeMovieCrew(MovieCrewDTO movieCrew);
	boolean existsMovieCrew(int personId, int movieId);
	List<CrewInfoDTO> getDirectorsByMovieId(int movieId);
}
