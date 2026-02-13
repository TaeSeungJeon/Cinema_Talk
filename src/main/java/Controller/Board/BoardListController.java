package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

public class BoardListController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        BoardService service = new BoardServiceImpl();

        // 게시글 목록 가져오기
        List<BoardDTO> list = service.boardList();

        // request에 담기
        request.setAttribute("boardList", list);

        ActionForward forward = new ActionForward();
        forward.setPath("/WEB-INF/views/board/freeBoard.jsp");
        forward.setRedirect(false);

        return forward;
    }
}
