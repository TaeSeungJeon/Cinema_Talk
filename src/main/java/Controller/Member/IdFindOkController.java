package Controller.Member;

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
		MemberService memberService = new MemberServiceImpl();
		MemberDTO mdto = new MemberDTO();
		
		//입력받은 이름, 전화번호 변수에 저장
		String memName = request.getParameter("mem-name");
		String memPhone = request.getParameter("mem-phone");  
		
		//DTO 변수에 저장
		mdto.setMemName(memName); mdto.setMemPhone(memPhone);
		
		//이름과 전화번호를 기준으로 DB로부터 회원정보 검색
	
		return null;
	}

}
