package Service.Board;

import DTO.Board.BoardDTO;

import java.util.List;
import java.util.Map;

/**
 * 게시글 관련 비즈니스 로직 인터페이스
 */
public interface BoardService {

    // 게시글 CRUD
    int boardIn(BoardDTO bdto);
    BoardDTO getBoardCont(int boardId);                          // 조회수 증가 없는 단순 조회 (수정/삭제용)
    BoardDTO getBoardDetail(int boardId);                        // 조회수 증가 포함 상세 조회
    Map<String, Object> getBoardDetailWithPreview(int boardId);  // 상세 조회 + 링크 미리보기
    void updateBoard(BoardDTO bdto);
    void updateBoardContent(BoardDTO bdto);
    void deleteBoard(int boardId);

    // 목록 / 페이징
    int getBoardCount();
    int getBoardCountByType(int boardType);
    List<BoardDTO> boardListPage(int startRow, int endRow);
    List<BoardDTO> boardListPageByType(int boardType, int startRow, int endRow);
    List<BoardDTO> recentBoardList(int limit);
    List<BoardDTO> hotBoardList(int limit);
    List<BoardDTO> getPopularBoardList(String period, int limit);
    BoardDTO latestNotice();
    String getMovieTitleforBoard(int movieId);

    // 좋아요
    int toggleBoardLike(int boardId, int boardType, int memNo);
    int getBoardLikeCount(int boardId, int boardType);
    boolean isBoardLiked(int boardId, int boardType, int memNo);
}
