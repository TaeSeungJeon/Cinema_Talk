package Controller.Board;

import java.io.PrintWriter;
import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardSearchService;
import Service.Board.BoardSearchServiceImpl;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 게시글 검색 컨트롤러
 * - 검색어(searchWords) 또는 영화 ID(movieId) 기반 검색을 처리
 * - filter 파라미터로 게시판 타입(free / notice / quiry 등)을 구분
 */
public class BoardSearchController implements Action {

    private static final int PAGE_SIZE = 10;
    private static final int PAGE_BLOCK = 10;

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String filter = request.getParameter("filter");
        if (filter == null || filter.trim().isEmpty()) {
            filter = "all";
        }

        String searchWords = request.getParameter("search-words");
        if (searchWords != null) {
            searchWords = searchWords.trim();
        }

        int searchOption = Integer.parseInt(request.getParameter("search-option"));

        // [버그 수정] movieIdParam null 처리 후 반드시 movieIdParam 변수로 parseInt 해야 함
        // 기존 코드는 null 처리 후 다시 원본 request.getParameter("movieId")로 parseInt → NPE 발생
        String movieIdParam = request.getParameter("movieId");
        if (movieIdParam == null || movieIdParam.trim().isEmpty()) {
            movieIdParam = "0";
        }
        int movieId = Integer.parseInt(movieIdParam);

        // 검색어 유효성 검사
        if (searchWords == null && movieId == 0) {
            out.println("<script>");
            out.println("alert('검색어를 입력하세요.');");
            out.println("history.back();");
            out.println("</script>");
            return null;
        }

        if (searchWords != null && searchWords.length() < 2) {
            out.println("<script>");
            out.println("alert('검색어를 두 글자 이상 입력하세요.');");
            out.println("history.back();");
            out.println("</script>");
            return null;
        }

        // 페이징 계산
        int page = 1;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException ignored) {
                page = 1;
            }
        }

        int startRow = (page - 1) * PAGE_SIZE + 1;
        int endRow   = startRow + PAGE_SIZE - 1;

        BoardSearchService searchService = BoardSearchServiceImpl.getInstance();
        int totalCount;
        List<BoardDTO> list;
        String targetJsp = "freeBoard.jsp";

        if (movieId != 0) {
            // 영화 ID 기반 검색
            totalCount = searchService.getBoardCountByMovieId(movieId);
            list       = searchService.boardListPageByMovieId(movieId, startRow, endRow);
        } else {
            // 검색어 + 게시판 타입 기반 검색
            int type = 0;
            if ("free".equals(filter)) {
                type = 1;
            } else if ("hot".equals(filter)) {
                type = 2;
            } else if ("notice".equals(filter)) {
                type = 10;
                targetJsp = "noticeBoard.jsp";
            } else if ("quiry".equals(filter)) {
                type = 11;
                targetJsp = "quiryBoard.jsp";
            }
            totalCount = searchService.getBoardCountByTypeAndWord(type, searchWords, searchOption);
            list       = searchService.boardListPageByTypeAndWord(type, startRow, endRow, searchWords, searchOption);
        }

        // 페이지 블록 계산
        int maxPage   = (totalCount + PAGE_SIZE - 1) / PAGE_SIZE;
        int startPage = ((page - 1) / PAGE_BLOCK) * PAGE_BLOCK + 1;
        int endPage   = Math.min(startPage + PAGE_BLOCK - 1, maxPage);

        // 사이드바용 데이터
        BoardService boardService = BoardServiceImpl.getInstance();
        request.setAttribute("latestNotice",        boardService.latestNotice());
        request.setAttribute("dailyPopularList",    boardService.getPopularBoardList("daily",   10));
        request.setAttribute("weeklyPopularList",   boardService.getPopularBoardList("weekly",  10));
        request.setAttribute("monthlyPopularList",  boardService.getPopularBoardList("monthly", 10));

        VoteService voteService = new VoteServiceImpl();
        request.setAttribute("activeVoteRegList", voteService.getActiveVoteRegList());

        // 목록 / 페이징 데이터
        request.setAttribute("boardList",  list);
        request.setAttribute("filter",     filter);
        request.setAttribute("page",       page);
        request.setAttribute("maxPage",    maxPage);
        request.setAttribute("startPage",  startPage);
        request.setAttribute("endPage",    endPage);

        ActionForward forward = new ActionForward();
        forward.setPath("/WEB-INF/views/board/" + targetJsp);
        forward.setRedirect(false);
        return forward;
    }
}
