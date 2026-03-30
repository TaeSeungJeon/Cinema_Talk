package DAO.Board;

import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;

import java.util.List;

/**
 * 게시글 관련 DB 접근 인터페이스
 */
public interface BoardDAO {

    // 게시글 CRUD
    void boardIn(BoardDTO bdto);
    BoardDTO getBoardCont(int boardId);
    void updateBoard(BoardDTO bdto);
    void updateBoardContent(BoardDTO bdto);
    void deleteBoard(int boardId);
    int updateReadCount(int boardId);

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
    int isBoardLiked(int boardId, int boardType, int memNo);
    int insertBoardLike(int boardId, int boardType, int memNo);
    int deleteBoardLike(int boardId, int boardType, int memNo);
    int getBoardLikeCount(int boardId, int boardType);

    // 댓글
    int commentsIn(CommentsDTO cdto);
    List<CommentsDTO> commentsList(int boardId);
}
