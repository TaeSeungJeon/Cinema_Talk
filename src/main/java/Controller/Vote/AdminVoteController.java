package Controller.Vote;

import java.io.PrintWriter;
import java.util.List;

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

public class AdminVoteController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	

    	response.setContentType("text/html;charset=UTF-8");
    	PrintWriter out = response.getWriter();
    	HttpSession session = request.getSession();
    	
    	MemberService memberService = new MemberServiceImpl();
    	VoteService voteService = new VoteServiceImpl();
    	
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
		
		int page=1;
    	int limit=10;
    	
    	if(request.getParameter("page") != null) {
	         page=Integer.parseInt(request.getParameter("page"));//페이지번호를 정수숫자로 변경해서 저장         
	      }
    	String sortCol = request.getParameter("sortCol");
    	String sortDir = request.getParameter("sortDir");
    	String filter = request.getParameter("filter");
		
		VoteRegisterDTO findVoteReg = new VoteRegisterDTO();
		
		int totalCount= voteService.getRowCount(findVoteReg);
		
		
		findVoteReg.setSortCol(sortCol);
    	findVoteReg.setSortDir(sortDir);
    	findVoteReg.setFilter(filter);
		findVoteReg.setStartrow((page-1)*limit+1);//시작행번호
		findVoteReg.setEndrow(findVoteReg.getStartrow()+limit-1);//끝행 번호
    	
    	List<VoteRegisterDTO> voteRegFullList = voteService.getVoteRegList(findVoteReg);
    	
    	if(filter != null && !filter.equals("ALL")) {
    		totalCount = voteRegFullList.size();
    	}
    	
    	voteRegFullList.forEach(vote -> {
    		voteService.updateVoteStatus(vote);
    	});
    	
    	
    	
    	//총 페이지수
    	int maxpage=(int)((double)totalCount/limit+0.95);
    	//시작페이지(1,11,21 ..)
    	int startpage=(((int)((double)page/10+0.9))-1)*10+1;
    	//현재 페이지에 보여질 마지막 페이지(10,20 ..)
    	int endpage=maxpage;
    	if(endpage>startpage+10-1) endpage=startpage+10-1;
    	
    	
    	
    	
    	request.setAttribute("voteRegFullList", voteRegFullList);
    	request.setAttribute("page",page);//쪽번호 -> 내가 본 쪽번호로 바로 이동하기 위한 책갈피 기능 구현
	    request.setAttribute("startpage",startpage);//시작페이지
	    request.setAttribute("endpage",endpage);//마지막 페이지
	    request.setAttribute("maxpage",maxpage);
	    request.setAttribute("totalCount", totalCount);
	    request.setAttribute("filter", filter);
	    
    	
		
    ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/vote/adminVote.jsp");
		return forward;
    }
    
}
