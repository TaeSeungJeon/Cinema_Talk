package Controller.Admin.Board;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.CommentsDTO;
import Service.Admin.AdminBoardService;
import Service.Admin.AdminBoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminCommentUpdateController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        AdminBoardService service = AdminBoardServiceImpl.getInstance();
        int commentsId = Integer.parseInt(request.getParameter("commentsId"));
        String commentsContent = request.getParameter("commentsContent");

        CommentsDTO dto = new CommentsDTO();
        dto.setCommentsId(commentsId);
        dto.setCommentsContent(commentsContent);

        int result = service.updateComment(dto);

        PrintWriter out = response.getWriter();
        out.print(result > 0 ? "success" : "fail");
        out.flush();

        return null;
    }
}
