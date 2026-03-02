package DAO.Admin;

import java.util.List;
import DTO.Board.BoardDTO;

public interface AdminNoticeDAO {

    int getNoticeCount(String searchType, String keyword);

    List<BoardDTO> getNoticeList(String sort, String searchType, String keyword,
                                 int startRow, int endRow);

    BoardDTO getNoticeDetail(int boardId);

    int updateNotice(BoardDTO dto);

    int deleteNotice(int boardId);
}
