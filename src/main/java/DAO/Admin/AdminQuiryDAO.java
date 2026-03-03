package DAO.Admin;

import java.util.List;
import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;

public interface AdminQuiryDAO {

    int getQuiryCount(String searchType, String keyword, String unanswered);

    List<BoardDTO> getQuiryList(String sort, String searchType, String keyword,
                                String unanswered, int startRow, int endRow);

    BoardDTO getQuiryDetail(int boardId);

    List<CommentsDTO> getQuiryComments(int boardId);

    int insertReply(CommentsDTO dto);

    int deleteQuiry(int boardId);
}
