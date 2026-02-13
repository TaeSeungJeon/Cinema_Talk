package Service.Board;

import DTO.Board.BoardDTO;

import java.util.List;

public interface BoardService {

    void boardIn(BoardDTO bdto);

    List<BoardDTO> boardList();
}
