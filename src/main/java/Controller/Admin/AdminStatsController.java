package Controller.Admin;

import java.time.LocalDate;

import Controller.Action;
import Controller.ActionForward;
import DTO.Admin.Stats.DateRangeDTO;
import Service.Admin.AdminStatsService;
import Service.Admin.AdminStatsServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminStatsController implements Action {
	
	AdminStatsService adminStatsService = AdminStatsServiceImpl.getInstance();

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

	    ActionForward forward = new ActionForward();
	    forward.setRedirect(false);
	    
	    String start = request.getParameter("startDate");
	    String end = request.getParameter("endDate");

	    DateRangeDTO dataRange = new DateRangeDTO();

	    try {
	        if (start != null && !start.isBlank() &&
	            end != null && !end.isBlank()) {

	            dataRange.setStartDate(LocalDate.parse(start));
	            dataRange.setEndDate(LocalDate.parse(end));

	            if (dataRange.getStartDate().isAfter(dataRange.getEndDate())) {
	                setDefaultRange(dataRange);
	            }

	        } else {
	            setDefaultRange(dataRange);
	        }

	    } catch (Exception e) {
	        setDefaultRange(dataRange);
	    }
	    
	    request.setAttribute("summaryStat", adminStatsService.getSummaryStat(dataRange));
	    request.setAttribute("memberStat", adminStatsService.getMemberStat(dataRange));
	    request.setAttribute("boardStat", adminStatsService.getBoardStat(dataRange));
	    request.setAttribute("voteStat", adminStatsService.getVoteStat(dataRange));
	    request.setAttribute("inquiryStat", adminStatsService.getInquiryStat(dataRange));
	    
	    if (isAjax) {
	    	forward.setPath("/WEB-INF/views/admin/adminStats.jsp");
	    } else {
	        request.setAttribute("contentPage", "/WEB-INF/views/admin/adminStats.jsp");
	        forward.setPath("/WEB-INF/views/admin/adminMyPage.jsp");
	    }

	    return forward;
	}
	
	private void setDefaultRange(DateRangeDTO range) {
	    range.setStartDate(LocalDate.now().minusDays(30));
	    range.setEndDate(LocalDate.now());
	}

}
