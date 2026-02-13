package Service.Board;

import DAO.Board.BoardDAO;
import DAO.Board.BoardDAOImpl;
import DTO.Board.BoardDTO;

import java.util.List;

public class  BoardServiceImpl implements BoardService{
    private BoardDAO bdao = BoardDAOImpl.getInstance();

    @Override
    public int boardIn(BoardDTO bdto) {
        this.bdao.boardIn(bdto);
        return 0;
    }//글작성

    @Override
    public List<BoardDTO> boardList() {
        return bdao.boardList();
    }

    @Override
    public BoardDTO boardCont(int boardId) {
        return bdao.boardCont(boardId);
    }

    @Override
    public void plusReadCount(int boardId) {
        bdao.updateReadCount(boardId);
    }

    @Override
    public BoardDTO getBoardDetail(int boardId) {
        return bdao.boardCont(boardId);
    }
}
