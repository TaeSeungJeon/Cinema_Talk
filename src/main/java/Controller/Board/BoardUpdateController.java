package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardServiceDAO;
import Service.Board.BoardServiceImplDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class BoardUpdateController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request,
                                 HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        Integer loginMemNo = (Integer) session.getAttribute("memNo");

        ActionForward forward = new ActionForward();

        if (loginMemNo == null) {
            forward.setPath("memberLogin.do");
            forward.setRedirect(true);
            return forward;
        }

        int boardId = Integer.parseInt(request.getParameter("boardId"));

        BoardServiceDAO boardService = new BoardServiceImplDAO();
        BoardDTO board = boardService.getBoardCont(boardId);

        if (board == null || !board.getMemNo().equals(loginMemNo)) {
            forward.setPath("freeBoard.do");
            forward.setRedirect(true);
            return forward;
        }

        request.setAttribute("board", board);

        forward.setPath("/WEB-INF/views/board/boardUpdate.jsp");
        forward.setRedirect(false);

        return forward;
    }
}
