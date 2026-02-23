package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import Service.Board.CommentsServiceImplDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class CommentsDeleteOkController implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int cId = Integer.parseInt(request.getParameter("commentsId"));
        int bId = Integer.parseInt(request.getParameter("boardId"));

        // 세션에서 본인 확인용 memNo 가져오기
        int memNo = (int) request.getSession().getAttribute("memNo");

        Map<String, Object> map = new HashMap<>();
        map.put("commentsId", cId);
        map.put("memNo", memNo);

        // 실행 및 예외처리
        try {
            // 서비스 호출하여 삭제 실행
            CommentsServiceImplDAO.getInstance().commentsDelete(map);
        } catch (Exception e) {
            // 삭제 중 에러(예: 외래키 제약조건 위반)가 발생해도 로그만 찍고 멈추지 않음
            System.err.println("댓글 삭제 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
        // 페이지 이동 설정 (에러나도 리다이렉트 실행)
        ActionForward forward = new ActionForward();
        // 삭제 성공 여부와 상관없이 상세페이지로 돌아가게 설정 (사용자 경험상 더 좋음)
        forward.setPath("postDetail.do?boardId=" + bId);
        forward.setRedirect(true);

        return forward;
    }
}