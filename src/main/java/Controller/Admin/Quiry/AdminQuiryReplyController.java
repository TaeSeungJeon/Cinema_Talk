package Controller.Admin.Quiry;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.CommentsDTO;
import Service.Admin.AdminQuiryService;
import Service.Admin.AdminQuiryServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminQuiryReplyController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        AdminQuiryService service = AdminQuiryServiceImpl.getInstance();

        int boardId = Integer.parseInt(request.getParameter("boardId"));
        String content = request.getParameter("commentsContent");

        HttpSession session = request.getSession(false);
        String commentsName = (session != null && session.getAttribute("memId") != null)
                ? session.getAttribute("memId").toString() : "관리자";
        Integer memNo = (session != null && session.getAttribute("memNo") != null)
                ? Integer.parseInt(session.getAttribute("memNo").toString()) : null;

        CommentsDTO dto = new CommentsDTO();
        dto.setBoardId(boardId);
        dto.setCommentsContent(content);
        dto.setCommentsName(commentsName);
        dto.setMemNo(memNo);
        dto.setCommentsNo(1);

        int result = service.insertReply(dto);

        PrintWriter out = response.getWriter();
        out.print(result > 0 ? "success" : "fail");
        out.flush();

        return null;
    }
}
