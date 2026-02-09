package DAO.Movie;


import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import DTO.Movie.MovieDTO;
import mybatis.DBService;

public class MovieDAOImpl implements MovieDAO {
	public static MovieDAOImpl instance = null;
	
	public MovieDAOImpl() {}
	
	public static MovieDAOImpl getInstance() {
		if(instance == null) {
			instance = new MovieDAOImpl();
			return instance;
		} else {
			return instance;
		}
	}
	
	private SqlSession getSqlSession() {		
		return DBService.getFactory().openSession(false);
	}
	
	@Override
	public void insertMovie(MovieDTO movie) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			session.insert("DAO.Movie.MovieDAO.insertMovie", movie);
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}
	
	@Override
	public void insertMovieBatch(List<MovieDTO> movies) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			for (MovieDTO movie : movies) {
				session.insert("DAO.Movie.MovieDAO.insertMovie", movie);
			}
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public void mergeMovie(MovieDTO movie) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			session.insert("DAO.Movie.MovieDAO.mergeMovie", movie);
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public boolean existsMovie(String movieId) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			MovieDTO movie = session.selectOne("DAO.Movie.MovieDAO.selectMovieById", movieId);
			return movie != null;
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public MovieDTO getMovieById(String movieId) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			return session.selectOne("DAO.Movie.MovieDAO.selectMovieById", movieId);
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}
}
