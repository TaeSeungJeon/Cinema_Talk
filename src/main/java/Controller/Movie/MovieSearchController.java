package Controller.Movie;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
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
		String search_words = (String)session.getAttribute("");
		
		//검색어 리스트 박스 검사
		int search_option = Integer.parseInt(request.getParameter("search_option"));
		
		//검색어 유효성 검사		
		if(search_words == null) {
			out.println("<script>");
			out.println("alert('검색어를 입력하세요.');");
			out.println("history.back();");
			out.println("</script>");
		} else if(search_words.length() < 2) {
			out.println("<script>");
			out.println("alert('검색어를 두 단어 이상 입력하세요.');");
			out.println("history.back();");
			out.println("</script>");
		} else {
			
			MovieSearchService movieSearchService = new MovieSearchServiceImpl();
			switch (search_option) {
			case 0: //장르
				//DB에서 장르를 포함한 검색어로 조회
				break;
			case 1: //제목
				//DB에서 제목을 포함한 검색어로 조회
				break;
			case 2: //감독
				//DB에서 감독을 포함한 검색어로 조회
				break;
			case 3: //배우
				//DB에서 배우를 포함한 검색어로 조회
				break;
				
			default:
				break;
			}
			
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/admin/admin_index.jsp");
			return forward;
		}
		
		return null;
	}

}
