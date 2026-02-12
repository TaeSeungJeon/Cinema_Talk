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
		
		MemberService memberService = new MemberServiceImpl();
		
		//아이디로 회원 조회
		MemberDTO mdto = memberService.loginCheck(id);
		
		ActionForward forward = new ActionForward();
		
		//아이디가 없으면
		if(mdto == null) {
			request.setAttribute("msg", "가입 안 된 회원입니다.");
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/member/login.jsp");
			return forward;
		}
		
		//비밀번호 검증(BCrypt)
		if(!BCrypt.checkpw(pwd, mdto.getMemPwd())) {
			request.setAttribute("msg", "비밀번호가 다릅니다.");
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/member/login.jsp");
			return forward;
		}
		
		//로그인 성공 -> 세션 저장 후 redirect
		HttpSession session = request.getSession();
		session.setAttribute("memId", id); // 세션에 저장할 키이름 : memId, 저장할 값 : id
		
		forward.setRedirect(true);
		forward.setPath("index.do"); //메인페이지로 이동
		return forward;
	}

}
