package DAO.Board;

import DTO.Board.AddFileDTO;

import java.util.List;

public interface AddFileDAO {

    void insertFile(AddFileDTO bdto);

    List<AddFileDTO> listByBoard(int boardId, int boardType);
}
