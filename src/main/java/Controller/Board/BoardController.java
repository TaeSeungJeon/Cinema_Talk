package Controller.Board;

import Controller.Action;import Controller.ActionForward;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BoardController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        ActionForward forward = new ActionForward();
        // 이동할 JSP 경로를 지정합니다.
        forward.setPath("/freeBoard.jsp");
        forward.setRedirect(false); // Forward 방식 사용
                    // 재연결한다 = 새로고침 한다.
        return forward; // ★ null 대신 생성한 객체를 반환하세요!
    }
}