package DAO.Board;

import DTO.Board.BoardDTO;
import mybatis.DBService;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class BoardDAOImpl implements BoardDAO{

        private static BoardDAOImpl instance = null;

        public BoardDAOImpl() {
        }

        public static BoardDAOImpl getInstance() {
            if (instance == null) {
                instance = new BoardDAOImpl();
            }
            return instance;
        }

        private SqlSession getSqlSession() {
            return DBService.getFactory().openSession(false);   // false -> 수동 commit 모드
        }

    @Override
    public void boardIn(BoardDTO bdto) {
        SqlSession sqlSession = null;
        try {
            sqlSession = getSqlSession();
            sqlSession.insert("Board.boardIn", bdto);
            sqlSession.commit();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }//boardIn() -> 글작성
    // 게시글 목록 조회
    @Override
    public List<BoardDTO> boardList() {

        SqlSession sqlSession = null;
        List<BoardDTO> boardList = null;

        try {
            sqlSession = getSqlSession();
            boardList = sqlSession.selectList("Board.boardList");

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return boardList;
    }
}