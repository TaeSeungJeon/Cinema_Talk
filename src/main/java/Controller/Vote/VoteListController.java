package Controller.Vote;

import java.util.List;


import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import DTO.Vote.VoteRecordDTO;
import DTO.Vote.VoteRegisterDTO;
import DTO.Vote.VoteResultDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class VoteListController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		VoteService voteService = new VoteServiceImpl();
		MemberService memberService = new MemberServiceImpl();
		HttpSession session = request.getSession();

		//투표전체를 가져와서
		//상태 지정하고 투표전체에 set하고
		//종료투표는 댓글기록과 집계 가져오고 투표전체에 set하고
		//로그인 안된 사용자는 투표전체를 바로 setAttribute하고
		//로그인된 사용자는 투표상태 상관없이 본인이 참여한 투표에 본인 선택을 지정하기

		//모든 투표목록 가져오기
		List<VoteRegisterDTO> voteRegFullList = voteService.getVoteRegFullList();

		voteRegFullList=voteService.sortVote(voteRegFullList);
		

		//로그인 사용자 정보 가져오기
		String memId = (String) session.getAttribute("memId"); // 값이 없으면 자동으로 null
		MemberDTO mem = (memId != null) ? memberService.idCheck(memId) : null;
		
		final MemberDTO finalMem = mem;

		Object filterObj = request.getParameter("filter");
		String filter = filterObj == null ? null : (String) filterObj;
		
		
		voteRegFullList.forEach(vote -> {
			//현재 시간 기준으로 상태(READY, ONGOING, CLOSED) 업데이트
			voteService.updateVoteStatus(vote);
			vote.setVoted(false);
			VoteRecordDTO temp = new VoteRecordDTO();
			temp.setVoteId(vote.getVoteId());
			
			
			//로그인했을때만 참여기록 확인
			if(finalMem != null) {
				temp.setMemNo(finalMem.getMemNo());
				VoteRecordDTO vrec = voteService.getVoteRecordByMemNoVoteId(temp);
				if(vrec != null){
					vote.setUserChoice(vrec.getMovieId());
					vote.setVoted(true);
				}
				
				
			}
			
			//결과 집계
			if(vote.isVoted() || "CLOSED".equals(vote.getVoteStatus())){
				List<VoteResultDTO> voteResultList = voteService.getVoteResult(vote.getVoteId());
				vote.setResultList(voteResultList);
			}
		});
		
		
		
		request.setAttribute("voteRegisterAll", voteRegFullList);
		if(filter != null)
		request.setAttribute("filter", filter);
		

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/voteList.jsp");
		return forward;
	}

}
