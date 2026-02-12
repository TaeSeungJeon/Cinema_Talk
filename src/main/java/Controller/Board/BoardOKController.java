package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import DTO.Member.MemberDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.PrintWriter;

public class BoardOKController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(false);        // 세션이 없을때 생성하지않고 null 반환
        PrintWriter out = response.getWriter();

        Integer memNo = (Integer)session.getAttribute("mem_id");

        if(memNo == null) {
            out.println("<script>");
            out.println("alert('글을 작성하려면 로그인을 해주세요.');");
            out.println("location='/Board';");
            out.println("</script>");

        }else{
            BoardDTO bdto = new BoardDTO();
            BoardService boardService = new BoardServiceImpl();

            String boardTitle = request.getParameter("board-Title"); //글제목
            String boardCont = request.getParameter("board-Cont"); // 글 내용

            // 회원 dao 로그인한 회원 정보에서 이름 가져오기
            MemberService memberService = new MemberServiceImpl();
            MemberDTO mdto = memberService.getMemberInfo(memNo);

            bdto.setBoardTitle(boardTitle);
            bdto.setBoardContent(boardCont);

            boardService.boardIn(bdto);


        }

    return null;
    }
}
