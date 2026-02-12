package Controller.Vote;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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
		
		
		response.setContentType("text/html;charset=UTF-8");
		VoteService voteService = new VoteServiceImpl();
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		 Integer mem_no = (Integer) session.getAttribute("id");
		 int voteId = Integer.parseInt(request.getParameter("vote_id")) ;
		 
		 if(mem_no == null) {
			 out.println("<script>");
				out.println("alert('관리자로 다시 로그인 하세요!');");
				out.println("location='login.do';");
				out.println("</script>");
				return null;
		 }
		 System.out.println("mem_no: " + mem_no);
		 System.out.println("vote_id: " + voteId);

		 VoteRecordDTO tempVrecDTO = new VoteRecordDTO();
		 tempVrecDTO.setMem_no(mem_no);
		 tempVrecDTO.setVote_id(voteId);

		 VoteRegisterDTO vregDto = voteService.getVoteRegFullById(voteId); //해당 투표의 정보 가져오기
		VoteRecordDTO vrecDto = voteService.getVoteRecordByMemNo(tempVrecDTO); //사용자의 선택한 영화를 조회하기
		 List<VoteResultDTO> vResultDtO = voteService.getVoteResult(voteId); //해당 투표의 집계
		 List<VoteRecordDTO> vrecListDto = voteService.getVoteRecordByVoteId(voteId); //해당 투표의 댓글 수집하기
		
		 vregDto.setUserChoice(vrecDto.getMovie_id());
		 vregDto.setResultList(vResultDtO);
		 
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();

		Date start = sdf.parse(vregDto.getVote_start_date());
				Date end   = sdf.parse(vregDto.getVote_end_date());

				if(now.before(start)){
					vregDto.setVote_status("READY");
					
				}else if(now.after(end)){
					vregDto.setVote_status("CLOSED");
					
					
				}else{
					vregDto.setVote_status("ACTIVE");}
		
		 
		 System.out.println(vregDto.getOptionList());
		request.setAttribute("voteInfo", vregDto);
		request.setAttribute("voteRecordList", vrecListDto);


		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/vote_detail.jsp");
		return forward;
	}

}
