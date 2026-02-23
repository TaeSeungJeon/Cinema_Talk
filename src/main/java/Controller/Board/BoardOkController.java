package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Service.Board.BoardServiceDAO;
import Service.Board.BoardServiceImplDAO;

import java.io.PrintWriter;

public class BoardOkController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String contextPath = request.getContextPath();

        // 세션 확인
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("memNo") == null) {
            out.println("<script>");
            out.println("alert('글을 작성하려면 로그인을 해주세요.');");
            out.println("location='" + request.getContextPath() + "/memberLogin.do';");
            out.println("</script>");
            return null;
        }

        // 게시글 정보
        String boardTitle = request.getParameter("boardTitle");
        String boardCont = request.getParameter("boardContent");

        if (boardTitle == null || boardTitle.trim().isEmpty() ||
                boardCont == null || boardCont.trim().isEmpty()) {
            out.println("<script>");
            out.println("alert('제목과 게시글을 입력하세요.');");
            out.println("history.back();");
            out.println("</script>");
            return null;
        }

        // 세션에서 값 가져오기
        Integer memNo = (Integer) session.getAttribute("memNo");
        String memId = (String) session.getAttribute("memId");

        BoardDTO bdto = new BoardDTO();
        bdto.setBoardTitle(boardTitle);
        bdto.setBoardContent(boardCont);
        bdto.setMemNo(memNo);

        String typeStr = request.getParameter("boardType");

        if(typeStr == null){
            out.println("<script>");
            out.println("alert('게시판 선택하세요');");
            out.println("history.back();");
            out.println("</script>");
            return null;
        }

        int boardType = Integer.parseInt(typeStr);
        bdto.setBoardType(boardType);


        bdto.setBoardName(memId); // 세션에서 바로 사용

        try {
            BoardServiceDAO boardService = new BoardServiceImplDAO();
            boardService.boardIn(bdto);

            out.println("<script>");
            out.println("alert('게시글이 등록되었습니다.');");
            String filter = (boardType == 1) ? "free" : "hot";
            out.println("location.href='" + contextPath + "/freeBoard.do?filter=" + filter + "';");
            out.println("</script>");
        }catch (Exception e){
            e.printStackTrace();
            out.println("<script>");
            out.println("alert('등록 중 오류가 발생했습니다. ( 사유: " + e.getMessage().replace("'", "") + ")');");
            out.println("history.back();");
            out.println("</script>");
        }finally {
            out.flush();
            out.close();
        }

        return null;
    }
}
