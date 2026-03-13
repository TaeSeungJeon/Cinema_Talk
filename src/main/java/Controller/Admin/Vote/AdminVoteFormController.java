package Controller.Admin.Vote;

import java.io.PrintWriter;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import DTO.Vote.VoteOptionDTO;
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

public class AdminVoteFormController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    
    	response.setContentType("text/html;charset=UTF-8");
    	PrintWriter out = response.getWriter();
    	HttpSession session = request.getSession();
    	
    	MemberService memberService = new MemberServiceImpl();
    	
    	//로그인 사용자 정보 가져오기
		String memId = (String) session.getAttribute("memId"); 
		MemberDTO mem = (memId != null) ? memberService.idCheck(memId) : null;
		
		if(mem == null || mem.getMemRole() != 1) {
			JSONObject error = new JSONObject();
			error.put("status", "LOGIN_REQUIRED");
			out.print(error.toString());
			out.flush();
			return null;
		}
    			
    	
    	//ActionForward forward = new ActionForward();
    
	    String state = request.getParameter("state");
	    String voteIdstr = request.getParameter("voteId");
	    if(voteIdstr != null) {
	    	int voteId = Integer.parseInt(voteIdstr);
	    	VoteService voteService = new VoteServiceImpl();
	    	
	    	VoteRegisterDTO voteReg = voteService.getVoteRegFullById(voteId, true);
	    	voteService.updateVoteStatus(voteReg);
	    	
//	    	request.setAttribute("vote", voteReg); --ajax할때 쓸수 없어서 json을 던짐
	    	
	    	JSONObject jsonObj = new JSONObject();
			jsonObj.put("voteId", voteReg.getVoteId());
			jsonObj.put("voteTitle", voteReg.getVoteTitle());
			jsonObj.put("voteContent", voteReg.getVoteContent());
			jsonObj.put("voteStartDate", voteReg.getVoteStartDate());
			jsonObj.put("voteEndDate", voteReg.getVoteEndDate());
			jsonObj.put("voteStatus", voteReg.getVoteStatus());
			
			JSONArray jsonOptList = new JSONArray();

			if (voteReg.getOptionList() != null) {
			    for (VoteOptionDTO opt : voteReg.getOptionList()) {
			        JSONObject optObj = new JSONObject();
			        optObj.put("movieId", opt.getMovieId());
			        optObj.put("movieTitle", opt.getMovieTitle());
					optObj.put("movieDeleted", opt.getMovieDeleted());
			        
			        jsonOptList.put(optObj); 
			    }
			}

			jsonObj.put("optionList", jsonOptList);
			
			//해당 투표결과
			List<VoteResultDTO> voteResult = voteService.getVoteResult(voteId);
			
			
			if (voteResult != null && !voteResult.isEmpty()) {
			    // 리스트의 첫 번째 항목에서 전체 참여자 수를 가져와 주입
			    int totalCount = voteResult.get(0).getTotalVoterCount();
			    voteReg.setVoterCount(totalCount); 
			    voteReg.setResultList(voteResult);
			}
			
			List<VoteRecordDTO> voteRecordList =  voteService.getVoteRecordByVoteId(voteId);
			long commentCount = voteRecordList.stream()
				    .filter(record -> record.getVoteCommentText() != null && !record.getVoteCommentText().trim().isEmpty())
				    .count();
			jsonObj.put("commentCount", commentCount);
			jsonObj.put("voterCount", voteReg.getVoterCount());
			jsonObj.put("voteResult", voteReg.getResultList());
			
			out.print(jsonObj.toString());
			
	    }
			return null;
	 }
    
}
