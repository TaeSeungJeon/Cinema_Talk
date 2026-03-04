package Controller.Admin.Board;

import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import Service.Admin.AdminBoardService;
import Service.Admin.AdminBoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminBoardDetailController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        AdminBoardService service = AdminBoardServiceImpl.getInstance();
        int boardId = Integer.parseInt(request.getParameter("boardId"));

        BoardDTO board = service.getBoardDetail(boardId);
        List<CommentsDTO> commentsList = service.getBoardComments(boardId);

        request.setAttribute("board", board);
        request.setAttribute("commentsList", commentsList);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("/WEB-INF/views/admin/board/adminBoardDetail.jsp");
        return forward;
    }
}
