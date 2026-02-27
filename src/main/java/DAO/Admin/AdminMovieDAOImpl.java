package DAO.Admin;

import java.util.*;

import org.apache.ibatis.session.SqlSession;

import DTO.Admin.MovieSaveDTO.CastSaveDTO;
import DTO.Admin.MovieSaveDTO.CrewSaveDTO;
import DTO.Movie.MovieDTO;

public class AdminMovieDAOImpl implements AdminMovieDAO {
	private static final AdminMovieDAOImpl instance =
            new AdminMovieDAOImpl();

    private AdminMovieDAOImpl() {}

    public static AdminMovieDAOImpl getInstance() {
        return instance;
    }

    @Override
    public boolean existsMovie(SqlSession session, int movieId) {
        Integer count =
            session.selectOne("AdminMovieMapper.existsMovie", movieId);
        return count != null && count > 0;
    }

    @Override
    public void updateMovie(SqlSession session, MovieDTO movie) {
        session.update("AdminMovieMapper.updateMovie", movie);
    }

    @Override
    public void deleteMovieGenres(SqlSession session, int movieId) {
        session.delete("AdminMovieMapper.deleteMovieGenres", movieId);
    }

    @Override
    public void insertMovieGenre(SqlSession session,
                                 int movieId,
                                 int genreId) {

        Map<String, Integer> map = new HashMap<>();
        map.put("movieId", movieId);
        map.put("genreId", genreId);

        session.insert("AdminMovieMapper.insertMovieGenre", map);
    }

    @Override
    public void deleteMovieCasts(SqlSession session, int movieId) {
        session.delete("AdminMovieMapper.deleteMovieCasts", movieId);
    }

    @Override
    public void insertMovieCast(SqlSession session,
                                int movieId,
                                CastSaveDTO cast) {

        Map<String, Object> map = new HashMap<>();
        map.put("movieId", movieId);
        map.put("personId", cast.getPersonId());
        map.put("characterName", cast.getCharacterName());
        map.put("castOrder", cast.getCastOrder());

        session.insert("AdminMovieMapper.insertMovieCast", map);
    }

    @Override
    public void deleteMovieCrews(SqlSession session, int movieId) {
        session.delete("AdminMovieMapper.deleteMovieCrews", movieId);
    }

    @Override
    public void insertMovieCrew(SqlSession session,
                                int movieId,
                                CrewSaveDTO crew) {

        Map<String, Object> map = new HashMap<>();
        map.put("movieId", movieId);
        map.put("personId", crew.getPersonId());
        map.put("crewJob", crew.getCrewJob());

        session.insert("AdminMovieMapper.insertMovieCrew", map);
    }

	@Override
	public int deleteMovie(SqlSession session, int movieId) {
		return session.delete("AdminMovieMapper.deleteMovie", movieId);
	}
}
