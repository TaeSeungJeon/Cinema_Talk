package Controller.Member.MovieRecommend;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import DTO.Member.MovieRecommend.MemberMovieRecommendDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import Service.Member.MovieRecommend.MemberMovieRecommendService;
import Service.Member.MovieRecommend.MemberMovieRecommendServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class MemberMovieRecommendController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        MemberService memberService = new MemberServiceImpl();
        PrintWriter out = response.getWriter();
        
        // 세션에서 회원 ID 가져오기
        HttpSession session = request.getSession();
        String memId = (String) session.getAttribute("memId");

        if (memId == null) {
            // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
        	out.println("<script>");
        	out.println("alert('로그인이 필요합니다.');");
        	out.println("history.back();");
        	out.println("</script>");
        	return null;
        }

        // 파라미터 가져오기
        String movieIdParam = request.getParameter("movieId");
        String action = request.getParameter("action");
        String redirectUrl = request.getParameter("redirect");

        if (movieIdParam == null || action == null) {
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
        boolean isFavorite = favoriteService.isFavorite(dto);
        
        if ("add".equals(action)) {
        	if (isFavorite) {
            } else {
            	favoriteService.addRecommend(dto);
            }
        } else if ("remove".equals(action)) {
            favoriteService.removeRecommend(dto);
        }

        // 리다이렉트
        ActionForward forward = new ActionForward();
        forward.setPath(redirectUrl != null ? redirectUrl : "index.do");
        forward.setRedirect(false);
        return forward;
    }
}