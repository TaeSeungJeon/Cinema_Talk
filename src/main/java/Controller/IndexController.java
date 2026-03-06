package Controller;

import java.util.List;

import DTO.Board.BoardDTO;
import DTO.Movie.Recommend.MovieRecResponse;
import DTO.Vote.VoteRegisterDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import Service.HomeService;
import Service.HomeServiceImpl;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

public class IndexController implements Action {


	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		HomeService homeService = new HomeServiceImpl();
		VoteService voteService = new VoteServiceImpl();
		BoardService boardService = BoardServiceImpl.getInstance();

		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		session.setAttribute("requestSessionURL", request.getRequestURL().toString());

		// ===== 인트로 영역 =====
		if (session.getAttribute("intro") == null) {
			session.setAttribute("intro", "done");

			ActionForward introForward = new ActionForward();
			introForward.setRedirect(false);
			introForward.setPath("/WEB-INF/views/index.jsp");
			return introForward;
		}
		// ==================================

		Object memNoObj = session.getAttribute("memNo");

		int memNo = (memNoObj instanceof Integer) ? (Integer) memNoObj : -1;//로그인한 상태면 회원 번호 구함

		String todayKey = "visited_" + java.time.LocalDate.now();

	    if (session.getAttribute(todayKey) == null) {
	        homeService.increaseTodayDau();
	        session.setAttribute(todayKey, true);
	    }
      List<MovieRecResponse> indexTrendMovieList = homeService.getIndexTrendList();

	    List<MovieRecResponse> indexGenreMovieList;

	    if (memNo != -1) {
	        indexGenreMovieList = homeService.getIndexGenreList(memNo); // 개인 선호 장르
	    } else {
	        indexGenreMovieList = homeService.getIndexGenreList(); // 랜덤
	    }

	   
	  request.setAttribute("indexTrendMovieList", indexTrendMovieList);
	  request.setAttribute("homeGenreMovieList", indexGenreMovieList);
	    
    List<VoteRegisterDTO> activeVoteRegList = voteService.getActiveVoteRegList();
    request.setAttribute("activeVoteRegList", activeVoteRegList);

		// 최근 게시글 5개
		List<BoardDTO> recentBoardList = boardService.recentBoardList(5);
		request.setAttribute("recentBoardList", recentBoardList);

		// 일, 주, 월간 인기글
		List<BoardDTO> dailyPopularList   = boardService.getPopularBoardList("daily",   5);
		List<BoardDTO> weeklyPopularList  = boardService.getPopularBoardList("weekly",  5);
		List<BoardDTO> monthlyPopularList = boardService.getPopularBoardList("monthly", 5);

		request.setAttribute("dailyPopularList", dailyPopularList);
		request.setAttribute("weeklyPopularList", weeklyPopularList);
		request.setAttribute("monthlyPopularList", monthlyPopularList);

		// 최신 공지사항 1건
		BoardDTO latestNotice = boardService.latestNotice();
		request.setAttribute("latestNotice", latestNotice);


		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/home/index.jsp");
		return forward;
	}

}