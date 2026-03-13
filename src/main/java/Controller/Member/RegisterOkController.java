package Controller.Member;

import org.mindrot.jbcrypt.BCrypt;

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
		
		ActionForward forward = new ActionForward();
		MemberService memberService = new MemberServiceImpl();
		
		//입력받은 회원 정보를 저장하는 변수 선언 후 정보 저장 + trim
		String memId = request.getParameter("mem-id"); //회원 아이디
		String memPwd = request.getParameter("mem-pwd"); //회원 비밀번호
		String memName = request.getParameter("mem-name"); //회원 이름
		String memPhone = request.getParameter("mem-phone"); //회원 전화번호
		String memEmail = request.getParameter("mem-email"); //회원 이메일
		
		memId = (memId == null) ? "" : memId.trim();
		memPwd = (memPwd == null) ? "" : memPwd.trim();
		memName = (memName == null) ? "" : memName.trim();
		memPhone = (memPhone == null) ? "" : memPhone.trim();
		memEmail = (memEmail == null) ? "" : memEmail.trim();
		
		//서버에서 필수 입력 체크 재확인(보안상 한번 더 체크)
		if (memId.isEmpty()) {
            request.setAttribute("msg", "아이디를 입력하세요.");
            forward.setRedirect(false);
            forward.setPath("/WEB-INF/views/member/register.jsp"); // 회원가입 jsp 경로로
            return forward;
        }

        if (memPwd.isEmpty()) {
            request.setAttribute("msg", "비밀번호를 입력하세요.");
            forward.setRedirect(false);
            forward.setPath("/WEB-INF/views/member/register.jsp");
            return forward;
        }

        if (memName.isEmpty()) {
            request.setAttribute("msg", "이름을 입력하세요.");
            forward.setRedirect(false);
            forward.setPath("/WEB-INF/views/member/register.jsp");
            return forward;
        }
        
        if (memPhone.isEmpty()) {
            request.setAttribute("msg", "전화번호를 입력하세요.");
            forward.setRedirect(false);
            forward.setPath("/WEB-INF/views/member/register.jsp");
            return forward;
        }
        
        if (memEmail.isEmpty()) {
            request.setAttribute("msg", "이메일을 입력하세요.");
            forward.setRedirect(false);
            forward.setPath("/WEB-INF/views/member/register.jsp");
            return forward;
        }
        
        //비밀번호 암호화
        String encPwd = BCrypt.hashpw(memPwd, BCrypt.gensalt());
        
		MemberDTO member = new MemberDTO(); //dto객체를 만들고
		
		//dto 저장빈 클래스 안에 있는 변수에 담아서 service -> dao로 접근
		member.setMemId(memId);
		member.setMemPwd(encPwd); //암호화된 비밀번호 저장
		member.setMemName(memName);
		member.setMemPhone(memPhone);
		member.setMemEmail(memEmail);
		
		memberService.insertMember(member); //회원저장
		
		forward.setRedirect(true);
		forward.setPath(request.getContextPath() + "/memberLogin.do?join=success"); //회원가입 완료 후 로그인 페이지로 매핑 및 회원가입 완료 메시지
		return forward;
	}

}
