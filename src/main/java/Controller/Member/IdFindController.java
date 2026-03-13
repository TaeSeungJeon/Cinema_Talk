package Controller.Member;

import Controller.Action;
import Controller.ActionForward;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* 아이디/비밀번호 찾기 뷰페이지 이동 컨트롤러 */
public class IdFindController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/member/findAccount.jsp"); //아이디/비번찾기 페이지로 이동
		return forward;
	}

}
