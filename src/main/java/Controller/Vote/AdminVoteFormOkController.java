package Controller.Vote;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

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
		String contextPath = request.getContextPath();
		out.println("<script>");
		out.println("alert('관리자로 다시 로그인 하세요!');");
		out.println("location='" + contextPath + "/memberLogin.do';");
		out.println("</script>");
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

    boolean isSuccess = false;
    String msg= " ";
    
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
    	      isSuccess = voteService.insertVoteRegister(vdto);
    	      msg = "투표가 성공적으로 추가되었습니다";
    	    } else if ("edit".equals(state) && voteId != null) {
    	     isSuccess = voteService.editVoteRegister(vdto);
    	     msg = "투표가 성공적으로 수정되었습니다";
    	    } else if ("delete".equals(state) && voteId != null) {	
    	     isSuccess = voteService.deleteVoteRegister(vdto);
    	     msg = "투표가 성공적으로 삭제되었습니다";
    	    }
    	   
    	   

    	   
	} catch (Exception e) {
		e.printStackTrace();
		
	}

 
    return null;
  
  }

}
