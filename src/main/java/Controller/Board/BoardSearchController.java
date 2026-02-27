package Controller.Board;

import java.io.PrintWriter;
import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardSearchService;
import Service.Board.BoardSearchServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BoardSearchController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
        
        String filter = request.getParameter("filter");
        if (filter == null || filter.trim().isEmpty()) {
            filter = "all";
        }
		
		//검색 창의 문자열을 가져와 저장
		String searchWords = request.getParameter("search-words");
		searchWords = searchWords.trim();  // 양쪽 공백 제거
		
		//검색어 리스트 박스
		int searchOption = Integer.parseInt(request.getParameter("search-option"));
		
		//영화 id 기반 검색
		String movieIdParam = request.getParameter("movieId");
		if(movieIdParam == null || movieIdParam.trim().isEmpty()) {
			movieIdParam = "0";
		}
		int movieId = Integer.parseInt(request.getParameter("movieId"));
		
		//검색어 유효성 검사		
		if(searchWords == null && movieId == 0) {
			out.println("<script>");
			out.println("alert('검색어를 입력하세요.');");
			out.println("history.back();");
			out.println("</script>");
		}
		//검색어 2글자 이상 검사
		else if(searchWords.length() < 2) {
			out.println("<script>");
			out.println("alert('검색어를 두 글자 이상 입력하세요.');");
			out.println("history.back();");
			out.println("</script>");
		} else {
			int page = 1;
	        int limit = 10;
	        
	        BoardSearchService service = BoardSearchServiceImpl.getInstance();
	        if (request.getParameter("page") != null) {
	            try {
	                page = Integer.parseInt(request.getParameter("page"));
	            } catch (NumberFormatException ignored) {
	                page = 1;
	            }
	        }

	        int startRow = (page - 1) * limit + 1;
	        int endRow = startRow + limit - 1;

	        int totalCount;
	        List<BoardDTO> list;
	        
	        int type = 0; // 전체 검색
	        
	        String requestedURL = "freeBoard.jsp";
	        if(movieId != 0) {
	        	totalCount = service.getBoardCountByMovieId(movieId);
	        	list = service.boardListPageByMovieId(movieId, startRow, endRow);
	        } else {
	        	if ("free".equals(filter)) {
	        		type = 1;
		        } else if ("hot".equals(filter)) {
		        	type = 2;
		        } else if ("notice".equals(filter)) {
		        	type = 10;
		        	requestedURL = "noticeBoard.jsp";
		        }
	        	totalCount = service.getBoardCountByTypeAndWord(type, searchWords, searchOption);
	            list = service.boardListPageByTypeAndWord(type, startRow, endRow, searchWords, searchOption);
	        }
	        
	        int maxPage = (totalCount + limit - 1) / limit;

	        // 10페이지 블록
	        int startPage = ((page - 1) / 10) * 10 + 1;
	        int endPage = startPage + 9;
	        if (endPage > maxPage) endPage = maxPage;

	        request.setAttribute("page", page);
	        request.setAttribute("maxPage", maxPage);
	        request.setAttribute("startPage", startPage);
	        request.setAttribute("endPage", endPage);
	        request.setAttribute("boardList", list);
	        request.setAttribute("filter", filter);

	        ActionForward forward = new ActionForward();
	        forward.setPath("/WEB-INF/views/board/" + requestedURL);
	        forward.setRedirect(false);

	        return forward;
		}
        return null;
	}

}
