package Service.Board;

import DTO.Board.BoardDTO;

import java.util.List;

public interface BoardServiceDAO {

    int boardIn(BoardDTO bdto);

    List<BoardDTO> boardList();
    // 게시글 단순 조회 (수정/삭제용)
    BoardDTO getBoardCont(int boardId);

    void plusReadCount(int boardId);

    BoardDTO getBoardDetail(int boardId);

    // 삭제
    void deleteBoard(int boardId);

    // 수정
    void updateBoard(BoardDTO bdto);

    List<BoardDTO> boardListByType(int boardType);

    int getBoardCount();

    List<BoardDTO> boardListPage(int startRow, int endRow);

    int getBoardCountByType(int boardType);
    List<BoardDTO> boardListPageByType(int boardType, int startRow, int endRow);

    int toggleBoardLike(int boardId, int boardType, int memNo);
    int getBoardLikeCount(int boardId, int boardType);
    boolean isBoardLiked(int boardId, int boardType, int memNo);

}
