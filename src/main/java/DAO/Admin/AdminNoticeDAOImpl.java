package DAO.Admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import DTO.Board.BoardDTO;
import mybatis.DBService;

public class AdminNoticeDAOImpl implements AdminNoticeDAO {

    private static AdminNoticeDAOImpl instance;

    private AdminNoticeDAOImpl() {}

    public static AdminNoticeDAOImpl getInstance() {
        if (instance == null) {
            instance = new AdminNoticeDAOImpl();
        }
        return instance;
    }

    private SqlSession getSqlSession() {
        return DBService.getFactory().openSession(false);
    }

    @Override
    public int getNoticeCount(String searchType, String keyword) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            Map<String, Object> param = new HashMap<>();
            param.put("searchType", searchType);
            param.put("keyword", keyword);
            return session.selectOne("AdminNotice.getNoticeCount", param);
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public List<BoardDTO> getNoticeList(String sort, String searchType, String keyword,
                                         int startRow, int endRow) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            Map<String, Object> param = new HashMap<>();
            param.put("sort", sort);
            param.put("searchType", searchType);
            param.put("keyword", keyword);
            param.put("startRow", startRow);
            param.put("endRow", endRow);
            return session.selectList("AdminNotice.getNoticeList", param);
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public BoardDTO getNoticeDetail(int boardId) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            return session.selectOne("AdminNotice.getNoticeDetail", boardId);
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public int updateNotice(BoardDTO dto) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            int result = session.update("AdminNotice.updateNotice", dto);
            if (result > 0) session.commit();
            return result;
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public int deleteNotice(int boardId) {
        SqlSession session = null;
        try {
            session = getSqlSession();
            int result = session.delete("AdminNotice.deleteNotice", boardId);
            if (result > 0) session.commit();
            return result;
        } finally {
            if (session != null) session.close();
        }
    }
}
