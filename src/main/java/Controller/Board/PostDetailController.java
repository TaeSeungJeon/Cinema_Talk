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

import DTO.Board.AddFileDTO;
import Service.Board.AddFileService;
import Service.Board.AddFileServiceImpl;

public class PostDetailController implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int boardId = Integer.parseInt(request.getParameter("boardId"));

        BoardService service = new BoardServiceImpl();

        BoardDTO cont = service.getBoardDetail(boardId);

        // 게시글이 존재하지 않으면 목록으로 리다이렉트
        if (cont == null) {
            ActionForward forward = new ActionForward();
            forward.setPath("freeBoard.do");
            forward.setRedirect(true);
            return forward;
        }

        /* 첨부파일 기능 */
        AddFileService fileService = AddFileServiceImpl.getInstance();
        List<AddFileDTO> fileList = fileService.listByBoard(cont.getBoardId(), cont.getBoardType());
        request.setAttribute("fileList", fileList);

        CommentsService cService = CommentsServiceImpl.getInstance();

        Integer memNo = (Integer) request.getSession().getAttribute("memNo");
        List<CommentsDTO> clist = cService.commentsListWithLike(boardId, memNo);

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
