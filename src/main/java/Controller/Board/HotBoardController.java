package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.util.List;

public class HotBoardController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int limit = 10;

        String limitParam = request.getParameter("limit");
        if(limitParam != null) {
            limit = Integer.parseInt(limitParam);
        }

        BoardService service = BoardServiceImpl.getInstance();
        List<BoardDTO> list = service.hotBoardList(limit);

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        StringBuilder json = new StringBuilder();
        json.append("{\"items\":[");

        for (int i = 0; i < list.size(); i++) {
            BoardDTO dto = list.get(i);

            json.append("{");
            json.append("\"rank\":").append(i+1).append(",");
            json.append("\"boardId\":").append(dto.getBoardId()).append(",");
            json.append("\"boardType\":").append(dto.getBoardType()).append(",");
            json.append("\"title\":\"").append(dto.getBoardTitle().replace("\"", "\\\"")).append("\",");
            json.append("\"likeCount\":").append(dto.getLikeCount()).append(",");
            json.append("\"readCount\":").append(dto.getBoardRecommendCount());
            json.append("}");

            if (i < list.size() -1) {
                json.append(",");
            }
        }

        json.append("]}");
        out.println(json.toString());
        out.flush();

        return null;
    }
}
