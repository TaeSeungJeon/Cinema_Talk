package Controller.Member;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* 입력받은 회원 정보를 저장하는 컨트롤러 (회원가입) */
public class RegisterOkController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		MemberService memberService = new MemberServiceImpl(); //를 통해 dao로 가서 db에 접근하려고 -> 입력받은 정보를 저장하려고
		
		String memId = request.getParameter("mem-id"); //회원 아이디
		String memPwd = request.getParameter("mem-pwd"); //회원 비밀번호
		String memName = request.getParameter("mem-name"); //회원 이름
		String memPhone = request.getParameter("mem-phone"); //회원 전화번호
		String memEmail = request.getParameter("mem-email"); //회원 이메일
		//입력받은 회원 정보를 저장하는 변수 선언 후 정보 저장
		
		MemberDTO member = new MemberDTO(); //dto객체를 만들고
		
		//dto 저장빈 클래스 안에 있는 변수에 담아서 service -> dao로 접근
		member.setMemId(memId);
		member.setMemPwd(memPwd);
		member.setMemName(memName);
		member.setMemPhone(memPhone);
		member.setMemEmail(memEmail);
		
		memberService.insertMember(member); //회원저장
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("memberLogin.do"); //로그인 매핑주소로 이동
		return forward;
	}

}
