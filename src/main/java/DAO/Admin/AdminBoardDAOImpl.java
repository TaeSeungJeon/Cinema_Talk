package DAO.Admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import mybatis.DBService;

public class AdminBoardDAOImpl implements AdminBoardDAO {

    private static AdminBoardDAOImpl instance;

    private AdminBoardDAOImpl() {}

    public static AdminBoardDAOImpl getInstance() {
        if (instance == null) {
            instance = new AdminBoardDAOImpl();
        }
        return instance;
    }

    private SqlSession getSqlSession() {
        return DBService.getFactory().openSession(false);
    }

    @Override
    public int getBoardCount(String searchType, String keyword) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            Map<String, Object> param = new HashMap<>();
            param.put("searchType", searchType);
            param.put("keyword", keyword);
            return session.selectOne("AdminBoard.getBoardCount", param);
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public List<BoardDTO> getBoardList(String sort, String searchType, String keyword,
                                        int startRow, int endRow) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            Map<String, Object> param = new HashMap<>();
            param.put("sort", sort);
            param.put("searchType", searchType);
            param.put("keyword", keyword);
            param.put("startRow", startRow);
            param.put("endRow", endRow);
            return session.selectList("AdminBoard.getBoardList", param);
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public BoardDTO getBoardDetail(int boardId) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            return session.selectOne("AdminBoard.getBoardDetail", boardId);
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public List<CommentsDTO> getBoardComments(int boardId) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            return session.selectList("AdminBoard.getBoardComments", boardId);
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public int updateBoard(BoardDTO dto) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            int result = session.update("AdminBoard.updateBoard", dto);
            if (result > 0) session.commit();
            return result;
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public int deleteBoard(int boardId) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            // 댓글 좋아요 삭제
            session.delete("AdminBoard.deleteBoardCommentLikes", boardId);
            // 댓글 삭제
            session.delete("AdminBoard.deleteBoardComments", boardId);
            // 게시글 좋아요 삭제
            session.delete("AdminBoard.deleteBoardLikes", boardId);
            // 게시글 삭제
            int result = session.delete("AdminBoard.deleteBoard", boardId);
            if (result > 0) session.commit();
            else session.rollback();
            return result;
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public int updateComment(CommentsDTO dto) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            int result = session.update("AdminBoard.updateComment", dto);
            if (result > 0) session.commit();
            return result;
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public int deleteComment(int commentsId) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            // 대댓글 좋아요 삭제
            session.delete("AdminBoard.deleteCommentTreeLikes", commentsId);
            // 대댓글 포함 삭제
            int result = session.delete("AdminBoard.deleteCommentTree", commentsId);
            if (result > 0) session.commit();
            else session.rollback();
            return result;
        } finally {
            if (session != null) session.close();
        }
    }
}
