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

        BoardDTO cont = service.getBoardDetail(boardId);

        CommentsService cService = CommentsServiceImpl.getInstance();
        List<CommentsDTO> clist = cService.commentsList(boardId);

        // 좋아요
        int likeCount = service.getBoardLikeCount(cont.getBoardId(), cont.getBoardType());

        request.setAttribute("likeCount", likeCount);

        request.setAttribute("cont", cont);
        request.setAttribute("clist", clist);

        ActionForward forward = new ActionForward();
        forward.setPath("/WEB-INF/views/board/postDetail.jsp");
        forward.setRedirect(false);
        return forward;


    }

}
