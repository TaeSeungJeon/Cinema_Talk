package Controller.Movie.Recommend;

import java.util.List;
import java.util.Map;

import Controller.Action;
import Controller.ActionForward;
import DTO.Movie.Recommend.MovieRecResponse;
import Service.Movie.Recommend.MovieRecService;
import Service.Movie.Recommend.MovieRecServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class MovieRecController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
	    MovieRecService movieRecService = new MovieRecServiceImpl();
	    
	    HttpSession session = request.getSession();
	    Object memNoObj = session.getAttribute("memNo");
	    int memNo = (memNoObj != null) ? (int)memNoObj : -1;//로그인한 상태면 회원 번호 구함
	    
	    Map<Integer, List<MovieRecResponse>> genreRecMap = movieRecService.getGenreRecList(memNo);
	    List<MovieRecResponse> popularRecList = movieRecService.getPopularRecList();
	    List<MovieRecResponse> likeRecList = null;
	    
	    if (memNo != -1) {
		    likeRecList = movieRecService.getLikeRecList(memNo);
	    }
	    
	    request.setAttribute("genreRecMap", genreRecMap);
	    request.setAttribute("likeRecList", likeRecList);
	    request.setAttribute("popularRecList", popularRecList);
	    
	    ActionForward forward = new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("/WEB-INF/views/movie/recommend/MovieRecList.jsp");//뷰페이지 경로 설정
	    
	    return forward;            
	}
}