package DAO.Board;

import DTO.Board.BoardDTO;

import java.util.List;

public interface BoardDAO {


    void boardIn(BoardDTO bdto);

    List<BoardDTO> boardList();
}
