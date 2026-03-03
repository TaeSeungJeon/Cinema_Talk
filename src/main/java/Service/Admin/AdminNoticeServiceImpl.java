package Service.Admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import DAO.Admin.AdminNoticeDAO;
import DAO.Admin.AdminNoticeDAOImpl;
import DTO.Board.BoardDTO;
import mybatis.DBService;

public class AdminNoticeServiceImpl implements AdminNoticeService {
	private static AdminNoticeServiceImpl instance = null;
    
    private final AdminNoticeDAO dao = AdminNoticeDAOImpl.getInstance();

    private AdminNoticeServiceImpl() {}

    public static AdminNoticeServiceImpl getInstance() {
		if (instance == null) {
			instance = new AdminNoticeServiceImpl();
		}
		return instance;
	}

	public int getNoticeCount(String searchType, String keyword) {
		return dao.getNoticeCount(searchType, keyword);
	}

	public List<BoardDTO> getNoticeList(String sort, String searchType, String keyword, int startRow, int endRow) {
		return dao.getNoticeList(sort, searchType, keyword, startRow, endRow);
	}

	public int deleteNotice(int boardId) {
		return dao.deleteNotice(boardId);
	}

	@Override
	public BoardDTO getNoticeDetail(int boardId) {
		return dao.getNoticeDetail(boardId);
	}

	@Override
	public int updateNotice(BoardDTO dto) {
		return dao.updateNotice(dto);
	}
}	
