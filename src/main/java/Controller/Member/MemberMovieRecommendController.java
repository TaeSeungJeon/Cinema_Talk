package Controller.Member;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import DTO.Member.MemberMovieRecommendDTO;
import Service.Member.MemberMovieRecommendService;
import Service.Member.MemberMovieRecommendServiceImpl;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class MemberMovieRecommendController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        MemberService memberService = new MemberServiceImpl();
        // 세션에서 회원 ID 가져오기
        HttpSession session = request.getSession();
        String memId = (String) session.getAttribute("memId");

        if (memId == null) {
            // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
            ActionForward forward = new ActionForward();
            forward.setPath("/WEB-INF/views/member/login.jsp");
            forward.setRedirect(false);
            return forward;
        }

        // 파라미터 가져오기
        String movieIdParam = request.getParameter("movieId");
        String action = request.getParameter("action");
        String redirectUrl = request.getParameter("redirect");

        if (movieIdParam == null || action == null) {
            // 에러 처리
            ActionForward forward = new ActionForward();
            forward.setPath("/WEB-INF/views/error/error.jsp");
            forward.setRedirect(false);
            return forward;
        }

        MemberDTO memberdto = memberService.loginCheck(memId);
        MemberMovieRecommendDTO dto = new MemberMovieRecommendDTO();
        dto.setMemNo(memberdto.getMemNo());
        dto.setMovieId(Integer.parseInt(movieIdParam));
        
        MemberMovieRecommendService favoriteService = new MemberMovieRecommendServiceImpl();
        if ("add".equals(action)) {
            favoriteService.addRecommend(dto);
        } else if ("remove".equals(action)) {
            favoriteService.removeRecommend(dto);
        }

        // 리다이렉트
        ActionForward forward = new ActionForward();
        forward.setPath(redirectUrl != null ? redirectUrl : "index.do");
        forward.setRedirect(true);
        return forward;
    }
}