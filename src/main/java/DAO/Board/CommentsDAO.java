package DAO.Board;

import java.util.List;
import java.util.Map;
import DTO.Board.CommentsDTO;

public interface CommentsDAO {
    int commentsIn(CommentsDTO cdto);
    List<CommentsDTO> commentsList(int boardId);
    int commentsUpdate(CommentsDTO cdto);
    int commentsDelete(Map<String, Object> map);
    // 댓글 좋아요 관련 메소드
    int commentsLikeInsert(Map<String, Object> map);
    int commentsLikeDelete(Map<String, Object> map);
    int commentsLikeCount(int commentsId);
    int commentsLikeCheck(Map<String, Object> map);
    List<CommentsDTO> commentsListWithLike(Map<String, Object> map);
    int deleteCommentLikesByCommentTree(int commentsId);
    int commentsDeleteTree(Map<String, Object> map);
}