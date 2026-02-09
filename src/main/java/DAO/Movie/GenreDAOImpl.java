package DAO.Movie;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import DTO.Movie.GenreDTO;
import mybatis.DBService;

public class GenreDAOImpl implements GenreDAO {
	private SqlSessionFactory factory = DBService.getFactory();
	
	@Override
	public void insertGenre(GenreDTO genre) {
		SqlSession session = factory.openSession();
		try {
			session.insert("DAO.Movie.GenreDAO.insertGenre", genre);
			session.commit();
		} finally {
			session.close();
		}
	}
	
	@Override
	public void insertGenreBatch(List<GenreDTO> genres) {
		SqlSession session = factory.openSession();
		try {
			for (GenreDTO genre : genres) {
				session.insert("DAO.Movie.GenreDAO.insertGenre", genre);
			}
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public void mergeGenre(GenreDTO genre) {
		SqlSession session = factory.openSession();
		try {
			session.insert("DAO.Movie.GenreDAO.mergeGenre", genre);
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public boolean existsGenre(String genreId) {
		SqlSession session = factory.openSession();
		try {
			GenreDTO genre = session.selectOne("DAO.Movie.GenreDAO.selectGenreById", genreId);
			return genre != null;
		} finally {
			session.close();
		}
	}

	@Override
	public GenreDTO getGenreById(String genreId) {
		SqlSession session = factory.openSession();
		try {
			return session.selectOne("DAO.Movie.GenreDAO.selectGenreById", genreId);
		} finally {
			session.close();
		}
	}
}
