package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.CommentsDTO;
import Service.Board.CommentsServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.PrintWriter;

/**
 * 댓글 등록 처리 컨트롤러
 * - 비회원 세션 체크 → 댓글 DTO 구성 → 저장 → 해당 게시판 상세 페이지로 리다이렉트
 * - parentBoardId / parentBoardNo 가 0이면 null로 세팅하여 DB FK 오류 방지 (대댓글 최상위 처리)
 */
public class CommentsOkController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();

        // 비회원 접근 차단
        if (session.getAttribute("memNo") == null) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('댓글을 작성하려면 로그인을 해주세요.');");
            out.println("location.href='memberLogin.do';");
            out.println("</script>");
            out.close();
            return null;
        }

        int    boardId  = Integer.parseInt(request.getParameter("boardId"));
        int    boardType = Integer.parseInt(request.getParameter("boardType"));
        String content  = request.getParameter("commentsContent");
        int    pId      = Integer.parseInt(request.getParameter("parentBoardId"));
        int    pNo      = Integer.parseInt(request.getParameter("parentBoardNo"));
        int    cNo      = Integer.parseInt(request.getParameter("commentsNo"));
        int    memNo    = (int) session.getAttribute("memNo");
        String memId    = (String) session.getAttribute("memId");

        CommentsDTO cdto = new CommentsDTO();
        cdto.setBoardId(boardId);
        cdto.setBoardType(boardType);
        cdto.setCommentsContent(content);
        cdto.setMemNo(memNo);
        cdto.setCommentsName(memId != null ? memId : "익명");
        cdto.setCommentsNo(cNo);
        // 0이면 null로 세팅 → DB FK 오류 방지
        cdto.setParentBoardId(pId == 0 ? null : pId);
        cdto.setParentBoardNo(pNo == 0 ? null : pNo);

        int result = CommentsServiceImpl.getInstance().commentsIn(cdto);

        ActionForward forward = new ActionForward();
        String quiryBoard = request.getParameter("quiryBoard");
        if ("quiryBoard".equals(quiryBoard)) {
            forward.setPath("quiryDetail.do?boardId=" + boardId);
            forward.setRedirect(true);
        } else if (result > 0) {
            forward.setPath("postDetail.do?boardId=" + boardId);
            forward.setRedirect(true);
        }
        return forward;
    }
}
