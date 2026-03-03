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

        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        MemberService memberService = new MemberServiceImpl();

        // 세션에서 회원 ID 가져오기
        HttpSession session = request.getSession();
        String memId = (String) session.getAttribute("memId");
           
        if (memId == null) {
            if (isAjax) {
                response.setContentType("application/json; charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"status\":\"loginRequired\"}");
                out.flush();
                return null;
            }
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('로그인이 필요합니다.');");
            out.println("location='" + request.getContextPath() + "/memberLogin.do';");
            out.println("</script>");
            return null;
        }

        // 파라미터 가져오기
        String movieIdParam = request.getParameter("movieId");
        String action = request.getParameter("action");
        String redirectUrl = request.getParameter("redirect");

        if (movieIdParam == null || action == null) {
            if (isAjax) {
                response.setContentType("application/json; charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"status\":\"error\",\"message\":\"파라미터 오류\"}");
                out.flush();
                return null;
            }
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
            if (!isFavorite) {
                favoriteService.addRecommend(dto);
            }
        } else if ("remove".equals(action)) {
            favoriteService.removeRecommend(dto);
        }

        if (isAjax) {
            boolean newFavoriteState = favoriteService.isFavorite(dto);
            int favoriteCount = favoriteService.getFavoriteCount(Integer.parseInt(movieIdParam));

            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"status\":\"success\",\"isFavorite\":" + newFavoriteState + ",\"favoriteCount\":" + favoriteCount + "}");
            out.flush();
            return null;
        }

        // 일반 요청이면 기존 리다이렉트
        ActionForward forward = new ActionForward();
        forward.setPath(redirectUrl != null ? redirectUrl : "index.do");
        forward.setRedirect(false);
        return forward;
    }
}