package Service.Board;

import DTO.Board.AddFileDTO;
import java.util.List;

public interface AddFileService {
    void insertFile(AddFileDTO dto);
    List<AddFileDTO> listByBoard(int boardId, int boardType);
}