package DAO.Board;

import java.util.List;
import DTO.Board.CommentsDTO;

public interface Comments {

    public int commentsIn(CommentsDTO cdto);
    public List<CommentsDTO> commentsList(int boardId);
}