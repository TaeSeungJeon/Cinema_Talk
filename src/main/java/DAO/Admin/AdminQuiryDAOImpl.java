package DAO.Admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import mybatis.DBService;

public class AdminQuiryDAOImpl implements AdminQuiryDAO {

    private static AdminQuiryDAOImpl instance;

    private AdminQuiryDAOImpl() {}

    public static AdminQuiryDAOImpl getInstance() {
        if (instance == null) {
            instance = new AdminQuiryDAOImpl();
        }
        return instance;
    }

    private SqlSession getSqlSession() {
        return DBService.getFactory().openSession(false);
    }

    @Override
    public int getQuiryCount(String searchType, String keyword, String unanswered) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            Map<String, Object> param = new HashMap<>();
            param.put("searchType", searchType);
            param.put("keyword", keyword);
            param.put("unanswered", "Y".equals(unanswered));

            return session.selectOne("AdminQuiry.getQuiryCount", param);
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public List<BoardDTO> getQuiryList(String sort, String searchType, String keyword,
                                        String unanswered, int startRow, int endRow) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            Map<String, Object> param = new HashMap<>();
            param.put("sort", sort);
            param.put("searchType", searchType);
            param.put("keyword", keyword);
            param.put("unanswered", "Y".equals(unanswered));
            param.put("startRow", startRow);
            param.put("endRow", endRow);

            return session.selectList("AdminQuiry.getQuiryList", param);
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public BoardDTO getQuiryDetail(int boardId) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            return session.selectOne("AdminQuiry.getQuiryDetail", boardId);
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public List<CommentsDTO> getQuiryComments(int boardId) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            return session.selectList("AdminQuiry.getQuiryComments", boardId);
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public int insertReply(CommentsDTO dto) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            int result = session.insert("AdminQuiry.insertReply", dto);
            if (result > 0) session.commit();
            return result;
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public int deleteQuiry(int boardId) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            int result = session.delete("AdminQuiry.deleteQuiry", boardId);
            if (result > 0) session.commit();
            return result;
        } finally {
            if (session != null) session.close();
        }
    }
}
