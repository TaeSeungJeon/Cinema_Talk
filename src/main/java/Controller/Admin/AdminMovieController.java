package Controller.Admin;

import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Movie.MovieDTO;
import Service.Movie.MovieSearchService;
import Service.Movie.MovieSearchServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminMovieController implements Action {

	MovieSearchService movieSearchService = new MovieSearchServiceImpl();
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

	    ActionForward forward = new ActionForward();
	    forward.setRedirect(false);

	    List<MovieDTO> movieList = movieSearchService.searchAdminMovies("");
	    request.setAttribute("movieList", movieList);
	    
	    if (isAjax) {
	    	forward.setPath("/WEB-INF/views/admin/adminMovie.jsp");
	    } else {
	        request.setAttribute("contentPage", "/WEB-INF/views/admin/adminMovie.jsp");
	        forward.setPath("/WEB-INF/views/admin/adminMyPage.jsp");
	    }

	    return forward;
	}

}
