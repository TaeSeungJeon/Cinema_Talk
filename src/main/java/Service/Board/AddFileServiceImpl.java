package Service.Board;

import DAO.Board.AddFileDAO;
import DAO.Board.AddFileDAOImpl;
import DTO.Board.AddFileDTO;

import java.util.List;

public class AddFileServiceImpl implements AddFileService{

    private static AddFileServiceImpl instance;

    private final AddFileDAO dao = AddFileDAOImpl.getInstance();

    private AddFileServiceImpl() {}

    public static AddFileServiceImpl getInstance() {
        if (instance == null) instance = new AddFileServiceImpl();
        return instance;
    }

    @Override
    public void insertFile(AddFileDTO dto) {
        dao.insertFile(dto);
    }

    @Override
    public List<AddFileDTO> listByBoard(int boardId, int boardType) {
        return dao.listByBoard(boardId, boardType);
    }
}