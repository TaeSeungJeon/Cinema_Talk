package Controller.Admin.Quiry;

import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import Service.Admin.AdminQuiryService;
import Service.Admin.AdminQuiryServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminQuiryDetailController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        AdminQuiryService service = AdminQuiryServiceImpl.getInstance();
        int boardId = Integer.parseInt(request.getParameter("boardId"));

        BoardDTO board = service.getQuiryDetail(boardId);
        List<CommentsDTO> commentsList = service.getQuiryComments(boardId);

        request.setAttribute("board", board);
        request.setAttribute("commentsList", commentsList);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("/WEB-INF/views/admin/quiry/adminQuiryDetail.jsp");
        return forward;
    }
}
