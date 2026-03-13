package Service.Admin;

import java.util.List;

import DAO.Admin.AdminBoardDAO;
import DAO.Admin.AdminBoardDAOImpl;
import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;

public class AdminBoardServiceImpl implements AdminBoardService {
    private static AdminBoardServiceImpl instance = null;

    private final AdminBoardDAO dao = AdminBoardDAOImpl.getInstance();

    private AdminBoardServiceImpl() {}

    public static AdminBoardServiceImpl getInstance() {
        if (instance == null) {
            instance = new AdminBoardServiceImpl();
        }
        return instance;
    }

    @Override
    public int getBoardCount(String searchType, String keyword) {
        return dao.getBoardCount(searchType, keyword);
    }

    @Override
    public List<BoardDTO> getBoardList(String sort, String searchType, String keyword, int startRow, int endRow) {
        return dao.getBoardList(sort, searchType, keyword, startRow, endRow);
    }

    @Override
    public BoardDTO getBoardDetail(int boardId) {
        return dao.getBoardDetail(boardId);
    }

    @Override
    public List<CommentsDTO> getBoardComments(int boardId) {
        return dao.getBoardComments(boardId);
    }

    @Override
    public int updateBoard(BoardDTO dto) {
        return dao.updateBoard(dto);
    }

    @Override
    public int deleteBoard(int boardId) {
        return dao.deleteBoard(boardId);
    }

    @Override
    public int updateComment(CommentsDTO dto) {
        return dao.updateComment(dto);
    }

    @Override
    public int deleteComment(int commentsId) {
        return dao.deleteComment(commentsId);
    }
}
