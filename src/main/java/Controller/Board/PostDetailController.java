package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.AddFileDTO;
import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import DTO.Board.LinkPreviewDTO;
import DTO.Member.MemberDTO;
import DTO.Member.MyPage.MyPageDTO;
import DTO.Vote.VoteRegisterDTO;
import Service.Board.AddFileService;
import Service.Board.AddFileServiceImpl;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;
import Service.Board.CommentsService;
import Service.Board.CommentsServiceImpl;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import Service.Member.MyPage.MyPageService;
import Service.Member.MyPage.MyPageServiceImpl;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;
import java.util.Map;

/**
 * 게시글 상세 조회 컨트롤러
 * - 게시글 본문, 첨부파일, 댓글 목록, 링크 미리보기, 사이드바 데이터를 조합하여 postDetail.jsp로 전달
 */
public class PostDetailController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int boardId = Integer.parseInt(request.getParameter("boardId"));

        BoardService boardService   = BoardServiceImpl.getInstance();
        MemberService memberService = new MemberServiceImpl();

        // 게시글 상세 조회 + 링크 미리보기 파싱 (조회수 증가 포함)
        Map<String, Object> result   = boardService.getBoardDetailWithPreview(boardId);
        BoardDTO cont                = (BoardDTO) result.get("board");
        LinkPreviewDTO preview       = (LinkPreviewDTO) result.get("preview");

        // 게시글이 존재하지 않으면 목록으로 리다이렉트
        if (cont == null) {
            ActionForward forward = new ActionForward();
            forward.setPath("freeBoard.do");
            forward.setRedirect(true);
            return forward;
        }

        // 첨부파일 목록
        AddFileService fileService   = AddFileServiceImpl.getInstance();
        List<AddFileDTO> fileList    = fileService.listByBoard(cont.getBoardId(), cont.getBoardType());

        // 댓글 목록 + 각 댓글 작성자 프로필 세팅
        CommentsService cService     = CommentsServiceImpl.getInstance();
        Integer loginMemNo           = (Integer) request.getSession().getAttribute("memNo");
        List<CommentsDTO> clist      = cService.commentsListWithLike(boardId, loginMemNo);

        for (CommentsDTO c : clist) {
            // [버그 수정] memNo가 null인 댓글(비회원 등)에서 getMemberInfo 호출 시 NPE 방지
            if (c.getMemNo() != null) {
                MemberDTO commentMember = memberService.getMemberInfo(c.getMemNo());
                if (commentMember != null) {
                    c.setMemProfilePhoto(commentMember.getMemProfilePhoto());
                    c.setMemRole(commentMember.getMemRole());
                }
            }
        }

        // 게시글 작성자 정보
        MemberDTO member     = memberService.getMemberInfo(cont.getMemNo());
        MyPageService myPageService = new MyPageServiceImpl();
        MyPageDTO myPageInfo = (member != null) ? myPageService.getMyPageInfo(member.getMemNo()) : null;

        // 본문 내 HTML 태그 제거 (OG description 등 텍스트 전용 필드용)
        String textOnly = cont.getBoardContent().replaceAll("<[^>]*>", "");

        // 사이드바 데이터
        List<BoardDTO> hotList = boardService.hotBoardList(10);
        VoteService voteService = new VoteServiceImpl();
        List<VoteRegisterDTO> activeVoteRegList = voteService.getActiveVoteRegList();

        request.setAttribute("dailyPopularList",   boardService.getPopularBoardList("daily",   10));
        request.setAttribute("weeklyPopularList",  boardService.getPopularBoardList("weekly",  10));
        request.setAttribute("monthlyPopularList", boardService.getPopularBoardList("monthly", 10));
        request.setAttribute("hotList",            hotList);
        request.setAttribute("activeVoteRegList",  activeVoteRegList);

        // 게시글 상세 데이터
        int likeCount = boardService.getBoardLikeCount(cont.getBoardId(), cont.getBoardType());
        request.setAttribute("likeCount",        likeCount);
        request.setAttribute("cont",             cont);
        request.setAttribute("preview",          preview);
        request.setAttribute("textOnlyContent",  textOnly);
        request.setAttribute("clist",            clist);
        request.setAttribute("fileList",         fileList);
        request.setAttribute("member",           member);
        request.setAttribute("myPageInfo",       myPageInfo);

        ActionForward forward = new ActionForward();
        forward.setPath("/WEB-INF/views/board/postDetail.jsp");
        forward.setRedirect(false);
        return forward;
    }
}
