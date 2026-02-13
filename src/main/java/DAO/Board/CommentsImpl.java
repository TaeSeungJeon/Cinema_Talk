package DAO.Board;

import java.util.List;

import mybatis.SqlMapConfig;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import DTO.Board.CommentsDTO;

public class CommentsImpl implements Comments {

    private SqlSessionFactory factory = SqlMapConfig.getSqlSessionFactory();

    // 싱글톤
    private static CommentsImpl instance = new CommentsImpl();
    public static CommentsImpl getInstance() {
        return instance;
    }
    private CommentsImpl() {}

    // 1. 메서드명을 매퍼 ID(commentsIn)와 통일
    @Override
    public int commentsIn(CommentsDTO cdto) {
        SqlSession sqlSession = factory.openSession(true);
        int result = sqlSession.insert("Comments.commentsIn", cdto);
        sqlSession.close();
        return result;
    }

    // 2. 메서드명을 매퍼 ID(commentsList)와 통일
    @Override
    public List<CommentsDTO> commentsList(int boardId) {
        SqlSession sqlSession = factory.openSession();
        List<CommentsDTO> list = sqlSession.selectList("Comments.commentsList", boardId);
        sqlSession.close();
        return list;
    }
}