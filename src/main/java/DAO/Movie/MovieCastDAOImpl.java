package DAO.Movie;

import java.util.List;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import DTO.Movie.MovieCastDTO;
import mybatis.DBService;

public class MovieCastDAOImpl implements MovieCastDAO {
	public static MovieCastDAOImpl instance = null;
	
	public MovieCastDAOImpl() {}
	
	public static MovieCastDAOImpl getInstance() {
		if(instance == null) {
			instance = new MovieCastDAOImpl();
			return instance;
		} else {
			return instance;
		}
	}
	
	private SqlSession getSqlSession() {		
		return DBService.getFactory().openSession(false);
	}
	
	@Override
	public void insertMovieCast(MovieCastDTO movieCast) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			session.insert("DAO.Movie.MovieCastDAO.insertMovieCast", movieCast);
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}
	
	@Override
	public void insertMovieCastBatch(List<MovieCastDTO> movieCasts) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			for (MovieCastDTO movieCast : movieCasts) {
				session.insert("DAO.Movie.MovieCastDAO.insertMovieCast", movieCast);
			}
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public void mergeMovieCast(MovieCastDTO movieCast) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			session.insert("DAO.Movie.MovieCastDAO.mergeMovieCast", movieCast);
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public boolean existsMovieCast(String personId, String movieId) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			Map<String, String> params = new HashMap<>();
			params.put("personId", personId);
			params.put("movieId", movieId);
			Integer count = session.selectOne("DAO.Movie.MovieCastDAO.countMovieCast", params);
			return count != null && count > 0;
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}
}
