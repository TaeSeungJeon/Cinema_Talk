package DAO.Movie.Recommend;

import java.util.*;

import org.apache.ibatis.session.SqlSession;

import DTO.Movie.Recommend.MovieRecResponse;
import lombok.extern.slf4j.Slf4j;
import mybatis.DBService;

@Slf4j
public class MovieRecDAOImpl implements MovieRecDAO {

	private static MovieRecDAOImpl instance = null;

	public MovieRecDAOImpl() {}

	public static MovieRecDAOImpl getInstance() {
		if (instance == null) {
			instance = new MovieRecDAOImpl();
		}
		return instance;
	}

	private SqlSession getSqlSession() {
		return DBService.getFactory().openSession(false);
	}

	// 인기 영화 추천 목록 조회
	@Override
	public List<MovieRecResponse> getPopularRecList(int movieLimit) {
		
		validateMovieLimit(movieLimit);
		
		try (SqlSession sqlSession = getSqlSession()) {
			return sqlSession.selectList("MovieRecommend.popularRec", movieLimit);
		} catch (RuntimeException e) {
		    log.error("getPopularRecList 메서드 실패. movieLimit={}", movieLimit, e);
		    throw new RuntimeException("DB Error - getPopularRecList", e);
		}
	}

	// 회원 선호 장르 조회
	@Override
	public List<Integer> getMemberLikeGenres(int memNo) {
		try (SqlSession sqlSession = getSqlSession()) {
			return sqlSession.selectList("MovieRecommend.memLikeGenre", memNo);
		}catch (RuntimeException e) {
		    log.error("getMemberLikeGenres 메서드 실패. memNo={}", memNo, e);
		    throw new RuntimeException("DB Error - getMemberLikeGenres", e);
		}
	}

	// 랜덤 영화 추천 목록 조회
	@Override
	public List<MovieRecResponse> getRandomRecList(int movieLimit) {
		
		validateMovieLimit(movieLimit);
		
		try (SqlSession sqlSession = getSqlSession()) {
			return sqlSession.selectList("MovieRecommend.randomRec", movieLimit);
		}catch (RuntimeException e) {
		    log.error("getRandomRecList 메서드 실패. movieLimit={}", movieLimit, e);
		    throw new RuntimeException("DB Error - getRandomRecList", e);
		}
	}

	// 선호 장르 기반 영화 추천 목록 조회
	@Override
	public List<MovieRecResponse> getLikeGenreRecList(List<Integer> genreIds, int movieLimit) {

		validateMovieLimit(movieLimit);
		
		try (SqlSession sqlSession = getSqlSession()) {
			Map<String, Object> param = new HashMap<>();
			param.put("likeGenreIds", genreIds);
			param.put("movieLimit", movieLimit);

			return sqlSession.selectList("MovieRecommend.memLikeRec", param);
		}catch (RuntimeException e) {
		    log.error("getLikeGenreRecList 메서드 실패. movieLimit={}", movieLimit, e);
		    throw new RuntimeException("DB Error - getLikeGenreRecList", e);
		}
	}

	// 추천 장르 선정
	@Override
	public List<Integer> selRecGenres(List<Integer> likeGenres, int genreSelect) {

		validateGenreSelect(genreSelect);
		
		try (SqlSession sqlSession = getSqlSession()) {
			Map<String, Object> param = new HashMap<>();
			param.put("likeGenre", likeGenres);
			param.put("genreLimit", genreSelect);

			return sqlSession.selectList("MovieRecommend.selRecGenre", param);
		} catch (RuntimeException e) {
		    log.error("selRecGenres 메서드 실패. genreSelect={}", genreSelect, e);
		    throw new RuntimeException("DB Error - selRecGenres", e);
		}
	}

	// 장르별 영화 추천 목록 조회
	@Override
	public List<MovieRecResponse> selGenreMovies(List<Integer> genreIds, int movieLimit) {

		validateMovieLimit(movieLimit);
		
		try (SqlSession sqlSession = getSqlSession()) {
			Map<String, Object> param = new HashMap<>();
			param.put("genreIds", genreIds);
			param.put("movieLimit", movieLimit);

			return sqlSession.selectList("MovieRecommend.genreRec", param);
		} catch (RuntimeException e) {
		    log.error("selGenreMovies. movieLimit={}", movieLimit, e);
		    throw new RuntimeException("DB Error - selGenreMovies", e);
		}
	}

	// 인덱스 페이지용 장르별 영화 추천 섹션 조회
	@Override
	public List<MovieRecResponse> getIndexGenreList(int memNo) {

		try (SqlSession sqlSession = getSqlSession()) {
			List<MovieRecResponse> indexGenreList = sqlSession.selectList("MovieRecommend.indexGenreMovie", memNo);

			return indexGenreList;
		} catch (RuntimeException e) {
		    log.error("getIndexGenreList 메서드 실패. memNo={}", memNo, e);
		    throw new RuntimeException("DB Error - getIndexGenreList", e);
		}
	}

	// 인덱스 페이지용 트렌드 영화 추천 섹션 조회
	@Override
	public List<MovieRecResponse> getIndexTrendList() {

		try (SqlSession sqlSession = getSqlSession()) {
			List<MovieRecResponse> indexTrendList = sqlSession.selectList("MovieRecommend.indexTrendMovie");

			return indexTrendList;
		} catch (RuntimeException e) {
		    log.error("getIndexTrendList 메서드 실패.", e);
		    throw new RuntimeException("DB Error - getIndexTrendList", e);
		}
	}
	
	//영화 선택 개수가 0이하인 경우 예외 처리 메서드
	private void validateMovieLimit(int movieLimit) {
	    if (movieLimit <= 0) {
	        throw new IllegalArgumentException("영화 조회 개수는 양수여야 합니다.");
	    }
	}
	
	private void validateGenreSelect(int genreSelect) {
	    if (genreSelect <= 0) {
	        throw new IllegalArgumentException("장르를 선택할 개수는 양수여야 합니다.");
	    }
	}
}