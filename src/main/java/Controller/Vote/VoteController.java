package Controller.Vote;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Vote.VoteRecordDTO;
import DTO.Vote.VoteRegisterDTO;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class VoteController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {

		VoteService voteService = new VoteServiceImpl();

		List<VoteRegisterDTO> voteReglist = voteService.getVoteRegList();
		List<VoteRecordDTO> voteReclist = voteService.getVoteRecordList();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();

		for(VoteRegisterDTO v : voteReglist){

			Date start = sdf.parse(v.getVote_start_date());
			Date end   = sdf.parse(v.getVote_end_date());

			if(now.before(start)){
				v.setVote_status("READY");
			}else if(now.after(end)){
				v.setVote_status("CLOSED");
			}else{
				v.setVote_status("ACTIVE");
			}
		}

		request.setAttribute("vote_register", voteReglist);
		request.setAttribute("vote_records", voteReclist);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/vote.jsp");
		return forward;
	}

}
