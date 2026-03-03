package Controller.Admin.Quiry;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import Service.Admin.AdminQuiryService;
import Service.Admin.AdminQuiryServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminQuiryDeleteController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/plain; charset=UTF-8");
        AdminQuiryService service = AdminQuiryServiceImpl.getInstance();
        int boardId = Integer.parseInt(request.getParameter("boardId"));

        int result = service.deleteQuiry(boardId);

        PrintWriter out = response.getWriter();
        out.print(result > 0 ? "success" : "fail");
        out.flush();

        return null;
    }
}
