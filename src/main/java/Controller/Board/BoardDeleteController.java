package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class BoardDeleteController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        Integer loginMemNo = (Integer) session.getAttribute("memNo");

        ActionForward forward = new ActionForward();

        // 로그인 체크
        if (loginMemNo == null) {
            forward.setPath("memberLogin.do");
            forward.setRedirect(true);
            return forward;
        }

        int boardId = Integer.parseInt(request.getParameter("boardId"));

        BoardService boardService = new BoardServiceImpl();
        BoardDTO bdto = boardService.getBoardCont(boardId);

        // 글 존재 여부 체크
        if (bdto == null) {
            forward.setPath("freeBoard.do");
            forward.setRedirect(true);
            return forward;

        }

        // 작성자 검증
        if (!bdto.getMemNo().equals(loginMemNo)) {
            forward.setPath("freeBoard.do");
            forward.setRedirect(true);
            return forward;
        }

        // 삭제 실행
        boardService.deleteBoard(boardId);

        // 목록으로 이동
        forward.setPath("freeBoard.do");
        forward.setRedirect(true);

        return forward;
    }
}
