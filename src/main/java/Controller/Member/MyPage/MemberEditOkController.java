package Controller.Member.MyPage;

import Controller.Action;
import Controller.ActionForward;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MemberEditOkController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("/MyPage.me");
		return forward;
	}

}
