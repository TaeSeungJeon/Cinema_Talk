package Controller.Admin;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

<<<<<<< HEAD
/* 관리자 마이페이지 중 회원관리 회원 상태 전환 컨트롤러 */
=======
/* 관리자 마이페이지 중 회원관리 회원 상태(정상 -> 정지) 전환 컨트롤러 */
>>>>>>> refs/remotes/origin/YoonHa
public class AdminMemberSetDormantController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int memNo = Integer.parseInt(request.getParameter("memNo"));
		int targetState = Integer.parseInt(request.getParameter("targetState")); //1(정상) 또는 2(정지)
		
		if (targetState != 1 && targetState != 2) {
			  response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			  return null;
			}
		
		MemberService memberService = new MemberServiceImpl();
		int result = memberService.updateMemberState(memNo, targetState);
		
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if(result > 0) {
			out.print("{\"success\":true}");
		} else {
			out.print("{\"success\":false,\"message\":\"대상이 없거나 상태 변경에 실패했습니다.\"}");
		}
		
		out.close();
		return null;
	}

}
