package Controller.Admin.Stats;

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
		request.setCharacterEncoding("UTF-8");
		boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

	    ActionForward forward = new ActionForward();
	    forward.setRedirect(false);
	    
	    String start = request.getParameter("startDate");
	    String end = request.getParameter("endDate");
	    String selectedDays = request.getParameter("selectedDays");

	    System.out.println("start: " + start);
	    System.out.println("end: " + end);
	    DateRangeDTO dataRange = new DateRangeDTO();
	    DateRangeDTO last7DaysRange = new DateRangeDTO();
	    last7DaysRange.setStartDate(LocalDate.now().minusDays(7));
	    last7DaysRange.setEndDate(LocalDate.now());
	    if (selectedDays == null) {
	        selectedDays = "7";
	    }
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
	    
	    request.setAttribute("startDate", dataRange.getStartDate());
	    request.setAttribute("endDate", dataRange.getEndDate());
	    request.setAttribute("selectedDays", selectedDays);
	    request.setAttribute("summaryStat", adminStatsService.getSummaryStat(dataRange));
	    request.setAttribute("memberStat", adminStatsService.getMemberStat(last7DaysRange));
	    request.setAttribute("boardStat", adminStatsService.getBoardStat(last7DaysRange));
	    request.setAttribute("voteStat", adminStatsService.getVoteStat(last7DaysRange));
	    request.setAttribute("inquiryStat", adminStatsService.getInquiryStat(last7DaysRange));
	    
	    if (isAjax) {
	    	forward.setPath("/WEB-INF/views/admin/stats/adminStats.jsp");
	    } else {
	        request.setAttribute("contentPage", "/WEB-INF/views/admin/stats/adminStats.jsp");
	        forward.setPath("/WEB-INF/views/admin/adminMyPage.jsp");
	    }

	    return forward;
	}
	
	private void setDefaultRange(DateRangeDTO range) {
	    range.setStartDate(LocalDate.now().minusDays(7));
	    range.setEndDate(LocalDate.now());
	}

}
