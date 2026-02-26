package Controller.Admin;

import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Movie.MovieDTO;
import Service.Movie.MovieSearchService;
import Service.Movie.MovieSearchServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminMovieSearchController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String keyword = request.getParameter("keyword");

        MovieSearchService movieSearchService = new MovieSearchServiceImpl();

        // 관리자 전용 간단 검색
        List<MovieDTO> movieList =
                movieSearchService.searchAdminMovies(keyword);

        request.setAttribute("movieList", movieList);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);

        // 왼쪽 목록 조각 JSP
        forward.setPath("/WEB-INF/views/admin/adminMovieSearch.jsp");

        return forward;
	}

}
