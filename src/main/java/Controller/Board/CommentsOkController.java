package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.CommentsDTO;
import Service.Board.CommentsService;
import Service.Board.CommentsServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CommentsOkController implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 1. JSP의 name값과 반드시 일치해야 함
        String boardIdStr = request.getParameter("boardId");
        String boardTypeStr = request.getParameter("boardType");
        String content = request.getParameter("commentsContent");

        // 데이터가 안 넘어왔을 때를 위한 방어 코드
        if (boardIdStr == null || content == null) {
            return null;
        }

        int boardId = Integer.parseInt(boardIdStr);
        int boardType = Integer.parseInt(boardTypeStr);

        // 2. 세션 확인 (로그인 정보가 없으면 등록 안 됨)
        HttpSession session = request.getSession();
        Object memNoObj = session.getAttribute("memNo");

        if (memNoObj == null) {
            // 로그인 안 됐으면 로그인 페이지로 쫓아냄
            ActionForward forward = new ActionForward();
            forward.setPath("memberLogin.do");
            forward.setRedirect(true);
            return forward;
        }

        int memNo = (int)memNoObj;

        // 3. DTO 세팅
        CommentsDTO cdto = new CommentsDTO();
        cdto.setBoardId(boardId);
        cdto.setBoardType(boardType);
        cdto.setCommentsContent(content);
        cdto.setMemNo(memNo);
        cdto.setParentBoardId(boardId);
        cdto.setCommentsName("작성자"); // 나중에 세션 이름으로 변경 가능

        // 4. 서비스 호출
        CommentsService service = CommentsServiceImpl.getInstance();
        int result = service.commentsIn(cdto);

        // 5. 성공 시 상세페이지로 리다이렉트
        ActionForward forward = new ActionForward();
        if (result > 0) {
            forward.setPath("postDetail.do?boardId=" + boardId);
            forward.setRedirect(true);
        }
        return forward;
    }
}