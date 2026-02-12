package Controller.Member;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class MyPageController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 마이페이지 뷰로 포워딩
		ActionForward forward = new ActionForward();
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		MemberService memberService = new MemberServiceImpl();
		HttpSession session = request.getSession(false);
		
		if (session == null || session.getAttribute("mem_id") == null) {
			forward.setRedirect(true);
			forward.setPath("/WEB-INF/views/member/login.do");
			return forward;
		}

		// 세션에서 mem_id 꺼내기
		Object memIdObj = session.getAttribute("mem_id");
		if (!(memIdObj instanceof String)) {
			session.invalidate();
			forward.setRedirect(true);
			forward.setPath("/WEB-INF/views/member/login.do");
			return forward;
		}
		String memId = (String) memIdObj;

		// DB에서 사용자 정보 조회
		MemberDTO member = memberService.loginCheck(memId);

		if (member == null) {
			session.invalidate();
			forward.setRedirect(true);
			forward.setPath("/WEB-INF/views/member/login.do");
			return forward;
		}

		// 뷰에 회원 정보 + 게시판, 댓글, 투표 이력 + 선호 장르 정보 전달
		request.setAttribute("member", member);
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/member/myPage.jsp");
		return forward;
	}
}
