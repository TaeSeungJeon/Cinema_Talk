package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import Service.Board.CommentsServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class CommentsDeleteOkController implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int cId = Integer.parseInt(request.getParameter("commentsId"));
        int bId = Integer.parseInt(request.getParameter("boardId"));

        // 세션 null / memNo 없음 방어
        if (request.getSession(false) == null || request.getSession(false).getAttribute("memNo") == null) {
            ActionForward forward = new ActionForward();
            forward.setPath("postDetail.do?boardId=" + bId);
            forward.setRedirect(true);
            return forward;
        }

        int memNo = (int) request.getSession(false).getAttribute("memNo");

        Map<String, Object> map = new HashMap<>();
        map.put("commentsId", cId);
        map.put("memNo", memNo);

// 1) 좋아요 먼저 삭제 (FK 방지) - 트리 전체(부모+모든 자식)
        CommentsServiceImpl.getInstance().deleteCommentLikesByCommentTree(cId);

// 2) 댓글 트리 삭제 (부모+모든 자식)
        int result = CommentsServiceImpl.getInstance().commentsDeleteTree(map);

        if (result == 0) {
            System.err.println("댓글 삭제 실패(권한/대상없음). commentsId=" + cId + ", memNo=" + memNo);
        }

        // 페이지 이동 설정 (에러나도 리다이렉트 실행)
        ActionForward forward = new ActionForward();
        // 삭제 성공 여부와 상관없이 상세페이지로 돌아가게 설정 (사용자 경험상 더 좋음)
        forward.setPath("postDetail.do?boardId=" + bId);
        forward.setRedirect(true);

        return forward;
    }
}