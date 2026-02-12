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

public class VoteController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {


		VoteService voteService = new VoteServiceImpl();
		HttpSession session = request.getSession();


		String sessionMemId = (String) session.getAttribute("memId");

		// 2. 로그인 여부 확인 (null이 아니면 true)
		boolean isLogin = (sessionMemId != null);

		int memNo = -1; // 기본값 설정

		if (isLogin) {
			MemberService memberService = new MemberServiceImpl();
			MemberDTO memDto = memberService.idCheck(sessionMemId);
			memNo = memDto.getMemNo();
		}
		//DB에서  VOTE_REGISTER 레코드를 조회
		List<VoteRegisterDTO> voteRegFullList = voteService.getVoteRegFullList();

		//READY, ACTIVE, CLOSED STATUS SET (상태 분류 및 집계)
		List<VoteRegisterDTO> activeReg = new ArrayList<>();
		List<VoteRegisterDTO> readyReg = new ArrayList<>();
		List<VoteRegisterDTO> closedReg = new ArrayList<>();

		List<VoteRecordDTO> voteReclist = voteService.getVoteRecordList();


		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		for(VoteRegisterDTO v : voteRegFullList){
			Date start = sdf.parse(v.getVoteStartDate());
			Date end   = sdf.parse(v.getVoteEndDate());

			if(now.before(start)){
				v.setVoteStatus("READY");
				readyReg.add(v);
			}else if(now.after(end)){
				//closed 인 레지스터들은 setResultList
				v.setVoteStatus("CLOSED");
				v.setResultList(voteService.getVoteResult(v.getVoteId()));
				closedReg.add(v);
			}else{
				//ACTIVE 인 레지스터들은 사용자 로그인 상태 판단해서 로그인된 사용자이면 setVoted = false  
				v.setVoteStatus("ACTIVE");

				// 내가 투표했는지 확인
				boolean voted = false;

				for(VoteRecordDTO r : voteReclist){

					if(isLogin && r.getVoteId() == v.getVoteId() && r.getMemNo() == memNo){

						voted = true;
						break;
					}
				}

				v.setVoted(voted);

				if(isLogin && voted==false){//로그인된 상태이면 voted false 만 저장
					System.err.println(v.getVoteId());
					System.err.println(voted);	
					activeReg.add(v);
				}else if(!isLogin ){

					activeReg.add(v);
				}


			}
		}

		//setAttribute active, ready, closed (데이터 전달)
		request.setAttribute("voteRegisterActive", activeReg);
		request.setAttribute("voteRegisterReady", readyReg);
		request.setAttribute("voteRegisterClosed", closedReg);


		System.out.println("===============================================");


		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/vote.jsp");
		return forward;
	}

}
