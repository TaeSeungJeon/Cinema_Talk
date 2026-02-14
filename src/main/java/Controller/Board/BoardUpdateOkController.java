package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class BoardUpdateOkController implements Action {

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

        // 파라미터 받기
        int boardId = Integer.parseInt(request.getParameter("boardId"));
        String boardTitle = request.getParameter("boardTitle");
        String boardContent = request.getParameter("boardContent");

        BoardService boardService = new BoardServiceImpl();

        // 기존 글 조회
        BoardDTO originalBoard = boardService.getBoardCont(boardId);

        // 글 존재 여부 체크
        if (originalBoard == null) {
            forward.setPath("freeBoard.do");
            forward.setRedirect(true);
            return forward;
        }

        // 작성자 검증
        if (!originalBoard.getMemNo().equals(loginMemNo)) {
            forward.setPath("freeBoard.do");
            forward.setRedirect(true);
            return forward;
        }

        // 수정 DTO 세팅
        BoardDTO bdto = new BoardDTO();
        bdto.setBoardId(boardId);
        bdto.setBoardTitle(boardTitle);
        bdto.setBoardContent(boardContent);

        // 수정 실행
        boardService.updateBoard(bdto);

        // 상세페이지로 이동
        forward.setPath("boardContent.do?boardId=" + boardId);
        forward.setRedirect(true);

        return forward;
    }
}
