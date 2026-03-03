package Controller.Admin.Quiry;

import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import Service.Admin.AdminQuiryService;
import Service.Admin.AdminQuiryServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminQuiryController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        AdminQuiryService service = AdminQuiryServiceImpl.getInstance();

        String sort = request.getParameter("sort");
        if (sort == null || sort.isEmpty()) sort = "latest";

        String searchType = request.getParameter("searchType");
        String keyword = request.getParameter("keyword");
        String unanswered = request.getParameter("unanswered");
        if (searchType == null) searchType = "";
        if (keyword == null) keyword = "";
        if (unanswered == null) unanswered = "";

        int page = 1;
        int limit = 15;
        if (request.getParameter("page") != null) {
            try { page = Integer.parseInt(request.getParameter("page")); }
            catch (NumberFormatException ignored) {}
        }

        int startRow = (page - 1) * limit + 1;
        int endRow = startRow + limit - 1;

        int totalCount = service.getQuiryCount(searchType, keyword, unanswered);
        List<BoardDTO> list = service.getQuiryList(sort, searchType, keyword, unanswered, startRow, endRow);

        int maxPage = (totalCount + limit - 1) / limit;
        int startPage = ((page - 1) / 10) * 10 + 1;
        int endPage = Math.min(startPage + 9, maxPage);

        request.setAttribute("quiryList", list);
        request.setAttribute("page", page);
        request.setAttribute("maxPage", maxPage);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("sort", sort);
        request.setAttribute("searchType", searchType);
        request.setAttribute("keyword", keyword);
        request.setAttribute("unanswered", unanswered);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);

        if (isAjax) {
            forward.setPath("/WEB-INF/views/admin/quiry/adminQuiry.jsp");
        } else {
            request.setAttribute("contentPage", "/WEB-INF/views/admin/quiry/adminQuiry.jsp");
            forward.setPath("/WEB-INF/views/admin/adminMyPage.jsp");
        }

        return forward;
    }
}
