package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.PrintWriter;

/**
 * 게시글 등록 처리 컨트롤러
 * - 세션 인증 → 파라미터 유효성 검사 → 파일 업로드 → DB 저장 순으로 처리
 * - 등록 후 boardType에 따라 해당 게시판으로 리다이렉트
 */
public class BoardOkController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String contextPath = request.getContextPath();

        // 세션 인증 확인
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("memNo") == null) {
            out.println("<script>");
            out.println("alert('글을 작성하려면 로그인을 해주세요.');");
            out.println("location='" + contextPath + "/memberLogin.do';");
            out.println("</script>");
            return null;
        }

        // 파라미터 수집
        String boardTitle   = request.getParameter("boardTitle");
        String boardContent = request.getParameter("boardContent");
        String linkUrl      = request.getParameter("linkUrl");
        String movieIdParam = request.getParameter("movieId");
        String typeStr      = request.getParameter("boardType");

        // 제목 / 내용 유효성 검사
        if (boardTitle == null || boardTitle.trim().isEmpty() ||
                boardContent == null || boardContent.trim().isEmpty()) {
            out.println("<script>");
            out.println("alert('제목과 게시글을 입력하세요.');");
            out.println("history.back();");
            out.println("</script>");
            return null;
        }

        // 게시판 타입 유효성 검사
        if (typeStr == null) {
            out.println("<script>");
            out.println("alert('게시판을 선택하세요.');");
            out.println("history.back();");
            out.println("</script>");
            return null;
        }

        Integer memNo  = (Integer) session.getAttribute("memNo");
        String  memId  = (String)  session.getAttribute("memId");
        int boardType  = Integer.parseInt(typeStr);
        int movieIdInt = (movieIdParam == null || movieIdParam.trim().isEmpty())
                         ? -1 : Integer.parseInt(movieIdParam);

        BoardService boardService = BoardServiceImpl.getInstance();
        String movieTitle = boardService.getMovieTitleforBoard(movieIdInt);

        BoardDTO bdto = new BoardDTO();
        bdto.setBoardTitle(boardTitle);
        bdto.setBoardContent(boardContent);
        bdto.setBoardType(boardType);
        bdto.setMemNo(memNo);
        bdto.setBoardName(memId);
        bdto.setMovieId(movieIdInt);
        bdto.setMovieTitle(movieTitle);
        if (linkUrl != null && !linkUrl.trim().isEmpty()) {
            bdto.setLinkUrl(linkUrl.trim());
        }

        try {
            boardService.boardIn(bdto);

            // 등록 후 이동 경로 결정
            String redirectUrl;
            if (boardType == 10) {
                redirectUrl = contextPath + "/notice.do";
            } else if (boardType == 11) {
                redirectUrl = contextPath + "/quiry.do";
            } else {
                String filter = (boardType == 1) ? "free" : "hot";
                redirectUrl = contextPath + "/freeBoard.do?filter=" + filter;
            }

            out.println("<script>");
            out.println("alert('게시글이 등록되었습니다.');");
            out.println("location.href='" + redirectUrl + "';");
            out.println("</script>");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>");
            out.println("alert('등록 중 오류가 발생했습니다.');");
            out.println("history.back();");
            out.println("</script>");
        } finally {
            out.flush();
            out.close();
        }

        return null;
    }
}
