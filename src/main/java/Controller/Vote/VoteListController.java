package Controller.Vote;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import Controller.Action;
import Controller.ActionForward;
import DTO.Vote.VoteRecordDTO;
import DTO.Vote.VoteRegisterDTO;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class VoteListController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		VoteService voteService = new VoteServiceImpl();
		HttpSession session = request.getSession();

		List<VoteRegisterDTO> voteReglist = voteService.getVoteRegList();
		List<VoteRecordDTO> voteReclist = voteService.getVoteRecordList();
		List<VoteRegisterDTO> voteRegFullList = voteService.getVoteRegFullList();
		List<VoteRegisterDTO> voteRegActiveForMem = voteService.getVoteRegActiveForMem();
		List<VoteRegisterDTO> activeReg = new ArrayList<>();
		List<VoteRegisterDTO> readyReg = new ArrayList<>();
		List<VoteRegisterDTO> closedReg = new ArrayList<>();
		
		List<VoteRegisterDTO> voteRegFullListCopied = new ArrayList<>();

		for(VoteRegisterDTO v : voteRegFullList){

		    VoteRegisterDTO copy = new VoteRegisterDTO();

		    copy.setVote_id(v.getVote_id());
		    copy.setVote_title(v.getVote_title());
		    copy.setVote_content(v.getVote_content());
		    copy.setVote_start_date(v.getVote_start_date());
		    copy.setVote_end_date(v.getVote_end_date());
		    copy.setVote_status(v.getVote_status());
		    copy.setOptionList(v.getOptionList()); // optionList도 복사 필요하면 따로 deep copy

		    voteRegFullListCopied.add(copy);
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();

		for(VoteRegisterDTO v : voteRegFullList){

			Date start = sdf.parse(v.getVote_start_date());
			Date end   = sdf.parse(v.getVote_end_date());

			if(now.before(start)){
				v.setVote_status("READY");
				readyReg.add(v);
			}else if(now.after(end)){
				v.setVote_status("CLOSED");
				closedReg.add(v);
			}else{
				v.setVote_status("ACTIVE");
				activeReg.add(v);
			}
		}
		
		//TODO
		session.setAttribute("id", 17);
		Integer mem_no = (Integer) session.getAttribute("id");
		//Integer mem_no=17;
		if(mem_no != null) {
			for(VoteRegisterDTO v : voteRegFullList){

			    // 내가 투표했는지 확인
				boolean voted = false;

			    for(VoteRecordDTO r : voteReclist){
			    	
			        if(r.getVote_id() == v.getVote_id() && r.getMem_no() == mem_no){
			        	System.out.println(r.getVote_id());
				    	System.out.println(v.getVote_id());
			            voted = true;
			            break;
			        }
			    }

			    v.setVoted(voted);

			    // 종료된 투표
			    if("CLOSED".equals(v.getVote_status())){
			        v.setResultList(voteService.getVoteResult(v.getVote_id()));
			    }

			    // 진행중 + 내가 투표함
			    else if("ACTIVE".equals(v.getVote_status()) && voted){
			        v.setResultList(voteService.getVoteResult(v.getVote_id()));
			    }
			}
			
			
			List<VoteRegisterDTO> activeNotVoted =
				    voteRegFullList.stream()
				        .filter(v -> "ACTIVE".equals(v.getVote_status()) && !v.isVoted())
				        .collect(Collectors.toList());

				request.setAttribute("active_not_voted", activeNotVoted);
		}
		
		 activeReg = new ArrayList<>();
		 readyReg = new ArrayList<>();
		
		 
		 System.out.println(voteRegFullListCopied.size() + " voteRegFullListCopied");
		
		for(VoteRegisterDTO v : voteRegFullListCopied){
			

			Date start = sdf.parse(v.getVote_start_date());
			Date end   = sdf.parse(v.getVote_end_date());

			if(now.before(start)){
				v.setVote_status("READY");
				
				readyReg.add(v);
			}else if(now.after(end)){
				v.setVote_status("CLOSED");
				
			}else{
				v.setVote_status("ACTIVE");
				activeReg.add(v);
				
			}
			
		}
		
		
		request.setAttribute("vote_register_all", voteRegFullList);
		request.setAttribute("vote_register_active", activeReg);
		request.setAttribute("vote_register_ready", readyReg);
		request.setAttribute("vote_register_closed", closedReg);
		request.setAttribute("vote_records", voteReclist);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/vote_list.jsp");
		return forward;
	}

}
