package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardServiceDAO;
import Service.Board.BoardServiceImplDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 게시판 전체 목록을 불러와서 freeBoard.jsp로 전달하는 컨트롤러
 */
public class BoardController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        // 서비스 객체 생성
        BoardServiceDAO service = new BoardServiceImplDAO();

        // 게시글 전체 목록 가져오기 로직 수행
        List<BoardDTO> list = service.boardList();

        // JSP에서 사용할 수 있도록 request 영역에 저장
        request.setAttribute("boardList", list);

        // 목록 페이지(freeBoard.jsp)로 이동 설정
        ActionForward forward = new ActionForward();
        forward.setPath("/WEB-INF/views/board/freeBoard.jsp");
        forward.setRedirect(false); // 데이터를 담아서 가야 하므로 forward 방식(false)

        return forward;
    }
}