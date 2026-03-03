package Service.Admin;

import java.util.List;

import DAO.Admin.AdminQuiryDAO;
import DAO.Admin.AdminQuiryDAOImpl;
import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;

public class AdminQuiryServiceImpl implements AdminQuiryService {
    private static AdminQuiryServiceImpl instance = null;

    private final AdminQuiryDAO dao = AdminQuiryDAOImpl.getInstance();

    private AdminQuiryServiceImpl() {}

    public static AdminQuiryServiceImpl getInstance() {
        if (instance == null) {
            instance = new AdminQuiryServiceImpl();
        }
        return instance;
    }

    @Override
    public int getQuiryCount(String searchType, String keyword, String unanswered) {
        return dao.getQuiryCount(searchType, keyword, unanswered);
    }

    @Override
    public List<BoardDTO> getQuiryList(String sort, String searchType, String keyword,
                                        String unanswered, int startRow, int endRow) {
        return dao.getQuiryList(sort, searchType, keyword, unanswered, startRow, endRow);
    }

    @Override
    public BoardDTO getQuiryDetail(int boardId) {
        return dao.getQuiryDetail(boardId);
    }

    @Override
    public List<CommentsDTO> getQuiryComments(int boardId) {
        return dao.getQuiryComments(boardId);
    }

    @Override
    public int insertReply(CommentsDTO dto) {
        return dao.insertReply(dto);
    }

    @Override
    public int deleteQuiry(int boardId) {
        return dao.deleteQuiry(boardId);
    }
}
