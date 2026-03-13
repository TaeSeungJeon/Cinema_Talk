package Controller.Admin.Notice;

import Controller.Action;
import Controller.ActionForward;
import DAO.Admin.AdminNoticeDAO;
import DAO.Admin.AdminNoticeDAOImpl;
import DTO.Board.BoardDTO;
import Service.Admin.AdminNoticeService;
import Service.Admin.AdminNoticeServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminNoticeDetailController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	AdminNoticeService service = AdminNoticeServiceImpl.getInstance();
        int boardId = Integer.parseInt(request.getParameter("boardId"));

        BoardDTO board = service.getNoticeDetail(boardId);

        request.setAttribute("board", board);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("/WEB-INF/views/admin/notice/adminNoticeDetail.jsp");
        return forward;
    }
}
