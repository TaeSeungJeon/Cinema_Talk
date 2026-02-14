package DAO.Board;

import java.util.List;
import java.util.Map;

import mybatis.SqlMapConfig;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import DTO.Board.CommentsDTO;

public class CommentsImpl implements Comments {

    private SqlSessionFactory factory = SqlMapConfig.getSqlSessionFactory();

    // 싱글톤
    private static CommentsImpl instance = new CommentsImpl();
    public static CommentsImpl getInstance() {
        return instance;}

    private CommentsImpl() {}

    // 메서드명을 매퍼 ID(commentsIn)와 통일
    @Override
    public int commentsIn(CommentsDTO cdto) {
        SqlSession sqlSession = factory.openSession(true);
        int result = sqlSession.insert("Comments.commentsIn", cdto);
        sqlSession.close();
        return result;
    }

    // 메서드명을 매퍼 ID(commentsList)와 통일
    @Override
    public List<CommentsDTO> commentsList(int boardId) {
        SqlSession sqlSession = factory.openSession();
        List<CommentsDTO> list = sqlSession.selectList("Comments.commentsList", boardId);
        sqlSession.close();
        return list;
    }

    @Override
    public int commentsUpdate(CommentsDTO cdto) {
        SqlSession sqlSession = factory.openSession(true); // true: auto-commit
        int result = sqlSession.update("Comments.commentsUpdate", cdto);
        sqlSession.close();
        return result;
    }

    @Override
    public int commentsDelete(Map<String, Object> map) {
        SqlSession sqlSession = factory.openSession(true);
        int result = sqlSession.delete("Comments.commentsDelete", map);
        sqlSession.close();
        return result;
    }
}