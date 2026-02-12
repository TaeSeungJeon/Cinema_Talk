package Controller.Vote;

import java.util.List;

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

public class VoteContController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		VoteService voteService = new VoteServiceImpl();
		HttpSession session = request.getSession();

		// Integer mem_no = (Integer) session.getAttribute("id");
		// int voteId = Integer.parseInt(request.getParameter("vote_id")) ;
		// System.out.println("mem_no: " + mem_no);
		// System.out.println("vote_id: " + voteId);

		// VoteRecordDTO tempVrecDTO = new VoteRecordDTO();
		// tempVrecDTO.setMem_no(mem_no);

		// VoteRegisterDTO vregDto = voteService.getVoteRegById(voteId); //해당 투표의 정보 가져오기
		// VoteRecordDTO vrecDto = voteService.getVoteRecordByMemNo(tempVrecDTO); //사용자의 선택한 영화를 조회하기
		// List<VoteResultDTO> vResultDtO = voteService.getVoteResult(voteId); //해당 투표의 집계
		// List<VoteRecordDTO> vrecListDto = voteService.getVoteRecordByVoteId(voteId); //해당 투표의 댓글 수집하기
		
		// vregDto.setUserChoice(vrecDto.getMovie_id());
		// vregDto.setResultList(vResultDtO);
		
		// request.setAttribute("voteInfo", vregDto);
		// request.setAttribute("voteRecordList", vrecListDto);


		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/vote_detail.jsp");
		return forward;
	}

}
