package DAO.Member.MovieRecommend;

import org.apache.ibatis.session.SqlSession;

import DTO.Member.MovieRecommend.MemberMovieRecommendDTO;
import mybatis.DBService;

public class MemberMovieRecommendDAOImpl implements MemberMovieRecommendDAO {
		private static MemberMovieRecommendDAOImpl instance = null;
		

		public MemberMovieRecommendDAOImpl() {}
		
		public static MemberMovieRecommendDAOImpl getInstance() {
			if(instance ==  null) {
				instance = new MemberMovieRecommendDAOImpl();
			}
			return instance;
		}
		
		private SqlSession getSqlSession() {
			return DBService.getFactory().openSession(false); 
		}

		@Override
		public void addRecommend(MemberMovieRecommendDTO mmrDto) {
			SqlSession sqlSession = getSqlSession();
			try {
				sqlSession.insert("MemberMovieRecommend.addRecommend", mmrDto);
				sqlSession.commit();
			} finally {
				if(sqlSession != null) {
					sqlSession.close();
				}
			}
		}

		@Override
		public void removeRecommend(MemberMovieRecommendDTO mmrDto) {
			SqlSession sqlSession = getSqlSession();
			try {
				sqlSession.delete("MemberMovieRecommend.removeRecommend", mmrDto);
				sqlSession.commit();
			} finally {
				if(sqlSession != null) {
					sqlSession.close();
				}
			}
		}

		@Override
		public boolean isFavorite(MemberMovieRecommendDTO mmrDto) {
			SqlSession sqlSession = getSqlSession();
			try {
				int count = sqlSession.selectOne("MemberMovieRecommend.isFavorite", mmrDto);
				return count > 0;
			} finally {
				if(sqlSession != null) {
					sqlSession.close();
				}
			}
		}

		@Override
		public int getFavoriteCount(int movieId) {
			SqlSession sqlSession = getSqlSession();
			try {
				return sqlSession.selectOne("MemberMovieRecommend.getFavoriteCount", movieId);
			} finally {
				if(sqlSession != null) {
					sqlSession.close();
				}
			}
		}		
}