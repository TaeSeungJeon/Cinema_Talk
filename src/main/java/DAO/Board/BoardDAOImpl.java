package DAO.Board;

import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import mybatis.DBService;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * BoardDAO 구현체
 * - MyBatis SqlSession을 통해 DB와 통신
 * - 수동 커밋 모드(autoCommit=false)로 열고, 변경 작업 후 명시적으로 commit()
 * - Singleton 패턴 적용
 */
public class BoardDAOImpl implements BoardDAO {

    private static BoardDAOImpl instance;

    private BoardDAOImpl() {}

    public static BoardDAOImpl getInstance() {
        if (instance == null) {
            instance = new BoardDAOImpl();
        }
        return instance;
    }

    /** SqlSession을 수동 커밋 모드로 열어 반환 */
    private SqlSession getSqlSession() {
        return DBService.getFactory().openSession(false);
    }

    // =====================================================================
    // 게시글 CRUD
    // =====================================================================

    /** 게시글 등록 */
    @Override
    public void boardIn(BoardDTO bdto) {
        try (SqlSession sqlSession = getSqlSession()) {
            sqlSession.insert("Board.boardIn", bdto);
            sqlSession.commit();
        }
    }

    /** 게시글 단건 조회 */
    @Override
    public BoardDTO getBoardCont(int boardId) {
        try (SqlSession sqlSession = getSqlSession()) {
            return sqlSession.selectOne("Board.boardCont", boardId);
        }
    }

    /** 게시글 수정 (제목·내용·링크 등 전체 필드) */
    @Override
    public void updateBoard(BoardDTO bdto) {
        try (SqlSession sqlSession = getSqlSession()) {
            int result = sqlSession.update("Board.updateBoard", bdto);
            if (result > 0) sqlSession.commit();
        }
    }

    /** 게시글 내용(content)만 부분 수정 */
    @Override
    public void updateBoardContent(BoardDTO bdto) {
        try (SqlSession sqlSession = getSqlSession()) {
            int result = sqlSession.update("Board.updateBoardContent", bdto);
            if (result > 0) sqlSession.commit();
        }
    }

    /** 게시글 삭제 */
    @Override
    public void deleteBoard(int boardId) {
        try (SqlSession sqlSession = getSqlSession()) {
            int result = sqlSession.delete("Board.deleteBoard", boardId);
            if (result > 0) sqlSession.commit();
        }
    }

    /**
     * 조회수 증가
     * - 실시간 인기글 집계에 즉시 반영되어야 하므로 무조건 commit
     */
    @Override
    public int updateReadCount(int boardId) {
        try (SqlSession sqlSession = getSqlSession()) {
            int result = sqlSession.update("Board.updateReadCount", boardId);
            sqlSession.commit();
            return result;
        }
    }

    // =====================================================================
    // 게시글 목록 / 페이징
    // =====================================================================

    /** 전체 게시글 수 조회 */
    @Override
    public int getBoardCount() {
        try (SqlSession sqlSession = getSqlSession()) {
            return sqlSession.selectOne("Board.getBoardCount");
        }
    }

    /** 특정 타입의 게시글 수 조회 */
    @Override
    public int getBoardCountByType(int boardType) {
        try (SqlSession sqlSession = getSqlSession()) {
            return sqlSession.selectOne("Board.getBoardCountByType", boardType);
        }
    }

    /** 페이징 처리된 전체 게시글 목록 */
    @Override
    public List<BoardDTO> boardListPage(int startRow, int endRow) {
        try (SqlSession sqlSession = getSqlSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("startRow", startRow);
            param.put("endRow", endRow);
            return sqlSession.selectList("Board.boardListPage", param);
        }
    }

    /** 페이징 처리된 특정 타입 게시글 목록 */
    @Override
    public List<BoardDTO> boardListPageByType(int boardType, int startRow, int endRow) {
        try (SqlSession sqlSession = getSqlSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("boardType", boardType);
            param.put("startRow", startRow);
            param.put("endRow", endRow);
            return sqlSession.selectList("Board.boardListPageByType", param);
        }
    }

