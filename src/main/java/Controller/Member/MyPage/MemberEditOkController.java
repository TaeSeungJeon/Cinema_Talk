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
		String memId = request.getParameter("mem-id"); //회원 아이디
		String memPwd = request.getParameter("mem-pwd"); //회원 비밀번호
		String memPassword = BCrypt.hashpw(memPwd, BCrypt.gensalt(12));
		String memName = request.getParameter("mem-name"); //회원 이름
		String memPhone = request.getParameter("mem-phone"); //회원 전화번호
		String memEmail = request.getParameter("mem-email"); //회원 이메일
		
		MemberDTO member = memberService.getMemberInfo(memNo); // 아이디로 회원 정보 조회 (비밀번호 검증을 위해)
		member.setMemNo(memNo);
		member.setMemId(memId);
		// DTO에 암호화된 비밀번호 다시 저장
		member.setMemPwd(memPassword);
		member.setMemName(memName);
		member.setMemPhone(memPhone);
		member.setMemEmail(memEmail);
		
		myPageService.updateMemberInfo(member);
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
