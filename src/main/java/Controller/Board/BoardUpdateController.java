package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class BoardUpdateController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        Integer loginMemNo = (Integer) session.getAttribute("memNo");

        ActionForward forward = new ActionForward();

        if (loginMemNo == null) {
            forward.setPath("memberLogin.do");
            forward.setRedirect(true);
            return forward;
        }

        int boardId = Integer.parseInt(request.getParameter("boardId"));
        String boardTitle = request.getParameter("boardTitle");
        String boardContent = request.getParameter("boardContent");

        BoardDTO bdto = new BoardDTO();
        bdto.setBoardId(boardId);
        bdto.setBoardTitle(boardTitle);
        bdto.setBoardContent(boardContent);

        BoardService boardService = new BoardServiceImpl();
        boardService.updateBoard(bdto);

        // 수정 완료 후 상세페이지로 이동 (.do 로 끝나게)
        forward.setPath("boardContent.do?boardId=" + boardId);
        forward.setRedirect(true);

        return forward;
    }
}
