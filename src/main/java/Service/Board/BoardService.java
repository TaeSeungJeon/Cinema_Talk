package Service.Board;

import DTO.Board.BoardDTO;

import java.util.List;
import java.util.Map;

public interface BoardService {

    int boardIn(BoardDTO bdto);

    List<BoardDTO> boardList();
    // 게시글 단순 조회 (수정/삭제용)
    BoardDTO getBoardCont(int boardId);

    Map<String, Object> getBoardDetailWithPreview(int boardNo);

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
    // 실시간 인기글
    List<BoardDTO> hotBoardList(int limit);
    // 최근 게시글
    List<BoardDTO> recentBoardList(int limit);

}
