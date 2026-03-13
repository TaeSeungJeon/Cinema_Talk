package Controller.Admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		
		// 파라미터 받기
        String memState = request.getParameter("mem-state");
        String keyword = request.getParameter("keyword");
        String pageStr = request.getParameter("page");

        // keyword 정리
        if (keyword != null) keyword = keyword.trim();
        if (keyword != null && keyword.isEmpty()) keyword = null;

        // memState 정리
        if (memState != null && memState.isBlank()) memState = null;

        // page 정리
        int page = 1;
        if (pageStr != null && !pageStr.isBlank()) {
            try { page = Integer.parseInt(pageStr); } catch (NumberFormatException e) { page = 1; }
        }
        if (page < 1) page = 1;

        // 페이징 설정
        int limit = 11;
        int blockSize = 5;

        MemberService memberService = new MemberServiceImpl();

        //totalCount (count 매퍼 1개로 통합)
        Map<String, Object> countParam = new HashMap<>();
        countParam.put("keyword", keyword);
        countParam.put("memState", memState);

        int totalCount = memberService.countMembers(countParam);
        
        // maxpage 계산 + page 보정
        int maxpage = (int) Math.ceil((double) totalCount / limit);
        if (maxpage == 0) maxpage = 1;
        if (page > maxpage) page = maxpage;

        // startRow/endRow (보정된 page 기준)
        int startRow = (page - 1) * limit + 1;
        int endRow = page * limit;

        // memberList (각 페이징된 메서드 호출)
        List<MemberDTO> memberList;
        if (keyword == null && memState == null) {
            memberList = memberService.getMemberList(startRow, endRow);
        } else if (keyword == null) {
            memberList = memberService.getMemberListByState(memState, startRow, endRow);
        } else if (memState == null) {
            memberList = memberService.searchMembers(keyword, startRow, endRow);
        } else {
            memberList = memberService.searchMembersByState(keyword, memState, startRow, endRow);
        }

        //startpage/endpage 계산
        int startpage = ((page - 1) / blockSize) * blockSize + 1;
        int endpage = startpage + blockSize - 1;
        if (endpage > maxpage) endpage = maxpage;

        //JSP 전달 값 세팅
        request.setAttribute("memberList", memberList);
        request.setAttribute("page", page);
        request.setAttribute("startpage", startpage);
        request.setAttribute("endpage", endpage);
        request.setAttribute("maxpage", maxpage);

        //Ajax면 fragment로 forward
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("/WEB-INF/views/admin/adminMemberList.jsp");
        return forward;
	}

}
