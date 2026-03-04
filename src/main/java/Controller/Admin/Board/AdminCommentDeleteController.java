package Controller.Admin.Board;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import Service.Admin.AdminBoardService;
import Service.Admin.AdminBoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminCommentDeleteController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/plain; charset=UTF-8");

        AdminBoardService service = AdminBoardServiceImpl.getInstance();
        int commentsId = Integer.parseInt(request.getParameter("commentsId"));

        int result = service.deleteComment(commentsId);

        PrintWriter out = response.getWriter();
        out.print(result > 0 ? "success" : "fail");
        out.flush();

        return null;
    }
}
