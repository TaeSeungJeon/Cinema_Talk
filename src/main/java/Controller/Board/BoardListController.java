package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.util.List;

public class BoardListController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        BoardService service = BoardServiceImpl.getInstance();
		HttpSession session = request.getSession();
		session.setAttribute("requestSessionURL", request.getRequestURL().toString());
		
        String filter = request.getParameter("filter");
        if (filter == null || filter.trim().isEmpty()) {
            filter = "all";
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

        if ("free".equals(filter)) {
            totalCount = service.getBoardCountByType(1);
            list = service.boardListPageByType(1, startRow, endRow);
        } else if ("hot".equals(filter)) {
            totalCount = service.getBoardCountByType(2);
            list = service.boardListPageByType(2, startRow, endRow);
        } else {
            totalCount = service.getBoardCount();
            list = service.boardListPage(startRow, endRow);
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

        // 최신 공지사항 1건
        BoardDTO latestNotice = service.latestNotice();
        request.setAttribute("latestNotice", latestNotice);

        // 일, 주, 월간 인기글 (사이드바용)
        List<BoardDTO> dailyPopularList   = service.getPopularBoardList("daily",   10);
        List<BoardDTO> weeklyPopularList  = service.getPopularBoardList("weekly",  10);
        List<BoardDTO> monthlyPopularList = service.getPopularBoardList("monthly", 10);
        
        request.setAttribute("dailyPopularList", dailyPopularList);
        request.setAttribute("weeklyPopularList", weeklyPopularList);
        request.setAttribute("monthlyPopularList", monthlyPopularList);

        ActionForward forward = new ActionForward();
        forward.setPath("/WEB-INF/views/board/freeBoard.jsp");
        forward.setRedirect(false);

        return forward;
    }
}
