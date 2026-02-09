package DAO.Movie;


import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import DTO.Movie.MovieDTO;
import mybatis.DBService;

public class MovieDAOImpl implements MovieDAO {
	private SqlSessionFactory factory = DBService.getFactory();
	
	@Override
	public void insertMovie(MovieDTO movie) {
		SqlSession session = factory.openSession();
		try {
			session.insert("DAO.Movie.MovieDAO.insertMovie", movie);
			session.commit();
		} finally {
			session.close();
		}
	}
	
	@Override
	public void insertMovieBatch(List<MovieDTO> movies) {
		SqlSession session = factory.openSession();
		try {
			for (MovieDTO movie : movies) {
				session.insert("DAO.Movie.MovieDAO.insertMovie", movie);
			}
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public void mergeMovie(MovieDTO movie) {
		SqlSession session = factory.openSession();
		try {
			session.insert("DAO.Movie.MovieDAO.mergeMovie", movie);
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public boolean existsMovie(String movieId) {
		SqlSession session = factory.openSession();
		try {
			MovieDTO movie = session.selectOne("DAO.Movie.MovieDAO.selectMovieById", movieId);
			return movie != null;
		} finally {
			session.close();
		}
	}

	@Override
	public MovieDTO getMovieById(String movieId) {
		SqlSession session = factory.openSession();
		try {
			return session.selectOne("DAO.Movie.MovieDAO.selectMovieById", movieId);
		} finally {
			session.close();
		}
	}
}
