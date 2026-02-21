package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import Service.Board.CommentsService;
import Service.Board.CommentsServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.PrintWriter;

public class CommentsLikeController implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(false);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (session == null || session.getAttribute("memNo") == null) {
            out.print("LOGIN_REQUIRED");
            return null;
        }

        int commentsId = Integer.parseInt(request.getParameter("commentsId"));
        int memNo = (int) session.getAttribute("memNo");

        CommentsService service = CommentsServiceImpl.getInstance();
        int result = service.toggleCommentsLike(commentsId, memNo);

        // 좋아요 개수 반환
        int likeCount = service.getCommentsLikeCount(commentsId);
        out.print(likeCount);
        return null;
    }
}