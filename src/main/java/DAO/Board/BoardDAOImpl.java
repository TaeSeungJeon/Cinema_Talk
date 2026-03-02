package DAO.Board;

import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO; // 댓글 DTO 임포트 추가
import mybatis.DBService;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BoardDAOImpl implements BoardDAO {

    private static BoardDAOImpl instance = null;

    public BoardDAOImpl() {
    }

    public static BoardDAOImpl getInstance() {
        if (instance == null) {
            instance = new BoardDAOImpl();
        }
        return instance;
    }

    private SqlSession getSqlSession() {
        return DBService.getFactory().openSession(false);   // false -> 수동 commit 모드
    }

    // --- 기존 게시글 코드 (유지) ---

    @Override
    public void boardIn(BoardDTO bdto) {
        SqlSession sqlSession = null;
        try {
            sqlSession = getSqlSession();
            sqlSession.insert("Board.boardIn", bdto);
            sqlSession.commit();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }

    @Override
    public List<BoardDTO> boardList() {
        SqlSession sqlSession = null;
        List<BoardDTO> boardList = null;
        try {
            sqlSession = getSqlSession();
            boardList = sqlSession.selectList("Board.boardList");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
        return boardList;
    }

    @Override
    public BoardDTO boardCont(int boardId) {
        SqlSession sqlSession = null;
        BoardDTO dto = null;
        try {
            sqlSession = getSqlSession();
            dto = sqlSession.selectOne("Board.boardCont", boardId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
        return dto;
    }

    @Override
    public int updateReadCount(int boardId) {
        SqlSession sqlSession = null;
        int result = 0;
        try {
            sqlSession = getSqlSession();
            result = sqlSession.update("Board.updateReadCount", boardId);
                sqlSession.commit(); // 조건없이 무조건 커밋 (실시간 인기글 반영버그 수정)
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
        return result;
    }

    // Service에서 사용하는 getBoardCont (기존 boardCont 재사용)
    @Override
    public BoardDTO getBoardCont(int boardId) {
        return boardCont(boardId);
    }

    // 게시글 수정
    @Override
    public void updateBoard(BoardDTO bdto) {
        SqlSession sqlSession = null;
        try {
            sqlSession = getSqlSession();
            int result = sqlSession.update("Board.updateBoard", bdto);
            if (result > 0) {
                sqlSession.commit();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }

    // 게시글 삭제
    @Override
    public void deleteBoard(int boardId) {
        SqlSession sqlSession = null;
        try {
            sqlSession = getSqlSession();
            int result = sqlSession.delete("Board.deleteBoard", boardId);
            if (result > 0) {
                sqlSession.commit();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }

    // --- 댓글 관련 코드 (기존 유지) ---

    @Override
    public int commentsIn(CommentsDTO cdto) {
        SqlSession sqlSession = null;
        int result = 0;
        try {
            sqlSession = getSqlSession();
            result = sqlSession.insert("Comments.commentsIn", cdto);
            if (result > 0) {
                sqlSession.commit();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
        return result;
    }

    @Override
    public List<CommentsDTO> commentsList(int boardId) {
        SqlSession sqlSession = null;
        List<CommentsDTO> list = null;
        try {
            sqlSession = getSqlSession();
            list = sqlSession.selectList("Comments.commentsList", boardId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
        return list;
    }

    @Override
    public List<BoardDTO> boardListByType(int boardType) {
        SqlSession sqlSession = null;
        List<BoardDTO> list = null;
        try {
            sqlSession = getSqlSession();
            list = sqlSession.selectList("Board.boardListByType", boardType);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) sqlSession.close();
        }
        return list;
    }

    @Override
    public int getBoardCount() {
        SqlSession sqlSession = null;
        try {
            sqlSession = getSqlSession();
            return sqlSession.selectOne("Board.getBoardCount");
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }

    @Override
    public List<BoardDTO> boardListPage(int startRow, int endRow) {
        SqlSession sqlSession = null;
        try {
            sqlSession = getSqlSession();
            Map<String, Object> param = new HashMap<>();
            param.put("startRow", startRow);
            param.put("endRow", endRow);
            return sqlSession.selectList("Board.boardListPage", param);
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }

    @Override
    public int getBoardCountByType(int boardType) {
        SqlSession sqlSession = null;
        try {
            sqlSession = getSqlSession();
            return sqlSession.selectOne("Board.getBoardCountByType", boardType);
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }

    /* 좋아요 */
    @Override
    public int isBoardLiked(int boardId, int boardType, int memNo) {
        SqlSession sqlSession = null;
        try {
            sqlSession = getSqlSession();
            Map<String, Object> param = new HashMap<>();
            param.put("boardId", boardId);
            param.put("boardType", boardType);
            param.put("memNo", memNo);
            return sqlSession.selectOne("Board.isBoardLiked", param);
        } finally {
            if (sqlSession != null) sqlSession.close();
        }
    }

    @Override
    public int insertBoardLike(int boardId, int boardType, int memNo) {
        SqlSession sqlSession = null;
        try {
            sqlSession = getSqlSession();
            Map<String, Object> param = new HashMap<>();
            param.put("boardId", boardId);
            param.put("boardType", boardType);
            param.put("memNo", memNo);
            int result = sqlSession.insert("Board.insertBoardLike", param);
            if (result > 0) sqlSession.commit();
            return result;
        } finally {
            if (sqlSession != null) sqlSession.close();
        }
    }

    @Override
    public void deleteBoardLike(int boardId, int memNo) {

    }

    @Override
    public int deleteBoardLike(int boardId, int boardType, int memNo) {
        SqlSession sqlSession = null;
        try {
            sqlSession = getSqlSession();
            Map<String, Object> param = new HashMap<>();
            param.put("boardId", boardId);
            param.put("boardType", boardType);
            param.put("memNo", memNo);
            int result = sqlSession.delete("Board.deleteBoardLike", param);
            if (result > 0) sqlSession.commit();
            return result;
        } finally {
            if (sqlSession != null) sqlSession.close();
        }
    }

    @Override
    public int getBoardLikeCount(int boardId, int boardType) {
        SqlSession sqlSession = null;
        try {
            sqlSession = getSqlSession();
            Map<String, Object> param = new HashMap<>();
            param.put("boardId", boardId);
            param.put("boardType", boardType);
            return sqlSession.selectOne("Board.getBoardLikeCount", param);
        } finally {
            if (sqlSession != null) sqlSession.close();
        }
    }

    // 실시간 인기 글
    @Override
    public List<BoardDTO> hotBoardList(int limit) {

        SqlSession sqlSession = null;

        try {
            sqlSession = getSqlSession();
            return sqlSession.selectList("Board.hotBoardList", limit);

        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }

    @Override
    public List<BoardDTO> boardListPageByType(int boardType, int startRow, int endRow) {
        SqlSession sqlSession = null;
        try {
            sqlSession = getSqlSession();
            Map<String, Object> param = new HashMap<>();
            param.put("boardType", boardType);
            param.put("startRow", startRow);
            param.put("endRow", endRow);
            return sqlSession.selectList("Board.boardListPageByType", param);
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }

    @Override
    public List<BoardDTO> recentBoardList(int limit) {
        SqlSession sqlSession = null;
        try {
            sqlSession = getSqlSession();
            return sqlSession.selectList("Board.recentBoardList", limit);
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }


}
