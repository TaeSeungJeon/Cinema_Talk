package Controller.Vote;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

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

		

		//로그인 사용자 정보 가져오기
		Object memIdAttr = session.getAttribute("memId");
		String memId = null;
		if(memIdAttr != null) {
			if( memIdAttr instanceof String) {
				memId = (String) memIdAttr;
			}

		}

		MemberDTO mem = null;
		if(memId != null) {
			mem = memberService.idCheck(memId);		
		}
		final MemberDTO finalMem = mem;
		
		
		voteRegFullList.forEach(vote -> {
			//현재 시간 기준으로 상태(READY, ONGOING, CLOSED) 업데이트
			voteService.updateVoteStatus(vote);
			
			VoteRecordDTO temp = new VoteRecordDTO();
			temp.setVoteId(vote.getVoteId());
			
			
			//로그인했을때만 참여기록 확인
			if(finalMem != null) {
				temp.setMemNo(finalMem.getMemNo());
				VoteRecordDTO vrec = voteService.getVoteRecordByMemNo(temp);
				vote.setUserChoice(vrec.getMovieId());
				
			}
			
			//결과 집계
			if("CLOSED".equals(vote.getVoteStatus()) || (Integer) vote.getUserChoice() != null) {
				List<VoteResultDTO> voteResultList = voteService.getVoteResult(vote.getVoteId());
				vote.setResultList(voteResultList);
			}
		});
		
		
		List<VoteRegisterDTO> activeReg = new ArrayList<>();
		List<VoteRegisterDTO> readyReg = new ArrayList<>();
		List<VoteRegisterDTO> closedReg = new ArrayList<>();
		
		for(VoteRegisterDTO v : voteRegFullList) {
			if("ACTIVE".equals(v.getVoteStatus())) {
				
			}else if("READY".equals(v.getVoteStatus())) {
				
			}
		}
		
		
		
		request.setAttribute("voteRegisterActive", activeReg);
		request.setAttribute("voteRegisterReady", readyReg);
		request.setAttribute("voteRegisterClosed", closedReg);


	

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/voteList.jsp");
		return forward;
	}

}
