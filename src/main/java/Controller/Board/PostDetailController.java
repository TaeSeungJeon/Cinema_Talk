package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import DTO.Board.LinkPreviewDTO;
import DTO.Member.MemberDTO;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import Service.Board.CommentsService;
import Service.Board.CommentsServiceImpl;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

import DTO.Board.AddFileDTO;
import Service.Board.AddFileService;
import Service.Board.AddFileServiceImpl;

public class PostDetailController implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int boardId = Integer.parseInt(request.getParameter("boardId"));

        BoardService service = BoardServiceImpl.getInstance();
        MemberService memberService = new MemberServiceImpl();
        Map<String, Object> result = service.getBoardDetailWithPreview(boardId);

        BoardDTO cont = (BoardDTO) result.get("board");
        LinkPreviewDTO preview = (LinkPreviewDTO) result.get("preview");

        // 게시글이 존재하지 않으면 목록으로 리다이렉트
        if (cont == null) {
            ActionForward forward = new ActionForward();
            forward.setPath("freeBoard.do");
            forward.setRedirect(true);
            return forward;
        }
        // 실시간 인기글
        List<BoardDTO> hotList = service.hotBoardList(10);
        request.setAttribute("hotList", hotList);

        // 일, 주, 월간 인기글 (사이드바용)
        List<BoardDTO> dailyPopularList   = service.getPopularBoardList("daily",   10);
        List<BoardDTO> weeklyPopularList  = service.getPopularBoardList("weekly",  10);
        List<BoardDTO> monthlyPopularList = service.getPopularBoardList("monthly", 10);
        
        request.setAttribute("dailyPopularList", dailyPopularList);
        request.setAttribute("weeklyPopularList", weeklyPopularList);
        request.setAttribute("monthlyPopularList", monthlyPopularList);

        /* 첨부파일 기능 */
        AddFileService fileService = AddFileServiceImpl.getInstance();
        List<AddFileDTO> fileList = fileService.listByBoard(cont.getBoardId(), cont.getBoardType());
        request.setAttribute("fileList", fileList);

        CommentsService cService = CommentsServiceImpl.getInstance();

        Integer memNo = (Integer) request.getSession().getAttribute("memNo");
        List<CommentsDTO> clist = cService.commentsListWithLike(boardId, memNo);
        for(CommentsDTO c : clist){
            MemberDTO member = memberService.getMemberInfo(c.getMemNo());
            c.setMemProfilePhoto(member.getMemProfilePhoto());
        }
        // 좋아요
        int likeCount = service.getBoardLikeCount(cont.getBoardId(), cont.getBoardType());

        request.setAttribute("likeCount", likeCount);
        request.setAttribute("cont", cont);
        request.setAttribute("preview", preview);

        String rawContent = cont.getBoardContent();
        MemberDTO member = memberService.getMemberInfo(cont.getMemNo());

        // 모든 HTML 태그 제거
        String textOnly = rawContent.replaceAll("<[^>]*>", "");

        request.setAttribute("textOnlyContent", textOnly);
        request.setAttribute("clist", clist);
        request.setAttribute("member", member);

        ActionForward forward = new ActionForward();
        forward.setPath("/WEB-INF/views/board/postDetail.jsp");
        forward.setRedirect(false);
        return forward;


    }

}
