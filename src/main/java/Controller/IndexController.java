package Controller;

import java.util.List;

import DTO.Movie.Recommend.MovieRecResponse;
import Service.HomeService;
import Service.HomeServiceImpl;
import Service.Movie.Recommend.MovieRecService;
import Service.Movie.Recommend.MovieRecServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class IndexController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	
		HomeService homeService = new HomeServiceImpl();
		
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();

		Object memNoObj = session.getAttribute("mem_no");
	    int memNo = (memNoObj != null) ? (int)memNoObj : -1;//로그인한 상태면 회원 번호 구함
	    
	    List<MovieRecResponse> indexTrendMovieList = homeService.getIndexTrendList();
	    List<MovieRecResponse> indexGenreMovieList = homeService.getIndexGenreList(memNo);
	    
	    request.setAttribute("indexTrendMovieList", indexTrendMovieList);
	    request.setAttribute("homeGenreMovieList", indexGenreMovieList);
	    
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/home/index.jsp");
		return forward;
	}

}
