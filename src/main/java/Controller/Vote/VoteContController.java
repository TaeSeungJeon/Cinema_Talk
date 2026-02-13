package Controller.Vote;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		int voteId = Integer.parseInt(request.getParameter("voteId")) ;

		String sessionMemId = (String) session.getAttribute("memId");

		// 2. 로그인 여부 확인 (null이 아니면 true)
		boolean isLogin = (sessionMemId != null);

		int memNo = -1; // 기본값 설정

		if (isLogin) {
			MemberService memberService = new MemberServiceImpl();
			MemberDTO memDto = memberService.idCheck(sessionMemId);
			memNo = memDto.getMemNo();
		}else {
			out.println("<script>");
			out.println("alert('다시 로그인 하세요!');");
			out.println("location='memberLogin.do';");
			out.println("</script>");
			return null;
		}



		VoteRecordDTO tempVrecDTO = new VoteRecordDTO();
		tempVrecDTO.setMemNo(memNo);
		tempVrecDTO.setVoteId(voteId);

		//투표한적 있는지 판단
		VoteRecordDTO existingRecord = voteService.getVoteRecordByMemNo(tempVrecDTO);
		
		VoteRegisterDTO vregDto = voteService.getVoteRegFullById(voteId); //해당 투표의 정보 가져오기

		//투표 상태 셋팅
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();

		Date start = sdf.parse(vregDto.getVoteStartDate());
		Date end   = sdf.parse(vregDto.getVoteEndDate());

		if(now.before(start)){
			vregDto.setVoteStatus("READY");
		}else if(now.after(end)){
			vregDto.setVoteStatus("CLOSED");
		}else{
			vregDto.setVoteStatus("ACTIVE");
		}

		List<VoteResultDTO> vResultDtO = new ArrayList<>(); //해당 투표의 집계
		List<VoteRecordDTO> vrecListDto = new ArrayList<>(); //해당 투표의 댓글 수집하기	


		if(!vregDto.getVoteStatus().equals("READY")) {

			if(existingRecord != null) {
				VoteRecordDTO vrecDto = voteService.getVoteRecordByMemNo(tempVrecDTO); //사용자의 선택한 영화를 조회하기
				vregDto.setUserChoice(vrecDto.getMovieId());
			}
			vResultDtO = voteService.getVoteResult(voteId); //해당 투표의 집계
			vrecListDto = voteService.getVoteRecordByVoteId(voteId); //해당 투표의 댓글 수집하기

			request.setAttribute("voteRecordList", vrecListDto); //댓글 모음
		}

		vregDto.setResultList(vResultDtO);

		request.setAttribute("voteInfo", vregDto);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/voteDetail.jsp");
		return forward;
	}

}
