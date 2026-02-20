package DAO.Board;

import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO; // 댓글 DTO 임포트 추가

import java.util.List;

public interface BoardDAO {

    void boardIn(BoardDTO bdto);
    List<BoardDTO> boardList();
    BoardDTO boardCont(int boardId);
    int updateReadCount(int boardId);

    // Service에서 사용하는 getBoardCont (기존 boardCont 재사용)
    BoardDTO getBoardCont(int boardId);

    // 게시글 수정
    void updateBoard(BoardDTO bdto);

    // 게시글 삭제
    void deleteBoard(int boardId);

    int commentsIn(CommentsDTO cdto);

    List<CommentsDTO> commentsList(int boardId);

    List<BoardDTO> boardListByType(int boardType);

    int getBoardCount();

    List<BoardDTO> boardListPage(int startRow, int endRow);

    List<BoardDTO> boardListPageByType(int boardType, int startRow, int endRow);

    int getBoardCountByType(int boardType);
}