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

		PrintWriter out = response.getWriter();
        
        
        String filter = request.getParameter("filter");
        if (filter == null || filter.trim().isEmpty()) {
            filter = "all";
        }
		
		//검색 창의 문자열을 가져와 저장
		String searchWords = request.getParameter("search-words");
		
		//검색어 리스트 박스
		int searchOption = Integer.parseInt(request.getParameter("search-option"));
		
		//검색어 유효성 검사		
		if(searchWords == null) {
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

	        if ("free".equals(filter)) {
	            totalCount = service.getBoardCountByTypeAndWord(1, searchWords, searchOption);
	            list = service.boardListPageByTypeAndWord(1, startRow, endRow, searchWords, searchOption);
	        } else if ("hot".equals(filter)) {
	            totalCount = service.getBoardCountByTypeAndWord(2, searchWords, searchOption);
	            list = service.boardListPageByTypeAndWord(2, startRow, endRow, searchWords, searchOption);
	        } else {
	            totalCount = service.getBoardCountByTypeAndWord(0, searchWords, searchOption);
	            list = service.boardListPageByTypeAndWord(0, startRow, endRow, searchWords, searchOption);
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
	        forward.setPath("/WEB-INF/views/board/freeBoard.jsp");
	        forward.setRedirect(false);

	        return forward;
		}
        return null;
	}

}
