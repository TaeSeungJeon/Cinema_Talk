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
		
		//등록되지 않은 회원일 경우
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
			
			// 이메일 마스킹 처리
			String maskedEmail = maskEmail(mdto.getMemEmail());
			
			//jsp에 전달(모달 띄울 때 사용)
			request.setAttribute("sendEmail", maskedEmail);
			
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/member/findAccount.jsp");
			return forward;
			
		}else {
			request.setAttribute("msg", "메일 전송에 실패했습니다. 잠시 후 다시 시도해주세요.");
			
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/member/findAccount.jsp");
			return forward;
		}
	}
	
	//이메일 마스킹 함수 ex) yunhano@gmail.com -> y***o@gmail.com
			private String maskEmail(String email) {
				if(email == null || !email.contains("@")) return email;
				
				String[] parts = email.split("@");
				String id = parts[0];
				String domain = parts[1];
				
				if(id.length() <= 2) {
					return id.charAt(0) + "***@" + domain;
				}
				
				return id.charAt(0) + "***" + id.charAt(id.length()-1) + "@" + domain;
			}

}
