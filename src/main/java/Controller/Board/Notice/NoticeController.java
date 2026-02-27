package Controller.Board.Notice;

import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class NoticeController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardService service = BoardServiceImpl.getInstance();
			
		String filter = request.getParameter("filter");
        if (filter == null || filter.trim().isEmpty()) {
            filter = "notice";
        }
        
        int page = 1;
        int limit = 10;
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
        
        int type = 10; // 공지사항 타입
        totalCount = service.getBoardCountByType(type);
        list = service.boardListPageByType(type, startRow, endRow);

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
        forward.setPath("/WEB-INF/views/board/noticeBoard.jsp");
        forward.setRedirect(false);

        return forward;
	}

}
