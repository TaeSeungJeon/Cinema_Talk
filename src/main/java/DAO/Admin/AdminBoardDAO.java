package DAO.Admin;

import java.util.List;
import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;

public interface AdminBoardDAO {

    int getBoardCount(String searchType, String keyword);

    List<BoardDTO> getBoardList(String sort, String searchType, String keyword,
                                int startRow, int endRow);

    BoardDTO getBoardDetail(int boardId);

    List<CommentsDTO> getBoardComments(int boardId);

    int updateBoard(BoardDTO dto);

    int deleteBoard(int boardId);

    int updateComment(CommentsDTO dto);

    int deleteComment(int commentsId);
}
