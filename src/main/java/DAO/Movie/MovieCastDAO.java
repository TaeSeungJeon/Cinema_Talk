package DAO.Movie;

import DTO.Movie.MovieCastDTO;
import DTO.Movie.MovieDetailDTO.CastInfoDTO;
import java.util.List;

public interface MovieCastDAO {
	void insertMovieCast(MovieCastDTO movieCast);
	void insertMovieCastBatch(List<MovieCastDTO> movieCasts);
	void mergeMovieCast(MovieCastDTO movieCast);
	boolean existsMovieCast(int personId, int movieId);
	List<Integer> getPersonIdByMovieId(int movieId);
	List<CastInfoDTO> getCastInfoByMovieId(int movieId);
}
