package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.CommentsDTO;
import Service.Board.CommentsServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * 댓글 수정 처리 컨트롤러
 * - 수정 후 상세 페이지로 리다이렉트 (흰 화면 방지)
 */
public class CommentsUpdateOkController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // [버그 수정] 세션 null 체크 없이 getAttribute 캐스팅 시 NPE 발생 가능
        HttpSession session = request.getSession(false);
        ActionForward forward = new ActionForward();

        int bId = Integer.parseInt(request.getParameter("boardId"));

        if (session == null || session.getAttribute("memNo") == null) {
            forward.setPath("postDetail.do?boardId=" + bId);
            forward.setRedirect(true);
            return forward;
        }

        int    cId     = Integer.parseInt(request.getParameter("commentsId"));
        String content = request.getParameter("commentsContent");
        int    memNo   = (int) session.getAttribute("memNo");

        CommentsDTO cdto = new CommentsDTO();
        cdto.setCommentsId(cId);
        cdto.setCommentsContent(content);
        cdto.setMemNo(memNo);

        CommentsServiceImpl.getInstance().commentsUpdate(cdto);

        forward.setPath("postDetail.do?boardId=" + bId);
        forward.setRedirect(true);
        return forward;
    }
}
