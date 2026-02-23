package Controller.Board;


import Controller.Action;
import Controller.ActionForward;
import Service.Board.BoardServiceDAO;
import Service.Board.BoardServiceImplDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.PrintWriter;

public class BoardLikeToggleController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(false);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (session == null || session.getAttribute("memNo") == null) {
            out.print("LOGIN_REQUIRED");
            return null;
        }

        int boardId = Integer.parseInt(request.getParameter("boardId"));
        int boardType = Integer.parseInt(request.getParameter("boardType"));
        int memNo = (int) session.getAttribute("memNo");

        BoardServiceDAO service = new BoardServiceImplDAO();
        int likeCount = service.toggleBoardLike(boardId, boardType, memNo);

        out.print(likeCount);
        return null;
    }
}
