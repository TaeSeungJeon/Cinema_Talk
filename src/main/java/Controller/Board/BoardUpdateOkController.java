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
        String movieId = request.getParameter("movieId");

        System.out.println("===== BoardUpdateOk 디버그 =====");
        System.out.println("boardId: " + boardId);
        System.out.println("boardTitle: " + boardTitle);
        System.out.println("boardContent 길이: " + (boardContent != null ? boardContent.length() : "null"));
        System.out.println("movieId: " + movieId);
        System.out.println("================================");

        BoardService boardService = BoardServiceImpl.getInstance();

        int movieIdInt = (movieId == null || movieId.trim().isEmpty()) ? -1 :Integer.parseInt(movieId);
        if (movieIdInt == 0) movieIdInt = -1;
        
        String movieTitle = boardService.getMovieTitleforBoard(movieIdInt);

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
        bdto.setMovieId(movieIdInt);
        bdto.setMovieTitle(movieTitle);

        // 수정 실행
        boardService.updateBoardContent(bdto);

        // 상세페이지로 이동
        forward.setPath("postDetail.do?boardId=" + boardId);
        forward.setRedirect(true);

        return forward;
    }
}
