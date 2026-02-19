package DAO.Movie.Recommend;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import DTO.Movie.Recommend.MovieRecResponse;
import mybatis.DBService;

public class MovieRecDAOImpl implements MovieRecDAO {

	private static MovieRecDAOImpl instance = null;
	
	public MovieRecDAOImpl() {}
	
	public static MovieRecDAOImpl getInstance() {
		if(instance == null) {
			instance = new MovieRecDAOImpl();
		}
		return instance;
	}
	
	private SqlSession getSqlSession() {
		return DBService.getFactory().openSession(false);
	}
	public static final int GENRESELECT = 4;
	public static final int MOVIESELECT = 20;
    
	@Override
	public List<MovieRecResponse> getPopularRecList() {
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSession();
				
			List<MovieRecResponse> popRecList = sqlSession.selectList("MovieRecommend.popularRec", MOVIESELECT);
				
			return popRecList;
		} finally {
			if(sqlSession != null) {
					sqlSession.close();
			}
		}
	}
	
	@Override
	public List<MovieRecResponse> getLikeRecList(int memNo) {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
				
			List<Integer> likeGenreIds = sqlSession.selectList("MovieRecommend.memLikeGenre", memNo);
			Map<String, Object> selLikeGenre = new HashMap<>();
			selLikeGenre.put("likeGenreIds", likeGenreIds);
			selLikeGenre.put("movieLimit", MOVIESELECT);
				
			List<MovieRecResponse> likeRecList = sqlSession.selectList("MovieRecommend.memLikeRec", selLikeGenre);

			return likeRecList;
		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}
	
	@Override
	public Map<Integer, List<MovieRecResponse>> getGenreRecList(int memNo) {
		SqlSession sqlSession = null;
	    Map<Integer, List<MovieRecResponse>> genreRecMap = new HashMap<>();

		try {
			sqlSession = getSqlSession();

			List<Integer> genreIds;
			Map<String, Object> selGenre = new HashMap<>();
			    
		    if (memNo != -1) {
		    	List<Integer> likeGenreIds = sqlSession.selectList("MovieRecommend.memLikeGenre", memNo);

		    	selGenre.put("likeGenre", likeGenreIds);
		    }
			selGenre.put("genreLimit", GENRESELECT);   

			genreIds = sqlSession.selectList("MovieRecommend.selGenre", selGenre);
			System.out.println("genreIds: " + genreIds);
			for(int genreId : genreIds) {
				Map<String, Object> param = new HashMap<>();
			    param.put("genreId", genreId);
			    param.put("movieLimit", MOVIESELECT);
			    	
			    List<MovieRecResponse> genreMovie = sqlSession.selectList("MovieRecommend.genreRec", param);
			    	
			    genreRecMap.put(genreId, genreMovie);
			}
		        
			return genreRecMap;
		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<MovieRecResponse> getIndexGenreList(int memNo) {
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSession();
				
			List<MovieRecResponse> indexGenreList = 
					sqlSession.selectList("MovieRecommend.indexGenreMovie", memNo);

			return indexGenreList;
		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<MovieRecResponse> getIndexTrendList() {
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSession();
				
			List<MovieRecResponse> indexTrendList = 
					sqlSession.selectList("MovieRecommend.indexTrendMovie");

			return indexTrendList;
		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}
}