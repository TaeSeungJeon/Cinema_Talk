package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import Service.Board.CommentsService;
import Service.Board.CommentsServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

public class PostDetailController implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int boardId = Integer.parseInt(request.getParameter("boardId"));
        BoardService service = new BoardServiceImpl();

        service.plusReadCount(boardId); // 조회수 증가
        BoardDTO cont = service.getBoardDetail(boardId); // 본문 가져오기

        // 댓글 목록 가져오기 (화면에 보여주기 위해 꼭 필요)
        CommentsService cService = CommentsServiceImpl.getInstance();
        List<CommentsDTO> clist = cService.commentsList(boardId);

        request.setAttribute("cont", cont);
        request.setAttribute("clist", clist); // JSP에서 <c:forEach>로 돌릴 대상

        ActionForward forward = new ActionForward();
        forward.setPath("/WEB-INF/views/board/postDetail.jsp");
        forward.setRedirect(false);
        return forward;
    }
}