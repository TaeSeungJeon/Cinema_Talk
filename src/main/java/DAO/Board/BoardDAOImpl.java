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

    // --- 추가된 댓글 관련 코드 (DTO 10개 필드 반영된 Mapper 호출) ---

    // 댓글 저장 (commentsIn)
    public int commentsIn(CommentsDTO cdto) {
        SqlSession sqlSession = null;
        int result = 0;
        try {
            sqlSession = getSqlSession();
            // 수정된 Mapper의 10개 컬럼 insert 로직 호출
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

    // 댓글 목록 조회 (commentsList)
    public List<CommentsDTO> commentsList(int boardId) {
        SqlSession sqlSession = null;
        List<CommentsDTO> list = null;
        try {
            sqlSession = getSqlSession();
            // 수정된 Mapper의 10개 컬럼 select 로직 호출
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