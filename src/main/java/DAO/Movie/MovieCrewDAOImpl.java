package DAO.Movie;

import DTO.Movie.MovieCrewDTO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import mybatis.DBService;

public class MovieCrewDAOImpl implements MovieCrewDAO {
	private SqlSessionFactory factory = DBService.getFactory();
	
	@Override
	public void insertMovieCrew(MovieCrewDTO movieCrew) {
		SqlSession session = factory.openSession();
		try {
			session.insert("DAO.Movie.MovieCrewDAO.insertMovieCrew", movieCrew);
			session.commit();
		} finally {
			session.close();
		}
	}
	
	@Override
	public void insertMovieCrewBatch(List<MovieCrewDTO> movieCrews) {
		SqlSession session = factory.openSession();
		try {
			for (MovieCrewDTO movieCrew : movieCrews) {
				session.insert("DAO.Movie.MovieCrewDAO.insertMovieCrew", movieCrew);
			}
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public void mergeMovieCrew(MovieCrewDTO movieCrew) {
		SqlSession session = factory.openSession();
		try {
			session.insert("DAO.Movie.MovieCrewDAO.mergeMovieCrew", movieCrew);
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public boolean existsMovieCrew(String personId, String movieId) {
		SqlSession session = factory.openSession();
		try {
			Map<String, String> params = new HashMap<>();
			params.put("personId", personId);
			params.put("movieId", movieId);
			Integer count = session.selectOne("DAO.Movie.MovieCrewDAO.countMovieCrew", params);
			return count != null && count > 0;
		} finally {
			session.close();
		}
	}
}
