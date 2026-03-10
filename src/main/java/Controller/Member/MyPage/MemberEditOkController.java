package Controller.Member.MyPage;

import org.mindrot.jbcrypt.BCrypt;

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
		HttpSession session = request.getSession(false);
		
		MemberService memberService = new MemberServiceImpl();
		MyPageService myPageService = new MyPageServiceImpl();
		
		int memNo = (int) session.getAttribute("memNo");
		
		// 기존 회원 정보 조회
		MemberDTO member = memberService.getMemberInfo(memNo);
		
		// 각 필드를 선택적으로 업데이트: 입력값이 있을 때만 반영, 없으면 기존값 유지
		String memPwd = request.getParameter("mem-pwd");
		String memName = request.getParameter("mem-name");
		String memPhone = request.getParameter("mem-phone");
		String memEmail = request.getParameter("mem-email");
		
		// 비밀번호: 입력된 경우에만 암호화하여 세팅
		if (memPwd != null && !memPwd.trim().isEmpty()) {
			member.setMemPwd(BCrypt.hashpw(memPwd.trim(), BCrypt.gensalt(12)));
		}
		
		// 이름: 입력된 경우에만 세팅
		if (memName != null && !memName.trim().isEmpty()) {
			member.setMemName(memName.trim());
		}
		
		// 전화번호: 입력된 경우에만 세팅
		if (memPhone != null && !memPhone.trim().isEmpty()) {
			member.setMemPhone(memPhone.trim());
		}
		
		// 이메일: 입력된 경우에만 세팅
		if (memEmail != null && !memEmail.trim().isEmpty()) {
			member.setMemEmail(memEmail.trim());
		}
		
		myPageService.updateMemberInfo(member);
		
		// 수정된 회원정보 다시 조회
		member = memberService.getMemberInfo(memNo);
		
		// 마이페이지 정보 조회 (게시글, 댓글, 투표 목록 및 통계)
		MyPageDTO myPageInfo = myPageService.getMyPageInfo(member.getMemNo());
		myPageInfo.setMemId(member.getMemId());
		myPageInfo.setMemName(member.getMemName());
		myPageInfo.setMemDate(member.getMemDate());
		
		// 뷰에 데이터 전달
		request.setAttribute("member", member);
		request.setAttribute("myPageInfo", myPageInfo);
		
		request.setAttribute("allGenreList", myPageService.getAllGenres());
		request.setAttribute("profileMsg", "회원 정보가 성공적으로 수정되었습니다.");
		request.setAttribute("canLogout", true);
		
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/member/mypage/myPage.jsp");
		return forward;
	}

}
