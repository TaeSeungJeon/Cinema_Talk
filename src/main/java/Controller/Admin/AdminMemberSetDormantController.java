package Controller.Admin;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* 관리자 마이페이지 중 회원관리 회원 상태(정상 -> 정지) 전환 컨트롤러 */
public class AdminMemberSetDormantController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		int memNo = Integer.parseInt(request.getParameter("memNo"));
		
		MemberService memberService = new MemberServiceImpl();
		int result = memberService.changeDormant(memNo); 
		
		if(result > 0) {
			out.print("{\"success\":true}");
		} else {
			out.print("{\"success\":false,\"message\":\"이미 휴면회원이거나 대상이 없습니다.\"}");
		}
		
		return null;
	}

}
