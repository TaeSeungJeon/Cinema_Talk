package DAO.Member.MyPage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import DTO.Member.MemberDTO;
import DTO.Movie.GenreDTO;
import DTO.Movie.MovieDTO;
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

	@Override
	public void updateMemberInfo(MemberDTO mdto) {
		SqlSession sqlSession = getSqlSession();
		try {
			sqlSession.update("MyPage.updateMemberInfo", mdto);
			sqlSession.commit();
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<Integer> getBoardCommentCountByMemNo(int boardId) {
		SqlSession sqlSession = getSqlSession();
		try {
			return sqlSession.selectList("MyPage.getBoardCommentsCount", boardId);
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<VoteRecordDTO> getVoteCommentListByMemNo(int memNo) {
		SqlSession sqlSession = getSqlSession();
		try {
			return sqlSession.selectList("MyPage.getVoteCommentListByMemNo", memNo);
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<MovieDTO> getLikedMoviesByMemNo(int memNo) {
		SqlSession sqlSession = getSqlSession();
		try {
			return sqlSession.selectList("MyPage.getLikedMoviesByMemNo", memNo);
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<BoardDTO> getLikedBoardsByMemNo(int memNo) {
		SqlSession sqlSession = getSqlSession();
		try {
			return sqlSession.selectList("MyPage.getLikedBoardsByMemNo", memNo);
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<GenreDTO> getAllGenres() {
		SqlSession sqlSession = getSqlSession();
		try {
			return sqlSession.selectList("MyPage.getAllGenres");
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<Integer> getPreferredGenreIds(int memNo) {
		SqlSession sqlSession = getSqlSession();
		try {
			return sqlSession.selectList("MyPage.getPreferredGenreIds", memNo);
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public void deletePreferredGenres(int memNo) {
		SqlSession sqlSession = getSqlSession();
		try {
			sqlSession.delete("MyPage.deletePreferredGenres", memNo);
			sqlSession.commit();
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public void insertPreferredGenre(int memNo, int genreId) {
		SqlSession sqlSession = getSqlSession();
		try {
			Map<String, Integer> params = new HashMap<>();
			params.put("memNo", memNo);
			params.put("genreId", genreId);
			sqlSession.insert("MyPage.insertPreferredGenre", params);
			sqlSession.commit();
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}

}