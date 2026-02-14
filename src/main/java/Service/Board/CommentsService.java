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
}