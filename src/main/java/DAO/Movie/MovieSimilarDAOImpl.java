package DAO.Movie;

import DTO.Movie.MovieSimilarDTO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import mybatis.DBService;

public class MovieSimilarDAOImpl implements MovieSimilarDAO {
	private SqlSessionFactory factory = DBService.getFactory();
	
	@Override
	public void insertMovieSimilar(MovieSimilarDTO movieSimilar) {
		SqlSession session = factory.openSession();
		try {
			session.insert("DAO.Movie.MovieSimilarDAO.insertMovieSimilar", movieSimilar);
			session.commit();
		} finally {
			session.close();
		}
	}
	
	@Override
	public void insertMovieSimilarBatch(List<MovieSimilarDTO> movieSimilars) {
		SqlSession session = factory.openSession();
		try {
			for (MovieSimilarDTO movieSimilar : movieSimilars) {
				session.insert("DAO.Movie.MovieSimilarDAO.insertMovieSimilar", movieSimilar);
			}
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public void mergeMovieSimilar(MovieSimilarDTO movieSimilar) {
		SqlSession session = factory.openSession();
		try {
			session.insert("DAO.Movie.MovieSimilarDAO.mergeMovieSimilar", movieSimilar);
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public boolean existsMovieSimilar(String similarMovieId, String movieId) {
		SqlSession session = factory.openSession();
		try {
			Map<String, String> params = new HashMap<>();
			params.put("similarMovieId", similarMovieId);
			params.put("movieId", movieId);
			Integer count = session.selectOne("DAO.Movie.MovieSimilarDAO.countMovieSimilar", params);
			return count != null && count > 0;
		} finally {
			session.close();
		}
	}
}
