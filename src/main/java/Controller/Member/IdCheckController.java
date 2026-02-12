package Controller.Member;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* 아이디 중복 검색 컨트롤러 */
public class IdCheckController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		response.setContentType("text/html; charset=utf-8"); //웹브라우제에 출력되는 문자와 태그 언어코딩 타입 설정
		PrintWriter out = response.getWriter();
		MemberService memberService = new MemberServiceImpl(); //서비스 안에서 dao호출하고 db 접근했을테니까 dao를 호출하지 않아도 되겠구나
		
		String memId = request.getParameter("mem-id"); 
		
		MemberDTO db_id = memberService.idCheck(memId);
		
		int re = -1; //중복 없음
		
		if(db_id != null) { //중복 아이디가 있는 경우
			re = 1;
		}
		
		out.println(re); //값 반환
		
		return null;
	}

}
