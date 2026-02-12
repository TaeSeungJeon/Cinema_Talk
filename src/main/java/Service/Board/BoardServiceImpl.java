package Service.Board;

import DAO.Board.BoardDAO;
import DAO.Board.BoardDAOImpl;
import DTO.Board.BoardDTO;

import java.util.List;

public class  BoardServiceImpl implements BoardService{
    private BoardDAO bdao = BoardDAOImpl.getInstance();

    @Override
    public void boardIn(BoardDTO bdto) {
        this.bdao.boardIn(bdto);
    }//글작성

    @Override
    public List<BoardDTO> boardList() {
        return bdao.boardList();
    }
}
