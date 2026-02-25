package Controller.Vote;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import DTO.Vote.VoteRegisterDTO;
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
			String contextPath = request.getContextPath();
			out.println("<script>");
			out.println("alert('관리자로 다시 로그인 하세요!');");
			out.println("location='" + contextPath + "/memberLogin.do';");
			out.println("</script>");
			return null;
		}
    			
    	
    	ActionForward forward = new ActionForward();
    
    String state = request.getParameter("state");
    String voteIdstr = request.getParameter("voteId");
    if(state != null && "edit".equals(state) && voteIdstr != null) {
    	int voteId = Integer.parseInt(voteIdstr);
    	VoteService voteService = new VoteServiceImpl();
    	
    	VoteRegisterDTO voteReg = voteService.getVoteRegFullById(voteId);
    	voteService.updateVoteStatus(voteReg);
    	request.setAttribute("vote", voteReg);
    }
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/adminVoteForm.jsp");
		return forward;
    }
    
}
