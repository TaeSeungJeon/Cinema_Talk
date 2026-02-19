package Controller.Member;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* 비밀번호 찾기 결과 컨트롤러 */
public class PwdFindOkController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String memId = request.getParameter("mem-id");
		String memPhone = request.getParameter("mem-phone");
		
		MemberService memberService = new MemberServiceImpl();
		
		//입력받은 아이디와 전화번호를 기준으로 회원이 존재 확인
		MemberDTO mdto = memberService.findByIdAndPhone(memId, memPhone);
		
		if(mdto == null) {
			out.println("<script>");
			out.println("alert('입력하신 정보와 일치하는 회원이 없습니다.');");
			out.println("history.back();");
			out.println("</script>");
			return null;
		}
		
		//임시비번으로 재설정 + 메일 전송
		boolean ok = memberService.resetPwdSendEmail(mdto);
		
		if(ok) {
			out.println("<script>");
			out.println("alert('임시 비밀번호를 이메일로 전송했습니다. 로그인 후 비밀번호를 변경해주세요.');");
			out.println("location.href='" + request.getContextPath() + "/memberLogin.do';"); //여기 다시 확인
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('메일 전송에 실패했습니다. 잠시 후 다시 시도해주세요.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return null;
	}

}
