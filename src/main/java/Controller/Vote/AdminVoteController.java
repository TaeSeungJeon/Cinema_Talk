package Controller.Vote;

import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import DTO.Vote.VoteRegisterDTO;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
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
    	
    	VoteService voteService = new VoteServiceImpl();
    	
    	List<VoteRegisterDTO> voteRegFullList = voteService.getVoteRegFullList();
    	voteRegFullList.forEach(vote -> {
    		voteService.updateVoteStatus(vote);
    	});
    	
    	request.setAttribute("voteRegFullList", voteRegFullList);
    	
		
    ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/adminVote.jsp");
		return forward;
    }
    
}
