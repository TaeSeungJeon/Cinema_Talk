package DAO.Board;

import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO; // 댓글 DTO 임포트 추가

import java.util.List;

public interface BoardDAO {

    void boardIn(BoardDTO bdto);
    List<BoardDTO> boardList();
    BoardDTO boardCont(int boardId);
    int updateReadCount(int boardId);

    int commentsIn(CommentsDTO cdto);

    List<CommentsDTO> commentsList(int boardId);
}