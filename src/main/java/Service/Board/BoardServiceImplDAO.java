package Service.Board;

import DAO.Board.BoardDAO;
import DAO.Board.BoardDAOImpl;
import DTO.Board.BoardDTO;

import java.util.List;

public class BoardServiceImplDAO implements BoardServiceDAO {

    private BoardDAO bdao = BoardDAOImpl.getInstance();

    // 글 작성
    @Override
    public int boardIn(BoardDTO bdto) {
        bdao.boardIn(bdto);
        return 1; // 성공 처리용 (나중에 개선 가능)
    }

    // 게시글 목록
    @Override
    public List<BoardDTO> boardList() {
        return bdao.boardList();
    }

    // 게시글 단순 조회 (수정/삭제용)
    @Override
    public BoardDTO getBoardCont(int boardId) {
        return bdao.getBoardCont(boardId);
    }

    // 조회수 증가
    @Override
    public void plusReadCount(int boardId) {
        bdao.updateReadCount(boardId);
    }

    // 상세보기 (조회수 증가 포함)
    @Override
    public BoardDTO getBoardDetail(int boardId) {
        bdao.updateReadCount(boardId);
        return bdao.getBoardCont(boardId);
    }

    // 삭제
    @Override
    public void deleteBoard(int boardId) {
        bdao.deleteBoard(boardId);
    }

    // 수정
    @Override
    public void updateBoard(BoardDTO bdto) {
        bdao.updateBoard(bdto);
    }

    @Override
    public List<BoardDTO> boardListByType(int boardType) {
        return bdao.boardListByType(boardType);
    }

    @Override
    public int getBoardCount() {
        return bdao.getBoardCount();
    }

    @Override
    public List<BoardDTO> boardListPage(int startRow, int endRow) {
        return bdao.boardListPage(startRow, endRow);
    }

    @Override
    public int getBoardCountByType(int boardType) {
        return bdao.getBoardCountByType(boardType);
    }

    @Override
    public List<BoardDTO> boardListPageByType(int boardType, int startRow, int endRow) {
        return bdao.boardListPageByType(boardType, startRow, endRow);
    }

    @Override
    public int toggleBoardLike(int boardId, int boardType, int memNo) {
        int liked = bdao.isBoardLiked(boardId, boardType, memNo);
        if (liked > 0) {
            bdao.deleteBoardLike(boardId, boardType, memNo);
        } else {
            bdao.insertBoardLike(boardId, boardType, memNo);
        }
        return bdao.getBoardLikeCount(boardId, boardType);
    }

    @Override
    public int getBoardLikeCount(int boardId, int boardType) {
        return bdao.getBoardLikeCount(boardId, boardType);
    }

    @Override
    public boolean isBoardLiked(int boardId, int boardType, int memNo) {
        return bdao.isBoardLiked(boardId, boardType, memNo) > 0;
    }


}
