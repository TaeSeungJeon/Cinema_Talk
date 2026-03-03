package Service.Admin;

import java.util.List;

import DTO.Board.BoardDTO;

public interface AdminNoticeService {
	int getNoticeCount(String searchType, String keyword);
	List<DTO.Board.BoardDTO> getNoticeList(String sort, String searchType, String keyword, int startRow, int endRow);
	int deleteNotice(int boardId);
	BoardDTO getNoticeDetail(int boardId);
	int updateNotice(BoardDTO dto);
}
