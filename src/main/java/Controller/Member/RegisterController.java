package Controller.Member;

import Controller.Action;
import Controller.ActionForward;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* 회원가입 페이지(register.jsp)로 이동시키는 컨트롤러 */
public class RegisterController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false); //기존매핑주소 유지하며 이동
		forward.setPath("/WEB-INF/views/member/register.jsp"); //뷰페이지 경로 설정
		
		return forward;
	}
	
	
}
