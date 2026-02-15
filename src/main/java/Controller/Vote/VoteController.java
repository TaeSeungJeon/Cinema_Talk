package Controller.Vote;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collector;
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

public class VoteController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {


		VoteService voteService = new VoteServiceImpl();
		MemberService memberService = new MemberServiceImpl();
		HttpSession session = request.getSession();


		//로그인 사용자 정보 가져오기
		String memId = (String) session.getAttribute("memId"); // 값이 없으면 자동으로 null
		MemberDTO mem = (memId != null) ? memberService.idCheck(memId) : null;
		
		final MemberDTO finalMem = mem;
		
		//DB에서  VOTE_REGISTER 레코드를 조회
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
				VoteRecordDTO vrec = voteService.getVoteRecordByMemNo(temp);
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
	Map<String, List<VoteRegisterDTO>> groupedVotes = voteRegFullList.stream()
		.collect(Collectors.groupingBy(VoteRegisterDTO::getVoteStatus));

	
	List<VoteRegisterDTO> activeReg = groupedVotes.getOrDefault("ACTIVE", new ArrayList<>());
	List<VoteRegisterDTO> readyReg = groupedVotes.getOrDefault("READY", new ArrayList<>());
	List<VoteRegisterDTO> closedReg = groupedVotes.getOrDefault("CLOSED", new ArrayList<>());

	request.setAttribute("voteRegisterActive", activeReg.stream()
    .filter(vote -> !vote.isVoted()) // 1. 아직 참여하지 않은(false) 것만 필터링
    .sorted(Comparator.comparing(VoteRegisterDTO::getVoteEndDate)) // 2. 종료 임박순 정렬
    .collect(Collectors.toList())); // 3. 리스트로 변환// 리스트로 변환 필수

	request.setAttribute("voteRegisterReady", 
		readyReg.stream().sorted(Comparator.comparing(VoteRegisterDTO::getVoteStartDate).reversed()) 
		.limit(2).collect(Collectors.toList()));

	request.setAttribute("voteRegisterClosed", closedReg.stream()
    .sorted(Comparator.comparing(VoteRegisterDTO::getVoteEndDate).reversed()) 
    .limit(2)
    .collect(Collectors.toList()));

		System.out.println("===============================================");


		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/vote.jsp");
		return forward;
	}

}
