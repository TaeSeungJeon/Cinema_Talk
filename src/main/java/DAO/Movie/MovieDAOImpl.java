package DAO.Movie;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
			session.insert("insertMovie", movie);
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
				session.insert("insertMovie", movie);
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
			session.insert("mergeMovie", movie);
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public boolean existsMovie(int movieId) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			MovieDTO movie = session.selectOne("selectMovieById", movieId);
			return movie != null;
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public MovieDTO getMovieById(int movieId) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			return session.selectOne("selectMovieById", movieId);
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public List<MovieDTO> getMovieDTOList(List<String> searchWords, int searchOption, int startrow, int endrow) {
		SqlSession session = null;
		List<MovieDTO> movies = null;
		
		// 빈 리스트 검사
		if(searchWords == null || searchWords.isEmpty()) {
			return null;
		}
		
		try {
			session = getSqlSession();
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("wordList", searchWords);
			paramMap.put("startrow", startrow);
			paramMap.put("endrow", endrow);
			
			switch(searchOption) {
				case 0:
					movies = session.selectList("searchByTitle", paramMap); 
					break;
				case 1:
					movies = session.selectList("searchByDirector", paramMap);
					break;
				case 2:
					movies = session.selectList("searchByActor", paramMap);
					break;
				case 3:
					movies = session.selectList("searchByGenre", paramMap);
					break;
			}

		} finally {
			if(session != null) {
				session.close();
			}
		}
		return movies;
	}

	@Override
	public int getRowCount(List<String> words, int searchOption) {
		SqlSession sqlSession = null;
		try {
			sqlSession = getSqlSession();
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("wordList", words);
			paramMap.put("searchOption", searchOption);
			
			return sqlSession.selectOne("movie_count", paramMap);
		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public MovieDTO getMovieDetail(int movieId) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			return session.selectOne("selectMovieById", movieId);

		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public List<MovieDTO> searchAdminMovies(String keyword) {
		try (SqlSession session = getSqlSession()) {
	        return session.selectList("searchAdminMovies", keyword);
	    }
	}
}