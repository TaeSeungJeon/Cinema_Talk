package Controller.Member;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* 아이디 찾기 결과 컨트롤러 */
public class IdFindOkController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		MemberService memberService = new MemberServiceImpl();
		MemberDTO mdto = new MemberDTO();
		
		//입력받은 이름, 전화번호 변수에 저장
		String memName = request.getParameter("mem-name");
		String memPhone = request.getParameter("mem-phone");  
		
		//입력 하지 않았다면
		if(memName == null || memName.trim().isEmpty() || memPhone == null || memPhone.trim().isEmpty()){
		    out.println("<script>alert('이름과 전화번호를 입력하세요.');history.back();</script>");
		    return null;
		}
		
		//DTO에 담기
		mdto.setMemName(memName.trim()); mdto.setMemPhone(memPhone.trim());
		
		//이름과 전화번호를 기준으로 DB로부터 회원정보 검색 (서비스 호출)
		MemberDTO pm = memberService.findId(mdto);
		
		//일치하는 회원 정보가 없을 때 반환할 내용
		if(pm == null) {
			 out.println("<script>");
			 out.println("alert('일치하는 회원정보가 없습니다.');");
			 out.println("history.back();");
			 out.println("</script>");
			return null;
		}
		
		// 아이디 찾기 성공 했다면
		request.setAttribute("findId", pm.getMemId());
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/member/findAccount.jsp"); // 아이디/비번찾기페이지로 이동
		return forward;
	}

}
