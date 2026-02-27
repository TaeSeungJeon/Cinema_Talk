package Controller.Admin;

import Controller.Action;
import Controller.ActionForward;
import Service.Admin.AdminMovieService;
import Service.Admin.AdminMovieServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminMovieDeleteController implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int movieId = Integer.parseInt(request.getParameter("movieId"));

	    AdminMovieService service = AdminMovieServiceImpl.getInstance();
	    service.deleteMovie(movieId);
	    System.out.println("삭제 movieId = " + movieId);
	    boolean isAjax = "XMLHttpRequest".equals(
	        request.getHeader("X-Requested-With")
	    );

	    if (isAjax) {
	        response.setContentType("text/plain");
	        response.getWriter().write("success");
	        return null;
	    }

	    ActionForward forward = new ActionForward();
	    forward.setRedirect(true);
	    forward.setPath(request.getContextPath() + "/adminMypage.do");

	    return forward;
	}

}
