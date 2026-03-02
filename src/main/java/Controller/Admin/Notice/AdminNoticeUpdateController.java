package Controller.Admin.Notice;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import DAO.Admin.AdminNoticeDAO;
import DAO.Admin.AdminNoticeDAOImpl;
import DTO.Board.BoardDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminNoticeUpdateController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        int boardId = Integer.parseInt(request.getParameter("boardId"));
        String boardTitle = request.getParameter("boardTitle");
        String boardContent = request.getParameter("boardContent");

        BoardDTO dto = new BoardDTO();
        dto.setBoardId(boardId);
        dto.setBoardTitle(boardTitle);
        dto.setBoardContent(boardContent);

        AdminNoticeDAO dao = AdminNoticeDAOImpl.getInstance();
        int result = dao.updateNotice(dto);

        PrintWriter out = response.getWriter();
        out.print(result > 0 ? "success" : "fail");
        out.flush();

        return null;
    }
}
