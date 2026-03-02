package Controller.Admin;

import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Vote.VoteRegisterDTO;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//관리자 마이페이지 home 카테고리 이동 컨트롤러
public class AdminHomeController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		VoteService voteService = new VoteServiceImpl();
		List<VoteRegisterDTO> voteRegList = voteService.getTenRecentVotes();


		request.setAttribute("voteData", voteRegList);
		
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/admin/adminIndex.jsp");
		return forward;
	}

}
