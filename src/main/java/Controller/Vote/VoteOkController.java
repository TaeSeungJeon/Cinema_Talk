package Controller.Vote;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

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
		//Integer id = (Integer)session.getAttribute("id");
		Integer id=17;
		if(id==null) {
			JSONObject error = new JSONObject();
		    error.put("status", "LOGIN_REQUIRED");
		    out.print(error.toString());
		    out.flush();
			    return null;
		}else {
			int mem_no = id; 	
			int vote_id = Integer.parseInt(request.getParameter("vote_id")); 	
			int movie_id = Integer.parseInt(request.getParameter("movie_id")); 
			String cmnt = request.getParameter("comment");

			//TODO: vote_id로 vote_register를 조회해서 반환받은다음에 현재와 종료날짜 비교하여 지났으면 return 하고, 현재와 시작날짜 비교하여 시작전이면 return함

			//vote_register 조회
			VoteRegisterDTO voteReg = voteService.getVoteRegById(vote_id);

			if(voteReg == null) {
				out.println("NO_VOTES");
				out.flush();
				return null;
			}
			
			
			SimpleDateFormat sdf =
				    new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				Date now = new Date();

				Date start = sdf.parse(voteReg.getVote_start_date());
				Date end   = sdf.parse(voteReg.getVote_end_date());
				
				if(now.before(start)){
					out.println("NOT_STARTED");
					out.flush();
				    return null;
				}

				// 종료됨
				if(now.after(end)){
					out.println("ENDED");
					out.flush();
				    return null;
				}

			VoteRecordDTO voteRecord = new VoteRecordDTO();
			voteRecord.setMem_no(mem_no);
			voteRecord.setMovie_id(movie_id);
			voteRecord.setVote_id(vote_id);
			voteRecord.setVote_comment_text(cmnt);

			try {
				//투표한적 있는지 판단
				VoteRecordDTO existingRecord = voteService.getVoteRecordByMemNo(voteRecord);
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
				
				JSONArray jsonArray = new JSONArray();

				for (VoteResultDTO dto : resultList) {
				    JSONObject jsonObj = new JSONObject();
				    jsonObj.put("movie_id", dto.getMovie_id());
				    jsonObj.put("count", dto.getCount());
				    jsonObj.put("percentage", dto.getPercentage());
				    jsonObj.put("rank", dto.getRank());
				    
				    jsonArray.put(jsonObj);
				}
				JSONObject success = new JSONObject();
				success.put("status", "SUCCESS");
				success.put("results", jsonArray); // 아까 만든 투표 결과 배열
				out.print(success.toString());

				// request에 담아서 jsp로 전달
//				request.setAttribute("vote_result", resultList);
//				ActionForward forward = new ActionForward();
//				forward.setRedirect(false);
//				forward.setPath("/WEB-INF/views/vote/vote.jsp");
//				out.print("SUCCESS");
//				System.out.println("suces");
				
			    out.flush();
			    out.close();
			} catch (Exception e) {
				e.printStackTrace(); // 로그는 반드시 남겨라

				out.print("ERROR");
				out.flush();
			}


		}

		return null;
	}

}
