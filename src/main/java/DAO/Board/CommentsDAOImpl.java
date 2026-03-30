package DAO.Board;

import DTO.Board.CommentsDTO;
import mybatis.DBService;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

/**
 * CommentsDAO 구현체
 * - MyBatis SqlSession을 통해 DB와 통신
 * - 수동 커밋 모드(autoCommit=false)로 열고, 변경 작업 후 명시적으로 commit()
 * - try-with-resources로 SqlSession 누수 방지
 * - Singleton 패턴 적용
 */
public class CommentsDAOImpl implements CommentsDAO {

    private static final CommentsDAOImpl instance = new CommentsDAOImpl();

    private CommentsDAOImpl() {}

    public static CommentsDAOImpl getInstance() {
        return instance;
    }

    /** SqlSession을 수동 커밋 모드로 열어 반환 */
    private SqlSession getSqlSession() {
        return DBService.getFactory().openSession(false);
    }

    // =====================================================================
    // 댓글 CRUD
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

    /** 댓글 수정 (본인 댓글만) */
    @Override
    public int commentsUpdate(CommentsDTO cdto) {
        try (SqlSession sqlSession = getSqlSession()) {
            int result = sqlSession.update("Comments.commentsUpdate", cdto);
            if (result > 0) sqlSession.commit();
            return result;
        }
    }

    /** 단일 댓글 삭제 */
    @Override
    public int commentsDelete(Map<String, Object> map) {
        try (SqlSession sqlSession = getSqlSession()) {
            int result = sqlSession.delete("Comments.commentsDelete", map);
            if (result > 0) sqlSession.commit();
            return result;
        }
    }


    // 댓글 목록 조회
    /** 게시글에 달린 댓글 목록 조회 (계층형 트리 구조) */
    @Override
    public List<CommentsDTO> commentsList(int boardId) {
        try (SqlSession sqlSession = getSqlSession()) {
            return sqlSession.selectList("Comments.commentsList", boardId);
        }
    }

    /**
     * 좋아요 정보 포함 댓글 목록 조회
     * - map 필수 키: boardId(int), memNo(Integer, 비로그인 시 null 허용)
     */
    @Override
    public List<CommentsDTO> commentsListWithLike(Map<String, Object> map) {
        try (SqlSession sqlSession = getSqlSession()) {
            return sqlSession.selectList("Comments.commentsListWithLike", map);
        }
    }

    // 댓글 트리 삭제 (대댓글 포함 일괄)
    /**
     * 댓글 트리(부모 + 모든 자식)의 좋아요 레코드 일괄 삭제
     * - FK 제약 위반 방지를 위해 반드시 commentsDeleteTree 보다 먼저 호출해야 함
     */
    @Override
    public int deleteCommentLikesByCommentTree(int commentsId) {
        try (SqlSession sqlSession = getSqlSession()) {
            int result = sqlSession.delete("Comments.deleteCommentLikesByCommentTree", commentsId);
            if (result > 0) sqlSession.commit();
            return result;
        }
    }

    /**
     * 댓글 + 대댓글 트리 전체 삭제
     * - map 필수 키: commentsId(int), memNo(int)
     * - 본인 댓글만 삭제 가능 (mapper 레벨에서 memNo 검증)
     */
    @Override
    public int commentsDeleteTree(Map<String, Object> map) {
        try (SqlSession sqlSession = getSqlSession()) {
            int result = sqlSession.delete("Comments.commentsDeleteTree", map);
            if (result > 0) sqlSession.commit();
            return result;
        }
    }

    // 댓글 좋아요
    /** 댓글 좋아요 등록 */
    @Override
    public int commentsLikeInsert(Map<String, Object> map) {
        try (SqlSession sqlSession = getSqlSession()) {
            int result = sqlSession.insert("Comments.commentsLikeInsert", map);
            if (result > 0) sqlSession.commit();
            return result;
        }
    }

    /** 댓글 좋아요 취소 */
    @Override
    public int commentsLikeDelete(Map<String, Object> map) {
        try (SqlSession sqlSession = getSqlSession()) {
            int result = sqlSession.delete("Comments.commentsLikeDelete", map);
            if (result > 0) sqlSession.commit();
            return result;
        }
    }

    /** 댓글 좋아요 총 개수 조회 */
    @Override
    public int commentsLikeCount(int commentsId) {
        try (SqlSession sqlSession = getSqlSession()) {
            return sqlSession.selectOne("Comments.commentsLikeCount", commentsId);
        }
    }

    /** 현재 사용자의 댓글 좋아요 여부 확인 (1: 좋아요 있음, 0: 없음) */
    @Override
    public int commentsLikeCheck(Map<String, Object> map) {
        try (SqlSession sqlSession = getSqlSession()) {
            return sqlSession.selectOne("Comments.commentsLikeCheck", map);
        }
    }
}