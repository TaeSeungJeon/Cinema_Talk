package Controller.Member.MyPage;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import DTO.Member.MyPage.MyPageDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import Service.Member.MyPage.MyPageService;
import Service.Member.MyPage.MyPageServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class MyPageController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		ActionForward forward = new ActionForward();
		MemberService memberService = new MemberServiceImpl();
		MyPageService myPageService = new MyPageServiceImpl();
		HttpSession session = request.getSession(false);
		
		// 세션 체크
		if (session == null || session.getAttribute("memId") == null) {
			forward.setRedirect(true);
			forward.setPath("memberLogin.do");
			return forward;
		}

		// 세션에서 memId 꺼내기
		String memId = (String) session.getAttribute("memId");

		// DB에서 사용자 정보 조회
		MemberDTO member = memberService.loginCheck(memId);

		if (member == null) {
			session.invalidate();
			forward.setRedirect(true);
			forward.setPath("memberLogin.do");
			return forward;
		}

		// 마이페이지 정보 조회 (게시글, 댓글, 투표 목록 및 통계)
		MyPageDTO myPageInfo = myPageService.getMyPageInfo(member.getMemNo());
		myPageInfo.setMemId(member.getMemId());
		myPageInfo.setMemName(member.getMemName());
		myPageInfo.setMemDate(member.getMemDate());

		// 뷰에 데이터 전달
		request.setAttribute("member", member);
		request.setAttribute("myPageInfo", myPageInfo);
		
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/member/mypage/myPage.jsp");
		return forward;
	}
}
