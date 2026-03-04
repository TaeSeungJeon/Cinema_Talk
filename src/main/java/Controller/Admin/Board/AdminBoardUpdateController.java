package Controller.Admin.Board;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Admin.AdminBoardService;
import Service.Admin.AdminBoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminBoardUpdateController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        AdminBoardService service = AdminBoardServiceImpl.getInstance();
        int boardId = Integer.parseInt(request.getParameter("boardId"));
        String boardTitle = request.getParameter("boardTitle");
        String boardContent = request.getParameter("boardContent");

        BoardDTO dto = new BoardDTO();
        dto.setBoardId(boardId);
        dto.setBoardTitle(boardTitle);
        dto.setBoardContent(boardContent);

        int result = service.updateBoard(dto);

        PrintWriter out = response.getWriter();
        out.print(result > 0 ? "success" : "fail");
        out.flush();

        return null;
    }
}
