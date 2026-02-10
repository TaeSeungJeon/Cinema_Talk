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

public class VoteOkController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


		response.setContentType("text/html;charset=UTF-8");

		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();

		VoteService voteService = new VoteServiceImpl();
		//TODO  memberservice loginCheck
		Integer id = (Integer)session.getAttribute("id");

		if(false) {
			out.println("<script>");
			out.println("alert('로그인을 필요한 기능입니다!')");
			out.println("location= 'member_login.do';");
			out.println("</script>");
		}else {
			int mem_no = Integer.parseInt(request.getParameter("mem_no")); 	
			int vote_id = Integer.parseInt(request.getParameter("vote_id")); 	
			int movie_id = Integer.parseInt(request.getParameter("movie_id")); 
			String cmnt = request.getParameter("comment");

			//TODO: vote_id로 vote_register를 조회해서 반환받은다음에 현재와 종료날짜 비교하여 지났으면 return 하고, 현재와 시작날짜 비교하여 시작전이면 return함

			//vote_register 조회
			VoteRegisterDTO voteReg = voteService.getVoteRegById(vote_id);

			if(voteReg == null) {
				out.println("<script>");
				out.println("alert('존재하지 않는 투표입니다.');");
				out.println("history.back();");
				out.println("</script>");
				return null;
			}
			
			
			SimpleDateFormat sdf =
				    new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				Date now = new Date();

				Date start = sdf.parse(voteReg.getVote_start_date());
				Date end   = sdf.parse(voteReg.getVote_end_date());
				
				if(now.before(start)){
				    out.println("<script>");
				    out.println("alert('아직 시작되지 않은 투표입니다.');");
				    out.println("history.back();");
				    out.println("</script>");
				    return null;
				}

				// 종료됨
				if(now.after(end)){
				    out.println("<script>");
				    out.println("alert('이미 종료된 투표입니다.');");
				    out.println("history.back();");
				    out.println("</script>");
				    return null;
				}

			VoteRecordDTO voteRecord = new VoteRecordDTO();
			voteRecord.setMem_no(mem_no);
			voteRecord.setMovie_id(movie_id);
			voteRecord.setVote_id(vote_id);
			voteRecord.setVote_comment_text(cmnt);

			try {
				//투표한적 있는지 판단
				VoteRecordDTO existingRecord = voteService.getVoteRecordByMemNo(mem_no);
				//기록이 없으면 새로 insert
				if(existingRecord == null) {
					//사용자의 투표를 기록한다
					voteService.insertVoteRecord(voteRecord);
				}else {
					//사용자의 투표를 수정한다
					voteService.updateVoteRecord(voteRecord);
				}
				
				
				
		

				// 영화별 투표 결과 가져오기
				List<VoteResultDTO> resultList = voteService.getVoteResult(vote_id);

				// request에 담아서 jsp로 전달
				request.setAttribute("vote_result", resultList);
				ActionForward forward = new ActionForward();
				forward.setRedirect(false);
				forward.setPath("/WEB-INF/views/vote/vote.jsp");
				return forward;
			} catch (Exception e) {
				e.printStackTrace(); // 로그는 반드시 남겨라

				out.println("<script>");
				out.println("alert('투표 처리 중 오류가 발생했습니다. 다시 시도해주세요.');");

				out.println("</script>");
			}


		}

		return null;
	}

}
