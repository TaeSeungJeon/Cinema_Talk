package Controller.Admin;

import Controller.Action;
import Controller.ActionForward;
import Service.Movie.MovieSearchService;
import Service.Movie.MovieSearchServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminStatesController implements Action {

	MovieSearchService movieSearchService = new MovieSearchServiceImpl();
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

	    ActionForward forward = new ActionForward();
	    forward.setRedirect(false);
	    
	    if (isAjax) {
	    	forward.setPath("/WEB-INF/views/admin/adminStates.jsp");
	    } else {
	        request.setAttribute("contentPage", "/WEB-INF/views/admin/adminStates.jsp");
	        forward.setPath("/WEB-INF/views/admin/adminMyPage.jsp");
	    }

	    return forward;
	}

}
