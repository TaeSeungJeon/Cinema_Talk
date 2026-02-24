package DAO.Admin;

import org.apache.ibatis.session.SqlSession;

import DTO.Admin.MovieSaveDTO.CastSaveDTO;
import DTO.Admin.MovieSaveDTO.CrewSaveDTO;
import DTO.Movie.MovieDTO;

public interface AdminMovieDAO {
	boolean existsMovie(SqlSession session, int movieId);

    void insertMovie(SqlSession session, MovieDTO movie);

    void updateMovie(SqlSession session, MovieDTO movie);

    void deleteMovieGenres(SqlSession session, int movieId);

    void insertMovieGenre(SqlSession session, int movieId, int genreId);

    void deleteMovieCasts(SqlSession session, int movieId);

    void insertMovieCast(SqlSession session, int movieId, CastSaveDTO cast);

    void deleteMovieCrews(SqlSession session, int movieId);

    void insertMovieCrew(SqlSession session, int movieId, CrewSaveDTO crew);
}
