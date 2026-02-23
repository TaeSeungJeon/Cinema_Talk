package DAO.Board;

import DTO.Board.AddFileDTO;
import mybatis.DBService;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AddFileDAOImpl implements AddFileDAO {

    private static AddFileDAOImpl instance;

    private AddFileDAOImpl() {}

    public static AddFileDAOImpl getInstance() {
        if(instance == null) instance = new AddFileDAOImpl();
        return instance;
    }

    private SqlSession getSqlSession() {
        return DBService.getFactory().openSession(false);
    }

    @Override
    public void insertFile(AddFileDTO bdto) {
        SqlSession sqlSession = null;
        try{
            sqlSession = getSqlSession();
            sqlSession.insert("AddFile.insertFile", bdto);
            sqlSession.commit();
        }finally {
            if (sqlSession != null) sqlSession.close();
        }
    }

    @Override
    public List<AddFileDTO> listByBoard(int boardId, int boardType) {
        SqlSession sqlSession = null;
        try{
            sqlSession = getSqlSession();
            Map<String,Object> param = new HashMap<>();
            param.put("boardId", boardId);
            param.put("boardType", boardType);
            return sqlSession.selectList("AddFile.listByBoard", param);
        }finally {
            if(sqlSession != null) sqlSession.close();
        }
    }
}
