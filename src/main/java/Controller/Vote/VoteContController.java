package Controller.Vote;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
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
		final MemberDTO finalMem = mem;
		Object filterObj = request.getParameter("filter");
		String filter = filterObj == null ? null : (String) filterObj;

		VoteRegisterDTO voteReg = voteService.getVoteRegFullById(voteId, false);
		voteService.updateVoteStatus(voteReg);

		boolean voted = false;
		
		String requestSessionURL = request.getRequestURL().toString();
        
        session.setAttribute("requestSessionURL", requestSessionURL  + "?voteId=" + voteId );
	
		if(mem != null){
			
			VoteRecordDTO temp = new VoteRecordDTO();
			temp.setMemNo(mem.getMemNo());
			temp.setVoteId(voteId);
			VoteRecordDTO voteRecord = voteService.getVoteRecordByMemNoVoteId(temp);

			if(voteRecord != null) {
				voteReg.setUserChoice(voteRecord.getMovieId());
				voted = true;
				
				
				if(voteRecord.getMovieDeleted() == 1) {
					voteReg.setChoiceDeleted(true);
				}
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
		System.out.println("=================================");
		System.out.println(voteReg.isVoted());
		
		request.setAttribute("voteInfo", voteReg);
		
		if(filter != null)
			request.setAttribute("filter", filter);
		
		//sidebar 전용 데이터
		List<VoteRegisterDTO> voteRegFullList = voteService.getVoteRegFullList();
		
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
					if(vrec.getMovieId() == 0) {
						request.setAttribute("isChoiceDeleted", true);
						request.setAttribute("movieTitleBackup", vrec.getMovieTitleBackup());
					}
				}
				
			}
			
			//결과 집계
			if(vote.isVoted() || "CLOSED".equals(vote.getVoteStatus()) || "ACTIVE".equals(vote.getVoteStatus())){
				List<VoteResultDTO> voteResultList = voteService.getVoteResult(vote.getVoteId());
				vote.setResultList(voteResultList);
			}
		});
	Map<String, List<VoteRegisterDTO>> groupedVotes = voteRegFullList.stream()
		.collect(Collectors.groupingBy(VoteRegisterDTO::getVoteStatus));

	
	List<VoteRegisterDTO> activeReg = groupedVotes.getOrDefault("ACTIVE", new ArrayList<>());
	List<VoteRegisterDTO> readyReg = groupedVotes.getOrDefault("READY", new ArrayList<>());
	List<VoteRegisterDTO> closedReg = groupedVotes.getOrDefault("CLOSED", new ArrayList<>());
		
		request.setAttribute("voteRegisterActive", activeReg.stream()
			    .filter(vote -> !vote.isVoted()) 
			    .sorted(Comparator.comparing(VoteRegisterDTO::getVoteEndDate)) 
			    .collect(Collectors.toList())); 

		request.setAttribute("voteRegisterReady", 
			readyReg.stream().sorted(Comparator.comparing(VoteRegisterDTO::getVoteStartDate).reversed()) 
			.limit(2).collect(Collectors.toList()));

		request.setAttribute("voteRegisterClosed", closedReg.stream()
	    .sorted(Comparator.comparing(VoteRegisterDTO::getVoteEndDate).reversed()) 
	    .limit(2)
	    .collect(Collectors.toList()));
		
				
				

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/voteDetail.jsp");
		return forward;
	}

}
