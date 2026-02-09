package DAO.Movie;

import DTO.Movie.MovieGenreDTO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import mybatis.DBService;

public class MovieGenreDAOImpl implements MovieGenreDAO {
	private SqlSessionFactory factory = DBService.getFactory();
	
	@Override
	public void insertMovieGenre(MovieGenreDTO movieGenre) {
		SqlSession session = factory.openSession();
		try {
			session.insert("DAO.Movie.MovieGenreDAO.insertMovieGenre", movieGenre);
			session.commit();
		} finally {
			session.close();
		}
	}
	
	@Override
	public void insertMovieGenreBatch(List<MovieGenreDTO> movieGenres) {
		SqlSession session = factory.openSession();
		try {
			for (MovieGenreDTO movieGenre : movieGenres) {
				session.insert("DAO.Movie.MovieGenreDAO.insertMovieGenre", movieGenre);
			}
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public void mergeMovieGenre(MovieGenreDTO movieGenre) {
		SqlSession session = factory.openSession();
		try {
			session.insert("DAO.Movie.MovieGenreDAO.mergeMovieGenre", movieGenre);
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public boolean existsMovieGenre(String genreId, String movieId) {
		SqlSession session = factory.openSession();
		try {
			Map<String, String> params = new HashMap<>();
			params.put("genreId", genreId);
			params.put("movieId", movieId);
			Integer count = session.selectOne("DAO.Movie.MovieGenreDAO.countMovieGenre", params);
			return count != null && count > 0;
		} finally {
			session.close();
		}
	}
}
