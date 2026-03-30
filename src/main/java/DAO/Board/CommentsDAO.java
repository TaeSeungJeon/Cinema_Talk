package DAO.Board;

import DTO.Board.CommentsDTO;

import java.util.List;
import java.util.Map;

/**
 * 댓글 관련 DB 접근 인터페이스
 */
public interface CommentsDAO {

    // 댓글 CRUD
    int commentsIn(CommentsDTO cdto);
    int commentsUpdate(CommentsDTO cdto);
    int commentsDelete(Map<String, Object> map);

    // 댓글 목록 조회
    List<CommentsDTO> commentsList(int boardId);
    List<CommentsDTO> commentsListWithLike(Map<String, Object> map); // 좋아요 정보 포함

    // 댓글 트리 삭제 (대댓글 포함 일괄 삭제)
    int deleteCommentLikesByCommentTree(int commentsId); // 좋아요 먼저 삭제 (FK 제약 방지)
    int commentsDeleteTree(Map<String, Object> map);     // 댓글 + 대댓글 삭제

    // 댓글 좋아요
    int commentsLikeInsert(Map<String, Object> map);
    int commentsLikeDelete(Map<String, Object> map);
    int commentsLikeCount(int commentsId);
    int commentsLikeCheck(Map<String, Object> map);
}