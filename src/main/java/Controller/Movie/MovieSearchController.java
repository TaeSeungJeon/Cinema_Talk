package Controller.Movie;

import java.io.PrintWriter;
import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Movie.MovieDTO;
import Service.Movie.MovieSearchService;
import Service.Movie.MovieSearchServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class MovieSearchController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		//검색 창의 문자열을 가져와 저장
		String search_words = request.getParameter("search_words");
		
		//검색어 리스트 박스
		int search_option = Integer.parseInt(request.getParameter("search_option"));
		
		//검색어 유효성 검사		
		if(search_words == null) {
			out.println("<script>");
			out.println("alert('검색어를 입력하세요.');");
			out.println("history.back();");
			out.println("</script>");
		}
		//검색어 2글자 이상 검사
		else if(search_words.length() < 2) {
			out.println("<script>");
			out.println("alert('검색어를 두 글자 이상 입력하세요.');");
			out.println("history.back();");
			out.println("</script>");
		} else {
			int page = 1;
			int limit = 10;
			
			if(request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
			}
			
			MovieDTO movie = new MovieDTO();
			movie.setStartrow((page - 1) * limit + 1);
			movie.setEndrow(movie.getStartrow() + limit - 1);
			movie.setSearch_words(search_words);
			
			MovieSearchService movieSearchService = new MovieSearchServiceImpl();
			
			int totalCount= movieSearchService.getRowCount(movie, search_option);	//검색전 총레코드 개수,검색후 레코드 개수
			List<MovieDTO> movies = movieSearchService.getMovieDTOList(movie, search_option);
			
			// 페이징 계산
			int maxpage = (totalCount + limit - 1) / limit; // 최대 페이지 수
			int startpage = ((page - 1) / 10) * 10 + 1; 	// 시작 페이지
			int endpage = startpage + 9; 					// 끝 페이지
			if (endpage > maxpage) endpage = maxpage;
			
			if(movies != null) {
				request.setAttribute("movies", movies);			//movies 속성 키이름에 영화 목록을 저장
			    request.setAttribute("page", page);				//쪽번호 -> 내가 본 쪽번호로 바로 이동하기 위한 책갈피 기능 구현
			    request.setAttribute("startpage", startpage);	//시작페이지
			    request.setAttribute("endpage", endpage);		//마지막 페이지
			    request.setAttribute("maxpage", maxpage);		//최대 페이지
			    request.setAttribute("listcount", totalCount);	//검색전후 레코드 개수
			    request.setAttribute("find_field", search_option);//검색 필드
			    request.setAttribute("find_name", search_words);//검색어
			} else {
				out.println("<script>");
				out.println("alert('검색된 영화가 없습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/search/search_result.jsp");
			
			return forward;
		}
		
		return null;
	}

}