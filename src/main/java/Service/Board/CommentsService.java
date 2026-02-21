package Service.Board;

import DTO.Board.CommentsDTO;
import java.util.List;
import java.util.Map;

public interface CommentsService {
    // 댓글 등록
    public int commentsIn(CommentsDTO dto);

    // 댓글 목록 가져오기
    public List<CommentsDTO> commentsList(int boardId);

    int commentsUpdate(CommentsDTO dto);

    int commentsDelete(Map<String, Object> map);
    // 댓글 좋아요 토글
    int toggleCommentsLike(int commentsId, int memNo);

    // 좋아요 정보 포함된 댓글 목록
    List<CommentsDTO> commentsListWithLike(int boardId, Integer memNo);

    int getCommentsLikeCount(int commentsId);
}