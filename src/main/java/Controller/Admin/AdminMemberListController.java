package Controller.Admin;

import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* 회원목록 조회하는 컨트롤러 */
public class AdminMemberListController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String memState = request.getParameter("mem-state"); //상태 드롭다운 값 ("" 또는 1,2,3)
		String keyword = request.getParameter("keyword"); //이름/아이디 검색
		
		// keyword 정리
	    if (keyword != null) keyword = keyword.trim();
	    if (keyword != null && keyword.isEmpty()) keyword = null;

	    // memState 정리 (빈값이면 null 처리만)
	    if (memState != null && memState.isBlank()) {
	        memState = null;
	    }
	    
		MemberService memberService = new MemberServiceImpl();
		List<MemberDTO> memberList;
		
		if (keyword == null && memState == null) {
		    memberList = memberService.getMemberList();                 // 1) 전체
		} else if (keyword == null) {
		    memberList = memberService.getMemberListByState(memState);  // 2) 상태만
		} else if (memState == null) {
		    memberList = memberService.searchMembers(keyword);          // 3) 검색만
		} else {
		    memberList = memberService.searchMembersByState(keyword, memState); // 4) 검색+상태
		}
		
		request.setAttribute("memberList", memberList);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/admin/adminMemberList.jsp");
		return forward;
	}

}
