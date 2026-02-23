package Controller.Member.AdminMyPage;

import Controller.Action;
import Controller.ActionForward;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/* 관리자 마이페이지 이동 컨트롤러 */
public class AdminMyPageController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		ActionForward forward = new ActionForward();
		
		//로그인 안 했다면 -> 로그인 페이지로 이동
		if(session == null || session.getAttribute("memId") == null) {
			forward.setRedirect(true);
			forward.setPath(request.getContextPath() + "/memberLogin.do");
			return forward;
		}
		
		//관리자가 아니라면 -> 메인페이지로 이동
		Object roleObj = session.getAttribute("memRole");
		int role = (roleObj == null) ? 0 : Integer.parseInt(roleObj.toString());
		
		if(role != 1) {
			forward.setRedirect(true);
			forward.setPath(request.getContextPath() + "/index.do");
			return forward;
		}
		
		forward.setRedirect(false); //기존매핑주소 유지하며 이동
		forward.setPath("/WEB-INF/views/admin/adminMyPage.jsp"); //뷰페이지 경로 설정
		
		return forward;
	}

}
