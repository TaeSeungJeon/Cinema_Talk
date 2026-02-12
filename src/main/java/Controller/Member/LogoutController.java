package Controller.Member;

import Controller.Action;
import Controller.ActionForward;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/* 회원 로그아웃 컨트롤러 */
public class LogoutController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession();
		
		if(session != null) {
			session.invalidate(); //세션 만료 -> 로그아웃
		}
	
		ActionForward forward = new ActionForward();	
		forward.setRedirect(true);
		forward.setPath("index.do"); //메인화면으로 이동
		return forward;
	}

}
