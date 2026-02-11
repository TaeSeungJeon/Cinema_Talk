package Controller.Member;

import Controller.Action;
import Controller.ActionForward;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* 로그인 뷰페이지 이동 컨트롤러 */
public class LoginController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		
		System.out.println("여기는 로그인 컨트롤러");
		forward.setPath("/WEB-INF/views/member/login.jsp");
		return forward;
	}

}
