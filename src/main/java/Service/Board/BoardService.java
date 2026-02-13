package Service.Board;

import DTO.Board.BoardDTO;

import java.util.List;

public interface BoardService {

    int boardIn(BoardDTO bdto);

    List<BoardDTO> boardList();
    BoardDTO boardCont(int boardId);
    void plusReadCount(int boardId);
    BoardDTO getBoardDetail(int boardId);
}
