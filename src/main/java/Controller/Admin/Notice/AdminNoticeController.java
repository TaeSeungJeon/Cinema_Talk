package Controller.Admin.Notice;

import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DAO.Admin.AdminNoticeDAO;
import DAO.Admin.AdminNoticeDAOImpl;
import DTO.Board.BoardDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminNoticeController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        AdminNoticeDAO dao = AdminNoticeDAOImpl.getInstance();

        String sort = request.getParameter("sort");
        if (sort == null || sort.isEmpty()) sort = "latest";

        String searchType = request.getParameter("searchType");
        String keyword = request.getParameter("keyword");
        if (searchType == null) searchType = "";
        if (keyword == null) keyword = "";

        int page = 1;
        int limit = 15;
        if (request.getParameter("page") != null) {
            try { page = Integer.parseInt(request.getParameter("page")); }
            catch (NumberFormatException ignored) {}
        }

        int startRow = (page - 1) * limit + 1;
        int endRow = startRow + limit - 1;

        int totalCount = dao.getNoticeCount(searchType, keyword);
        List<BoardDTO> list = dao.getNoticeList(sort, searchType, keyword, startRow, endRow);

        int maxPage = (totalCount + limit - 1) / limit;
        int startPage = ((page - 1) / 10) * 10 + 1;
        int endPage = Math.min(startPage + 9, maxPage);

        request.setAttribute("noticeList", list);
        request.setAttribute("page", page);
        request.setAttribute("maxPage", maxPage);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("sort", sort);
        request.setAttribute("searchType", searchType);
        request.setAttribute("keyword", keyword);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);

        if (isAjax) {
            forward.setPath("/WEB-INF/views/admin/notice/adminNotice.jsp");
        } else {
            request.setAttribute("contentPage", "/WEB-INF/views/admin/notice/adminNotice.jsp");
            forward.setPath("/WEB-INF/views/admin/adminMyPage.jsp");
        }

        return forward;
    }
}