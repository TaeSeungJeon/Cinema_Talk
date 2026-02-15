package Controller.Vote;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

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

public class VoteOkController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		response.setContentType("text/html;charset=UTF-8");

		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();

		VoteService voteService = new VoteServiceImpl();

		String sessionMemId = (String) session.getAttribute("memId");

		// 2. 로그인 여부 확인 (null이 아니면 true)
		boolean isLogin = (sessionMemId != null);

		int memNo = -1; // 기본값 설정

		if (isLogin) {
			MemberService memberService = new MemberServiceImpl();
			MemberDTO memDto = memberService.idCheck(sessionMemId);
			memNo = memDto.getMemNo();
		}

		if (!isLogin) {
			JSONObject error = new JSONObject();
			error.put("status", "LOGIN_REQUIRED");
			out.print(error.toString());
			out.flush();
			return null;
		} else {

			int voteId = Integer.parseInt(request.getParameter("voteId"));
			int movieId = Integer.parseInt(request.getParameter("movieId"));
			String cmnt = request.getParameter("voteCommentText");

			// vote_id로 vote_register를 조회해서 반환받은다음에 현재와 종료날짜 비교하여 지났으면 return 하고, 현재와 시작날짜
			// 비교하여 시작전이면 return함

			// vote_register 조회
			VoteRegisterDTO voteReg = voteService.getVoteRegById(voteId);

			if (voteReg == null) {
				out.println("NO_VOTES");
				out.flush();
				return null;
			}

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			Date now = new Date();

			Date start = sdf.parse(voteReg.getVoteStartDate());
			Date end = sdf.parse(voteReg.getVoteEndDate());

			if (now.before(start)) {
				out.println("NOT_STARTED");
				out.flush();
				return null;
			}

			// 종료됨
			if (now.after(end)) {
				out.println("ENDED");
				out.flush();
				return null;
			}

			VoteRecordDTO voteRecord = new VoteRecordDTO();
			voteRecord.setMemNo(memNo);
			voteRecord.setMovieId(movieId);
			voteRecord.setVoteId(voteId);
			voteRecord.setVoteCommentText(cmnt);

			try {
				// 투표한적 있는지 판단
				VoteRecordDTO existingRecord = voteService.getVoteRecordByMemNo(voteRecord);

				if (existingRecord == null) {
					voteService.insertVoteRecord(voteRecord);
				} else {
					voteService.updateVoteRecord(voteRecord);
				}
				List<VoteResultDTO> resultList = voteService.getVoteResult(voteId);

				JSONArray resultJsonArray = new JSONArray();
				for (VoteResultDTO dto : resultList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("movieId", dto.getMovieId());
					jsonObj.put("count", dto.getCount());
					jsonObj.put("percentage", dto.getPercentage());
					jsonObj.put("rank", dto.getRank());
					resultJsonArray.put(jsonObj);
				}

				List<VoteRecordDTO> vrecord = voteService.getVoteRecordByVoteId(voteId);
				JSONArray recordJsonArray = new JSONArray();

				for (VoteRecordDTO record : vrecord) {
					JSONObject recObj = new JSONObject();
					recObj.put("memName", record.getMemName());
					recObj.put("commentText", record.getVoteCommentText());
					recObj.put("createdDate", record.getRecordCreatedDate());
					recObj.put("movieId", record.getMovieId()); // 어떤 영화에 단 댓글인지 구분용
					recordJsonArray.put(recObj);
				}

				JSONObject finalResponse = new JSONObject();
				finalResponse.put("status", "SUCCESS");
				finalResponse.put("results", resultJsonArray); // 투표 집계 결과
				finalResponse.put("comments", recordJsonArray);

				out.print(finalResponse.toString());
				out.flush();
				out.close();

				return null;

			} catch (Exception e) {
				e.printStackTrace();

				out.print("ERROR");
				out.flush();
			}

		}

		return null;
	}

}
