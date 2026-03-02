package Controller.Vote;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import DTO.Vote.VoteOptionDTO;
import DTO.Vote.VoteRegisterDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminVoteFormOkController implements Action {

  @Override
  public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	  
	  
	response.setContentType("text/html;charset=UTF-8");
  	PrintWriter out=response.getWriter();
	
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

    VoteService voteService = new VoteServiceImpl();

    String state = request.getParameter("state");
    String voteId = request.getParameter("voteId");


    String voteTitle = request.getParameter("voteTitle");
    String voteContent = request.getParameter("voteContent");
    String voteStartDate = request.getParameter("voteStartDate");
    String voteEndDate = request.getParameter("voteEndDate");
    String[] movieIds = request.getParameterValues("movieId");
   
    
    try {
    	  List<VoteOptionDTO> voptList = new ArrayList<>();

    	    if (movieIds != null) {
    	      for (String movieId : movieIds) {
    	        VoteOptionDTO vopt = new VoteOptionDTO();
    	        vopt.setMovieId(Integer.parseInt(movieId));

    	        voptList.add(vopt);
    	      }
    	    }

    	    VoteRegisterDTO vdto = new VoteRegisterDTO();
    	    vdto.setVoteTitle(voteTitle);
    	    vdto.setVoteContent(voteContent);
    	    vdto.setVoteStartDate(voteStartDate);
    	    vdto.setVoteEndDate(voteEndDate);
    	    vdto.setOptionList(voptList);
    	    
    	  
    	  if(voteId != null && voteId.trim() != "") {
    		  
    		  vdto.setVoteId(Integer.parseInt(voteId));
    	  }
    	 
    	
    	    if ("add".equals(state) || (voteId == null || voteId.trim() == "")) {
    	      voteService.insertVoteRegister(vdto);
    	    
    	    } else if ("edit".equals(state) && voteId != null) {
    	      voteService.editVoteRegister(vdto);
    	     
    	    } else if ("delete".equals(state) && voteId != null) {	
    	    voteService.deleteVoteRegister(vdto);
    	     
    	    }

			JSONObject success = new JSONObject();
			success.put("status", "SUCCESS");
    	   out.print(success.toString());
			out.flush();
			return null;

    	   
	} catch (Exception e) {
		e.printStackTrace();
		JSONObject error = new JSONObject();
		error.put("status", "ERROR");
		out.print(error.toString());
		out.flush();
		return null;
		
	}

  }

}
