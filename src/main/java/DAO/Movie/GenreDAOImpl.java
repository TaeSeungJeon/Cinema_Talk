package DAO.Movie;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import DTO.Movie.GenreDTO;
import mybatis.DBService;

public class GenreDAOImpl implements GenreDAO {
	public static GenreDAOImpl instance = null;
	
	public GenreDAOImpl() {}
	
	public static GenreDAOImpl getInstance() {
		if(instance == null) {
			instance = new GenreDAOImpl();
			return instance;
		} else {
			return instance;
		}
	}
	
	private SqlSession getSqlSession() {		
		return DBService.getFactory().openSession(false);
	}
	
	@Override
	public void insertGenre(GenreDTO genre) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			session.insert("DAO.Movie.GenreDAO.insertGenre", genre);
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}
	
	@Override
	public void insertGenreBatch(List<GenreDTO> genres) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			for (GenreDTO genre : genres) {
				session.insert("DAO.Movie.GenreDAO.insertGenre", genre);
			}
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public void mergeGenre(GenreDTO genre) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			session.insert("DAO.Movie.GenreDAO.mergeGenre", genre);
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public boolean existsGenre(String genreId) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			GenreDTO genre = session.selectOne("DAO.Movie.GenreDAO.selectGenreById", genreId);
			return genre != null;
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public GenreDTO getGenreById(String genreId) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			return session.selectOne("DAO.Movie.GenreDAO.selectGenreById", genreId);
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}
}
