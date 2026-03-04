package Controller.Admin;

import java.time.LocalDate;
import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Admin.Stats.AdminSummaryDTO;
import DTO.Admin.Stats.DateRangeDTO;
import DTO.Board.BoardDTO;
import DTO.Vote.VoteRegisterDTO;
import Service.Admin.AdminNoticeService;
import Service.Admin.AdminNoticeServiceImpl;
import Service.Admin.AdminQuiryService;
import Service.Admin.AdminQuiryServiceImpl;
import Service.Admin.AdminStatsService;
import Service.Admin.AdminStatsServiceImpl;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//관리자 마이페이지 home 카테고리 이동 컨트롤러
public class AdminHomeController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		VoteService voteService = new VoteServiceImpl();
		BoardService boardService = BoardServiceImpl.getInstance();
		AdminQuiryService adminQuiryService = AdminQuiryServiceImpl.getInstance();
		AdminNoticeService adminNoticeService = AdminNoticeServiceImpl.getInstance();
		AdminStatsService adminStatsService = AdminStatsServiceImpl.getInstance();
		
		List<VoteRegisterDTO> voteRegList = voteService.getTenRecentVotes();
		List<BoardDTO> recentBoards = boardService.recentBoardList(10);
		List<BoardDTO> recentQuiries = adminQuiryService.getQuiryList("date", null, null, "Y", 1, 10);
		List<BoardDTO> recentNotices = adminNoticeService.getNoticeList(null, null, null, 1, 10);
		
		DateRangeDTO dataRange = new DateRangeDTO();
		
		LocalDate end = LocalDate.now();
		LocalDate start = end.minusDays(1);
		
		dataRange.setStartDate(start);
        dataRange.setEndDate(end);
	    
		AdminSummaryDTO recentSummary = adminStatsService.getSummaryStat(dataRange);
		
		request.setAttribute("voteData", voteRegList);
		request.setAttribute("recentBoards", recentBoards);
		request.setAttribute("recentQuiries", recentQuiries);
		request.setAttribute("recentNotices", recentNotices);
		request.setAttribute("recentSummary", recentSummary);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/admin/adminIndex.jsp");
		return forward;
	}

}
