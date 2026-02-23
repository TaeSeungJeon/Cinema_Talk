package Controller.Member.AdminMyPage;

import Controller.Action;
import Controller.ActionForward;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* 관리자 마이페이지 이동 컨트롤러 */
public class AdminMyPageController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false); //기존매핑주소 유지하며 이동
		forward.setPath("/WEB-INF/views/member/mypage/adminMyPage.jsp"); //뷰페이지 경로 설정
		
		return forward;
	}

}
