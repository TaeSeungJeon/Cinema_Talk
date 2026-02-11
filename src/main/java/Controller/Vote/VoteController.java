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
import DTO.Vote.VoteResultDTO;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class VoteController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		
	
				//DB에서  VOTE_REGISTER 레코드를 조회합니다.

				//READY, ACTIVE, CLOSED STATUS SET (상태 분류 및 집계)

				//closed 인 레지스터들은 setResultList

				//ACTIVE 인 레지스터들은 사용자 로그인 상태 판단해서 로그인된 사용자이면 setVoted = false  

				//setAttribute active, ready, closed (데이터 전달)

		VoteService voteService = new VoteServiceImpl();
		HttpSession session = request.getSession();

		//TODO
		session.setAttribute("id", null);
		Integer mem_no = (Integer) session.getAttribute("id");
		//Integer mem_no=17;

		List<VoteRegisterDTO> voteRegFullList = voteService.getVoteRegFullList();
		List<VoteRegisterDTO> activeReg = new ArrayList<>();
		List<VoteRegisterDTO> readyReg = new ArrayList<>();
		List<VoteRegisterDTO> closedReg = new ArrayList<>();
		List<VoteRecordDTO> voteReclist = voteService.getVoteRecordList();


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
				 v.setResultList(voteService.getVoteResult(v.getVote_id()));
				closedReg.add(v);
			}else{
				v.setVote_status("ACTIVE");
				
				 // 내가 투표했는지 확인
				boolean voted = false;

			    for(VoteRecordDTO r : voteReclist){
			    	
			        if(mem_no != null && r.getVote_id() == v.getVote_id() && r.getMem_no() == mem_no){
			        	
			            voted = true;
			            break;
			        }
			    }

			    v.setVoted(voted);

				if(mem_no != null && voted==false){//로그인된 상태이면 voted false 만 저장
				System.err.println(v.getVote_id());
				System.err.println(voted);	
activeReg.add(v);
				}else if(mem_no== null ){
					
activeReg.add(v);
				}

				
			}
}
	
		request.setAttribute("vote_register_all", voteRegFullList);
		request.setAttribute("vote_register_active", activeReg);
		request.setAttribute("vote_register_ready", readyReg);
		request.setAttribute("vote_register_closed", closedReg);
		request.setAttribute("vote_records", voteReclist);
		
		System.out.println("===============================================");


		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/vote.jsp");
		return forward;
	}

}
