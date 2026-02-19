package Controller.Vote;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminVoteController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

    //   HttpSession session = request.getSession();


		// //로그인 사용자 정보 가져오기
		// String memId = (String) session.getAttribute("memId"); // 값이 없으면 자동으로 null
		// MemberDTO mem = (memId != null) ? memberService.idCheck(memId) : null;
		
    ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/adminVote.jsp");
		return forward;
    }
    
}
