package Controller.Board.Quiry;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import DTO.Board.LinkPreviewDTO;
import DTO.Board.AddFileDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import Service.Board.CommentsService;
import Service.Board.CommentsServiceImpl;
import Service.Board.AddFileService;
import Service.Board.AddFileServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;
import java.util.Map;

public class QuiryDetailController implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int boardId = Integer.parseInt(request.getParameter("boardId"));

		BoardService service = BoardServiceImpl.getInstance();

		Map<String, Object> result = service.getBoardDetailWithPreview(boardId);

		BoardDTO cont = (BoardDTO) result.get("board");
		LinkPreviewDTO preview = (LinkPreviewDTO) result.get("preview");

		// 게시글이 존재하지 않으면 목록으로 리다이렉트
		if (cont == null) {
			ActionForward forward = new ActionForward();
			forward.setPath("quiry.do");
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
		request.setAttribute("preview", preview);

		String rawContent = cont.getBoardContent();
		String textOnly = rawContent.replaceAll("<[^>]*>", "");
		request.setAttribute("textOnlyContent", textOnly);
		request.setAttribute("clist", clist);

		ActionForward forward = new ActionForward();
		forward.setPath("/WEB-INF/views/board/quiryDetail.jsp");
		forward.setRedirect(false);
		return forward;
	}
}
