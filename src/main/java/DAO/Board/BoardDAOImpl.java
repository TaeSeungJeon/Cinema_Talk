package DAO.Board;

import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO; // 댓글 DTO 임포트 추가
import mybatis.DBService;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

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
            if(result > 0) {
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
}
