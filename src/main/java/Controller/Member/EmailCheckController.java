package Controller.Member;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//이메일 중복체크 컨트롤러
public class EmailCheckController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		MemberService memberService = new MemberServiceImpl();
		
		//JS에서 data: {memEmail : memEmail}로 보내니까
		String memEmail = request.getParameter("memEmail");
		memEmail = (memEmail == null) ? "" : memEmail.trim();
		
		MemberDTO db_email = memberService.emailCheck(memEmail);
		
		boolean available = (db_email == null); 
		System.out.println("available"+available);
		
		String msg = available ? "사용 가능한 이메일 주소입니다." : "이미 가입된 이메일 주소입니다.";
		
		String json = "{\"available\":" + available + ",\"msg\":\"" + msg + "\"}";
		
		out.println(json);
		out.flush();
		
		return null;
	}

}
