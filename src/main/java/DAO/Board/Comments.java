package DAO.Board;

import java.util.List;
import java.util.Map;
import DTO.Board.CommentsDTO;

public interface Comments {
    int commentsIn(CommentsDTO cdto);
    List<CommentsDTO> commentsList(int boardId);
    int commentsUpdate(CommentsDTO cdto);
    int commentsDelete(Map<String, Object> map);

}