    /** 최신 게시글 N건 조회 (메인 페이지 등 사용) */
    @Override
    public List<BoardDTO> recentBoardList(int limit) {
        try (SqlSession sqlSession = getSqlSession()) {
            return sqlSession.selectList("Board.recentBoardList", limit);
        }
    }

    /** 실시간 인기 게시글 N건 조회 (조회수 기준) */
    @Override
    public List<BoardDTO> hotBoardList(int limit) {
        try (SqlSession sqlSession = getSqlSession()) {
            return sqlSession.selectList("Board.hotBoardList", limit);
        }
    }

    /** 기간별 인기 게시글 조회 (period: "daily" | "weekly" | "monthly") */
    @Override
    public List<BoardDTO> getPopularBoardList(String period, int limit) {
        try (SqlSession sqlSession = getSqlSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("period", period);
            param.put("limit", limit);
            return sqlSession.selectList("Board.getPopularBoardList", param);
        }
    }

    /** 최신 공지사항 1건 조회 (전체 게시판 상단 고정용) */
    @Override
    public BoardDTO latestNotice() {
        try (SqlSession sqlSession = getSqlSession()) {
            return sqlSession.selectOne("Board.latestNotice");
        }
    }

    /** 영화 ID로 영화 제목 조회 (영화게시판 게시글 작성 시 사용) */
    @Override
    public String getMovieTitleforBoard(int movieId) {
        try (SqlSession sqlSession = getSqlSession()) {
            return sqlSession.selectOne("Board.getMovieTitleforBoard", movieId);
        }
    }

    // =====================================================================
    // 좋아요
    // =====================================================================

    /** 현재 사용자의 좋아요 여부 확인 (1: 좋아요 있음, 0: 없음) */
    @Override
    public int isBoardLiked(int boardId, int boardType, int memNo) {
        try (SqlSession sqlSession = getSqlSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("boardId", boardId);
            param.put("boardType", boardType);
            param.put("memNo", memNo);
            return sqlSession.selectOne("Board.isBoardLiked", param);
        }
    }

    /** 좋아요 등록 */
    @Override
    public int insertBoardLike(int boardId, int boardType, int memNo) {
        try (SqlSession sqlSession = getSqlSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("boardId", boardId);
            param.put("boardType", boardType);
            param.put("memNo", memNo);
            int result = sqlSession.insert("Board.insertBoardLike", param);
            if (result > 0) sqlSession.commit();
            return result;
        }
    }

    /** 좋아요 취소 */
    @Override
    public int deleteBoardLike(int boardId, int boardType, int memNo) {
        try (SqlSession sqlSession = getSqlSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("boardId", boardId);
            param.put("boardType", boardType);
            param.put("memNo", memNo);
            int result = sqlSession.delete("Board.deleteBoardLike", param);
            if (result > 0) sqlSession.commit();
            return result;
        }
    }

    /** 게시글 좋아요 총 개수 조회 */
    @Override
    public int getBoardLikeCount(int boardId, int boardType) {
        try (SqlSession sqlSession = getSqlSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("boardId", boardId);
            param.put("boardType", boardType);
            return sqlSession.selectOne("Board.getBoardLikeCount", param);
        }
    }

    // =====================================================================
    // 댓글
    // =====================================================================

    /** 댓글 등록 */
    @Override
    public int commentsIn(CommentsDTO cdto) {
        try (SqlSession sqlSession = getSqlSession()) {
            int result = sqlSession.insert("Comments.commentsIn", cdto);
            if (result > 0) sqlSession.commit();
            return result;
        }
    }

    /** 게시글에 달린 댓글 목록 조회 */
    @Override
    public List<CommentsDTO> commentsList(int boardId) {
        try (SqlSession sqlSession = getSqlSession()) {
            return sqlSession.selectList("Comments.commentsList", boardId);
        }
    }
}
