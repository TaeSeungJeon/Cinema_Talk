package DAO.Member.MyPage;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import DTO.Vote.VoteRecordDTO;
import mybatis.DBService;

public class MyPageDAOImpl implements MyPageDAO {
	
	private static MyPageDAOImpl instance = null;
	
	public MyPageDAOImpl() {}
	
	public static MyPageDAOImpl getInstance() {
		if (instance == null) {
			instance = new MyPageDAOImpl();
		}
		return instance;
	}
	
	private SqlSession getSqlSession() {
		return DBService.getFactory().openSession(false);
	}

	@Override
	public List<BoardDTO> getBoardListByMemNo(int memNo) {
		SqlSession sqlSession = getSqlSession();
		try {
			return sqlSession.selectList("MyPage.getBoardListByMemNo", memNo);
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public int getBoardCountByMemNo(int memNo) {
		SqlSession sqlSession = getSqlSession();
		try {
			return sqlSession.selectOne("MyPage.getBoardCountByMemNo", memNo);
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<CommentsDTO> getCommentListByMemNo(int memNo) {
		SqlSession sqlSession = getSqlSession();
		try {
			return sqlSession.selectList("MyPage.getCommentListByMemNo", memNo);
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public int getCommentCountByMemNo(int memNo) {
		SqlSession sqlSession = getSqlSession();
		try {
			return sqlSession.selectOne("MyPage.getCommentCountByMemNo", memNo);
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<VoteRecordDTO> getVoteRecordListByMemNo(int memNo) {
		SqlSession sqlSession = getSqlSession();
		try {
			return sqlSession.selectList("MyPage.getVoteRecordListByMemNo", memNo);
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public int getVoteCountByMemNo(int memNo) {
		SqlSession sqlSession = getSqlSession();
		try {
			return sqlSession.selectOne("MyPage.getVoteCountByMemNo", memNo);
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}
	
}