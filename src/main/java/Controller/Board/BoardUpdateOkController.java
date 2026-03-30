package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * 게시글 수정 처리 컨트롤러
 * - 로그인 체크 → 게시글 존재 여부 확인 → 작성자 본인 검증 → 수정 실행
 */
public class BoardUpdateOkController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session    = request.getSession();
        Integer loginMemNo     = (Integer) session.getAttribute("memNo");
        ActionForward forward  = new ActionForward();

        // 로그인 체크
        if (loginMemNo == null) {
            forward.setPath("memberLogin.do");
            forward.setRedirect(true);
            return forward;
        }

        int    boardId      = Integer.parseInt(request.getParameter("boardId"));
        String boardTitle   = request.getParameter("boardTitle");
        String boardContent = request.getParameter("boardContent");
        String movieIdParam = request.getParameter("movieId");

        BoardService boardService = BoardServiceImpl.getInstance();

        // movieId 미입력 시 -1 처리 (영화 미연동 상태)
        int movieIdInt = (movieIdParam == null || movieIdParam.trim().isEmpty())
                         ? -1 : Integer.parseInt(movieIdParam);
        if (movieIdInt == 0) movieIdInt = -1;

        String movieTitle = boardService.getMovieTitleforBoard(movieIdInt);

        // 기존 글 조회 및 권한 검증
        BoardDTO originalBoard = boardService.getBoardCont(boardId);
        if (originalBoard == null || !originalBoard.getMemNo().equals(loginMemNo)) {
            forward.setPath("freeBoard.do");
            forward.setRedirect(true);
            return forward;
        }

        // 수정 실행
        BoardDTO bdto = new BoardDTO();
        bdto.setBoardId(boardId);
        bdto.setBoardTitle(boardTitle);
        bdto.setBoardContent(boardContent);
        bdto.setMovieId(movieIdInt);
        bdto.setMovieTitle(movieTitle);
        boardService.updateBoardContent(bdto);

        // 수정 후 상세 페이지로 이동
        forward.setPath("postDetail.do?boardId=" + boardId);
        forward.setRedirect(true);
        return forward;
    }
}
