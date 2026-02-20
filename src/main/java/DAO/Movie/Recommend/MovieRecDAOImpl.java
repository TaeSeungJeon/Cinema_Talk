package DAO.Movie.Recommend;

import java.util.*;

import org.apache.ibatis.session.SqlSession;

import DTO.Movie.Recommend.GenreMovieSection;
import DTO.Movie.Recommend.MovieRecResponse;
import lombok.extern.slf4j.Slf4j;
import mybatis.DBService;

@Slf4j
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
			
			// 로그인 상태일 때
			if(memNo != -1) {
				List<Integer> likeGenreIds = sqlSession.selectList("MovieRecommend.memLikeGenre", memNo);
				
				// 회원이 선호 장르를 설정하지 않았을 때, 랜덤 추천으로 대체
				if(likeGenreIds.isEmpty() || likeGenreIds == null) {
					return sqlSession.selectList("MovieRecommend.randomRec", MOVIESELECT);
				}
				// 회원이 설정한 선호 장르를 기반으로 영화 추천
				Map<String, Object> selLikeGenre = new HashMap<>();
				selLikeGenre.put("likeGenreIds", likeGenreIds);
				selLikeGenre.put("movieLimit", MOVIESELECT);
					
				return sqlSession.selectList("MovieRecommend.memLikeRec", selLikeGenre);
			} else {
				// 비로그인 상태일 때, 랜덤 추천
				return sqlSession.selectList("MovieRecommend.randomRec", MOVIESELECT);
			}
		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}
	
	@Override
	public List<GenreMovieSection> getGenreRecList(int memNo) {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();

			Map<String, Object> selGenre = new HashMap<>();
			    
		    if (memNo != -1) {
		    	List<Integer> likeGenreIds = sqlSession.selectList("MovieRecommend.memLikeGenre", memNo);

		    	selGenre.put("likeGenre", likeGenreIds);
		    }
			selGenre.put("genreLimit", GENRESELECT);   

			List<Integer> genreIds = sqlSession.selectList("MovieRecommend.selGenre", selGenre);
			if (genreIds.isEmpty()) {
			    log.warn("추천 장르가 비어있습니다. memNo={}", memNo);
			    return Collections.emptyList();
			}
			Map<String, Object> movieParam = new HashMap<>();
			movieParam.put("genreIds", genreIds);
			movieParam.put("movieLimit", MOVIESELECT);

			List<MovieRecResponse> rows =
			    sqlSession.selectList("MovieRecommend.genreRec", movieParam);
			
			Map<Integer, GenreMovieSection> sectionMap = new LinkedHashMap<>();
			for(MovieRecResponse row : rows) {
				
				GenreMovieSection section = sectionMap.computeIfAbsent(
				        row.getGenreId(),
				        id -> {
				            GenreMovieSection s = new GenreMovieSection();
				            s.setGenreId(id);
				            s.setSectionGenreName(row.getSectionGenreName());
				            return s;
				        }
				    );
			    section.getMovies().add(row);
			}
		        
			return new ArrayList<>(sectionMap.values());
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