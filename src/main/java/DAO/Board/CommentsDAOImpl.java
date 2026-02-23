package DAO.Board;

import java.util.List;
import java.util.Map;

import mybatis.DBService;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import DTO.Board.CommentsDTO;

public class CommentsDAOImpl implements CommentsDAO {

    private SqlSessionFactory factory = DBService.getFactory();

    // 싱글톤
    private static CommentsDAOImpl instance = new CommentsDAOImpl();
    public static CommentsDAOImpl getInstance() {
        return instance;}

    private CommentsDAOImpl() {}

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
        SqlSession sqlSession = factory.openSession(true);
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

    // 댓글 좋아요 추가
    @Override
    public int commentsLikeInsert(Map<String, Object> map) {
        SqlSession sqlSession = factory.openSession(true);
        int result = sqlSession.insert("Comments.commentsLikeInsert", map);
        sqlSession.close();
        return result;
    }

    // 댓글 좋아요 삭제
    @Override
    public int commentsLikeDelete(Map<String, Object> map) {
        SqlSession sqlSession = factory.openSession(true);
        int result = sqlSession.delete("Comments.commentsLikeDelete", map);
        sqlSession.close();
        return result;
    }

    // 댓글 좋아요 개수 조회
    @Override
    public int commentsLikeCount(int commentsId) {
        SqlSession sqlSession = factory.openSession(true);
        int result = sqlSession.selectOne("Comments.commentsLikeCount", commentsId);
        sqlSession.close();
        return result;
    }

    // 사용자의 댓글 좋아요 여부 확인
    @Override
    public int commentsLikeCheck(Map<String, Object> map) {
        SqlSession sqlSession = factory.openSession(true);
        int result = sqlSession.selectOne("Comments.commentsLikeCheck", map);
        sqlSession.close();
        return result;
    }

    // 좋아요 정보 포함된 댓글 목록 조회
    @Override
    public List<CommentsDTO> commentsListWithLike(Map<String, Object> map) {
        SqlSession sqlSession = factory.openSession(true);
        List<CommentsDTO> list = sqlSession.selectList("Comments.commentsListWithLike", map);
        sqlSession.close();
        return list;
    }
}