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

public class MemberEditOkController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		ActionForward forward = new ActionForward();
		MemberService memberService = new MemberServiceImpl();
		HttpSession session = request.getSession(false);
		MyPageService myPageService = new MyPageServiceImpl();
			
		String memId = (String) session.getAttribute("memId");

		// DB에서 사용자 정보 조회
		MemberDTO member = memberService.loginCheck(memId);
		
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
