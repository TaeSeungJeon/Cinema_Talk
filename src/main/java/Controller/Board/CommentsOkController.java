package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.CommentsDTO;
import Service.Board.CommentsServiceImplDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.PrintWriter;

public class CommentsOkController implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        // 02-14 비회원 로그인 세션 체크 추가
        if (session.getAttribute("memNo") == null) {
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('댓글을 작성하려면 로그인을 해주세요');");
            out.println("location.href='memberLogin.do';");
            out.println("</script>");
            out.close();
            return null;
        }

        // 로그인 로직 수행
        int boardId = Integer.parseInt(request.getParameter("boardId"));
        int boardType = Integer.parseInt(request.getParameter("boardType"));
        String content = request.getParameter("commentsContent");

        // JSP에서 넘어온 값 수집
        int pId = Integer.parseInt(request.getParameter("parentBoardId"));
        int pNo = Integer.parseInt(request.getParameter("parentBoardNo"));
        int cNo = Integer.parseInt(request.getParameter("commentsNo"));

        int memNo = (int) session.getAttribute("memNo");
        String memName = (String) session.getAttribute("memName");

        CommentsDTO cdto = new CommentsDTO();
        cdto.setBoardId(boardId);
        cdto.setBoardType(boardType);
        cdto.setCommentsContent(content);
        cdto.setMemNo(memNo);
        cdto.setCommentsName(memName != null ? memName : "익명");

        // 핵심: 0이면 null로 세팅하여 DB FK 에러 방지
        cdto.setParentBoardId(pId == 0 ? null : pId);
        cdto.setParentBoardNo(pNo == 0 ? null : pNo);
        cdto.setCommentsNo(cNo);

        int result = CommentsServiceImplDAO.getInstance().commentsIn(cdto);

        ActionForward forward = new ActionForward();
        if (result > 0) {
            forward.setPath("postDetail.do?boardId=" + boardId);
            forward.setRedirect(true);
        }
        return forward;
    }
}