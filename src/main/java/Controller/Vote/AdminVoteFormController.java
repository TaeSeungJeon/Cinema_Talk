package Controller.Vote;

import Controller.Action;
import Controller.ActionForward;
import DTO.Vote.VoteRegisterDTO;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminVoteFormController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    ActionForward forward = new ActionForward();
    
    String state = request.getParameter("state");
    String voteIdstr = request.getParameter("voteId");
    if(state != null && "edit".equals(state) && voteIdstr != null) {
    	int voteId = Integer.parseInt(voteIdstr);
    	VoteService voteService = new VoteServiceImpl();
    	
    	VoteRegisterDTO voteReg = voteService.getVoteRegFullById(voteId);
    	voteService.updateVoteStatus(voteReg);
    	request.setAttribute("vote", voteReg);
    }
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/adminVoteForm.jsp");
		return forward;
    }
    
}
