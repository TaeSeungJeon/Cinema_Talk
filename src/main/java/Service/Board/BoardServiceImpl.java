package Service.Board;

import DAO.Board.BoardDAO;
import DAO.Board.BoardDAOImpl;
import DTO.Board.BoardDTO;

public class  BoardServiceImpl implements BoardService{
    private BoardDAO bdao = BoardDAOImpl.getInstance();

    @Override
    public void boardIn(BoardDTO bdto) {
        this.bdao.boardIn(bdto);
    }//글작성
}
