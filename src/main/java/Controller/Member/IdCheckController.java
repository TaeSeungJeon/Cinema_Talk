package Controller.Member;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* 아이디 중복 검색 컨트롤러 (json 응답) */
public class IdCheckController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		response.setContentType("application/json; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		MemberService memberService = new MemberServiceImpl(); 
		
		//JS에서 data : {"memId" : memId}로 보내니까
		String memId = request.getParameter("memId"); 
		memId = (memId == null) ? "" : memId.trim();
		
		//아이디 입력 안 했으면
		if(memId.isEmpty()) {
			out.println("{\"available\":false,\"msg\":\"아이디를 입력하세요.\"}");
			out.flush();
			return null;
		}
		
		MemberDTO db_id = memberService.idCheck(memId);	//DB에 있으면 중복
		
		boolean available = (db_id == null);
		
		String msg = available ? "사용 가능한 아이디입니다." : "이미 사용 중인 아이디입니다.";
		
		//Json 출력
		String json = "{\"available\":" + available + ",\"msg\":\"" + msg + "\"}";
		
		out.println(json);
		out.flush();
		
		return null; //ajax 응답이라 forward 없음
	}

}
