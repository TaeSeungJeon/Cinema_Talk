package Controller.Vote;

import java.io.PrintWriter;
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

public class VoteContController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


		response.setContentType("text/html;charset=UTF-8");
		VoteService voteService = new VoteServiceImpl();
		MemberService memberService = new MemberServiceImpl();
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		int voteId = Integer.parseInt(request.getParameter("voteId")) ;

		//로그인 사용자 정보 가져오기
		String memId = (String) session.getAttribute("memId"); // 값이 없으면 자동으로 null
		MemberDTO mem = (memId != null) ? memberService.idCheck(memId) : null;

		VoteRegisterDTO voteReg = voteService.getVoteRegFullById(voteId);
		voteService.updateVoteStatus(voteReg);

		boolean voted = false;
	
		if(mem != null){
			
			VoteRecordDTO temp = new VoteRecordDTO();
			temp.setMemNo(mem.getMemNo());
			temp.setVoteId(voteId);
			VoteRecordDTO voteRecord = voteService.getVoteRecordByMemNo(temp);

			if(voteRecord != null) {
				voteReg.setUserChoice(voteRecord.getMovieId());
				voted = true;
			}

		}
		
		List<VoteResultDTO> voteResult = voteService.getVoteResult(voteId);
		
		if (voteResult != null && !voteResult.isEmpty()) {
		    // 리스트의 첫 번째 항목에서 전체 참여자 수를 가져와 주입
		    int totalCount = voteResult.get(0).getTotalVoterCount();
		    voteReg.setVoterCount(totalCount); 
		}
		
		if(voteReg.getVoteStatus().equals("CLOSED") || 
			(voteReg.getVoteStatus().equals("ACTIVE") && voted)) {
				
			voteReg.setResultList(voteResult);
			request.setAttribute("voteRecordList", voteService.getVoteRecordByVoteId(voteId));
		}
	

		voteReg.setVoted(voted);
		
		request.setAttribute("voteInfo", voteReg);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/voteDetail.jsp");
		return forward;
	}

}
