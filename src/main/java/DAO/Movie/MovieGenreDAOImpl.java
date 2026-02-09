package DAO.Movie;

import DTO.Movie.MovieGenreDTO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import mybatis.DBService;

public class MovieGenreDAOImpl implements MovieGenreDAO {
	public static MovieGenreDAOImpl instance = null;
	
	public MovieGenreDAOImpl() {}
	
	public static MovieGenreDAOImpl getInstance() {
		if(instance == null) {
			instance = new MovieGenreDAOImpl();
			return instance;
		} else {
			return instance;
		}
	}
	
	private SqlSession getSqlSession() {		
		return DBService.getFactory().openSession(false);
	}
	
	@Override
	public void insertMovieGenre(MovieGenreDTO movieGenre) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			session.insert("DAO.Movie.MovieGenreDAO.insertMovieGenre", movieGenre);
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}
	
	@Override
	public void insertMovieGenreBatch(List<MovieGenreDTO> movieGenres) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			for (MovieGenreDTO movieGenre : movieGenres) {
				session.insert("DAO.Movie.MovieGenreDAO.insertMovieGenre", movieGenre);
			}
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public void mergeMovieGenre(MovieGenreDTO movieGenre) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			session.insert("DAO.Movie.MovieGenreDAO.mergeMovieGenre", movieGenre);
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public boolean existsMovieGenre(String genreId, String movieId) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			Map<String, String> params = new HashMap<>();
			params.put("genreId", genreId);
			params.put("movieId", movieId);
			Integer count = session.selectOne("DAO.Movie.MovieGenreDAO.countMovieGenre", params);
			return count != null && count > 0;
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}
}
