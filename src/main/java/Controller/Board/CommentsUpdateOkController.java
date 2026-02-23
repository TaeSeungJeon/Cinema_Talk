package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.CommentsDTO;
import Service.Board.CommentsServiceImplDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CommentsUpdateOkController implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int cId = Integer.parseInt(request.getParameter("commentsId"));
        int bId = Integer.parseInt(request.getParameter("boardId"));
        String content = request.getParameter("commentsContent");
        int memNo = (int) request.getSession().getAttribute("memNo");

        CommentsDTO cdto = new CommentsDTO();
        cdto.setCommentsId(cId);
        cdto.setCommentsContent(content);
        cdto.setMemNo(memNo);

        int result = CommentsServiceImplDAO.getInstance().commentsUpdate(cdto);

        ActionForward forward = new ActionForward();
        forward.setPath("postDetail.do?boardId=" + bId);
        forward.setRedirect(true); // 리다이렉트로 흰 화면 방지 [cite: 2026-02-13]
        return forward;
    }
}