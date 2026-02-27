package Controller;

import java.util.List;

import DTO.Movie.Recommend.MovieRecResponse;
import DTO.Vote.VoteRegisterDTO;
import Service.HomeService;
import Service.HomeServiceImpl;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class IndexController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	
		HomeService homeService = new HomeServiceImpl();
		VoteService voteService = new VoteServiceImpl();
		
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();

		Object memNoObj = session.getAttribute("memNo");
		int memNo = (memNoObj instanceof Integer) ? (Integer) memNoObj : -1;//로그인한 상태면 회원 번호 구함

		String todayKey = "visited_" + java.time.LocalDate.now();

	    if (session.getAttribute(todayKey) == null) {

	        homeService.increaseTodayDau();

	        session.setAttribute(todayKey, true);
	    }
	    
	    List<MovieRecResponse> indexTrendMovieList = homeService.getIndexTrendList();
	    List<MovieRecResponse> indexGenreMovieList = homeService.getIndexGenreList(memNo);
	    
	    request.setAttribute("indexTrendMovieList", indexTrendMovieList);
	    request.setAttribute("homeGenreMovieList", indexGenreMovieList);
	    
	    List<VoteRegisterDTO> activeVoteRegList = voteService.getActiveVoteRegList();
	    request.setAttribute("activeVoteRegList", activeVoteRegList);
	    
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/home/index.jsp");
		return forward;
	}

}
