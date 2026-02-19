package Service.Board;

import DAO.Board.BoardDAO;
import DAO.Board.BoardDAOImpl;
import DTO.Board.BoardDTO;

import java.util.List;

public class BoardServiceImpl implements BoardService {

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
}
