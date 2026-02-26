package Controller.Member;

import org.mindrot.jbcrypt.BCrypt;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/* 로그인 인증 컨트롤러 */
public class LoginOkController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//로그인 창에서 입력받은 아이디, 비번 변수에 저장
		String id = request.getParameter("mem-id");
		String pwd = request.getParameter("mem-pwd");
		
		ActionForward forward = new ActionForward();
		
		//아이디 입력 확인
		if(id == null || id.trim().isEmpty()) {
			request.setAttribute("msg", "아이디를 입력하세요.");
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/member/login.jsp");
			return forward;
		}
		
		//비밀번호 입력확인
		if(pwd == null || pwd.trim().isEmpty()) {
			request.setAttribute("msg", "비밀번호를 입력하세요.");
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/member/login.jsp");
			return forward;
		}
		
		MemberService memberService = new MemberServiceImpl();

		//아이디로 회원 조회
		MemberDTO mdto = memberService.loginCheck(id);

		//아이디가 없으면
		if(mdto == null) {
			request.setAttribute("msg", "가입되지 않은 회원입니다.");
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/member/login.jsp");
			return forward;
		}
		
		//계정 상태 체크(memState)
		if(mdto.getMemState() == 3) {
			request.setAttribute("msg", "탈퇴한 계정입니다.");
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/member/login.jsp");
			return forward;
		}
		if(mdto.getMemState() == 2) {
			request.setAttribute("msg", "휴먼 계정입니다. 관리자에게 문의하세요");
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/member/login.jsp");
			return forward;
		}
		
		//비밀번호 검증(BCrypt)
		if(!BCrypt.checkpw(pwd, mdto.getMemPwd())) {
			request.setAttribute("msg", "비밀번호가 일치하지 않습니다.");
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/member/login.jsp");
			return forward;
		}

		//로그인 성공 -> 세션 저장 후 redirect
		HttpSession session = request.getSession();
		session.setAttribute("memNo", mdto.getMemNo()); // 세션에 저장할 키이름 : memNo, 저장할 값 : No
		session.setAttribute("memId", mdto.getMemId()); // 세션에 저장할 키이름 : memId, 저장할 값 : id
		session.setAttribute("memName", mdto.getMemName()); // 세션에 저장할 키이름 : memId, 저장할 값 : id
		session.setAttribute("memRole", mdto.getMemRole());
		session.setAttribute("memState", mdto.getMemState());
		
		//마지막 로그인 날짜 업데이트
		memberService.updateLastLogin(mdto.getMemId());
	
		// 관리자/일반회원 이동
		forward.setRedirect(true);
		
		if(mdto.getMemRole() == 1) { //관리자일 때
			forward.setPath(request.getContextPath() + "/adminMypage.do");
		}else { //일반회원인 경우
			forward.setPath(request.getContextPath() + "/index.do");
		}
		return forward;
	}

}


