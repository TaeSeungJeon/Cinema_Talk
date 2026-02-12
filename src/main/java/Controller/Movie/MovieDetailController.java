package Controller.Movie;

import Controller.Action;
import Controller.ActionForward;
import DTO.Movie.MovieDetailDTO;
import Service.Movie.MovieDetailService;
import Service.Movie.MovieDetailServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MovieDetailController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		// 1. 파라미터에서 영화 ID 가져오기
		String idParam = request.getParameter("id");
		if (idParam == null || idParam.isEmpty()) {
			// 영화 ID가 없으면 에러 페이지로 이동
			ActionForward forward = new ActionForward();
			forward.setPath("/WEB-INF/views/error/error.jsp");
			forward.setRedirect(false);
			return forward;
		}
		
		int movieId = Integer.parseInt(idParam);
		
		// 2. 영화 상세 정보 조회
		MovieDetailService movieDetailService = new MovieDetailServiceImpl();
		MovieDetailDTO movieDetail = movieDetailService.getMovieDetail(movieId);
		
		// 3. 영화가 없으면 에러 페이지로 이동
		if (movieDetail == null) {
			ActionForward forward = new ActionForward();
			forward.setPath("/WEB-INF/views/error/not_found.jsp");
			forward.setRedirect(false);
			return forward;
		}
		
		// 4. request에 데이터 저장
		request.setAttribute("movieDetail", movieDetail);
		request.setAttribute("movie", movieDetail.getMovie());
		request.setAttribute("genres", movieDetail.getGenres());
		request.setAttribute("casts", movieDetail.getCasts());
		request.setAttribute("directors", movieDetail.getDirectors());
		
		// 5. 영화 상세 페이지로 포워딩
		ActionForward forward = new ActionForward();
		forward.setPath("/WEB-INF/views/movie/movieDetail.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
}