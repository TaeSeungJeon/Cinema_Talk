package Controller.Admin;

import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminMemberListController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String memState = request.getParameter("mem-state"); // 공백 또는 1,2,3
		
		MemberService memberService = new MemberServiceImpl();
		List<MemberDTO> memberList;
		
		// 상태 선택 안 했다면 -> 전체 조회
		if(memState == null || memState.equals("")) {
			memberList = memberService.getMemberList();
		}else { // 상태 선택했으면 -> 상태 조회
			memberList = memberService.getMemberListByState(Integer.parseInt(memState));
		}
		
		request.setAttribute("memberList", memberList);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/admin/adminMemberList.jsp");
		return forward;
	}

}
