package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

public class BoardListController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        BoardService service = new BoardServiceImpl();

        // 게시글 목록 가져오기
        String filter = request.getParameter("filter");
        if (filter == null) filter = "all";

        List<BoardDTO> list;

        switch (filter) {
            case "free":
                list = service.boardListByType(1); // 자유게시판
                break;
            case "hot":
                list = service.boardListByType(2); // 영화 추천/후기
                break;
            default:
                list = service.boardList(); // 전체
        }

        request.setAttribute("boardList", list);
        request.setAttribute("filter", filter);

        ActionForward forward = new ActionForward();
        forward.setPath("/WEB-INF/views/board/freeBoard.jsp");
        forward.setRedirect(false);

        return forward;
    }
}
