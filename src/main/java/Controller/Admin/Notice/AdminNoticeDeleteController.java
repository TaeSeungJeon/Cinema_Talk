package Controller.Admin.Notice;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import Service.Admin.AdminNoticeService;
import Service.Admin.AdminNoticeServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminNoticeDeleteController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/plain; charset=UTF-8");
        AdminNoticeService service = AdminNoticeServiceImpl.getInstance();
        int boardId = Integer.parseInt(request.getParameter("boardId"));

        int result = service.deleteNotice(boardId);

        PrintWriter out = response.getWriter();
        out.print(result > 0 ? "success" : "fail");
        out.flush();

        return null;
    }
}
