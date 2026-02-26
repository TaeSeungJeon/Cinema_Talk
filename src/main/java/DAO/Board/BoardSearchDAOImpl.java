package DAO.Board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import DTO.Board.BoardDTO;
import DTO.Movie.MovieDTO;
import mybatis.DBService;

public class BoardSearchDAOImpl implements BoardSearchDAO {
	private static BoardSearchDAOImpl instance = null;

    public BoardSearchDAOImpl() {
    }

    public static BoardSearchDAOImpl getInstance() {
        if (instance == null) {
            instance = new BoardSearchDAOImpl();
        }
        return instance;
    }

    private SqlSession getSqlSession() {
        return DBService.getFactory().openSession(false);   // false -> 수동 commit 모드
    }

	@Override
	public int getBoardCountByTypeAndWord(int type, List<String> words, int searchOption) {
		SqlSession sqlSession = null;
		try {
			sqlSession = getSqlSession();
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("type", type);
			paramMap.put("wordList", words);
			paramMap.put("searchOption", searchOption);
			
			return sqlSession.selectOne("BoardSearch.boardCount", paramMap);
		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<BoardDTO> boardListPageByTypeAndWord(int type, int startRow, int endRow, List<String> words, int searchOption) {
		SqlSession session = null;
		List<BoardDTO> boards = null;
		
		// 빈 리스트 검사
		if(words == null || words.isEmpty()) {
			return null;
		}
		
		try {
			session = getSqlSession();
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("type", type);
			paramMap.put("wordList", words);
			paramMap.put("startrow", startRow);
			paramMap.put("endrow", endRow);
			
			switch(searchOption) {
				case 0:
					boards = session.selectList("BoardSearch.searchBoardByTitleAndCont", paramMap); 
					break;
				case 1:
					boards = session.selectList("BoardSearch.searchBoardByTitle", paramMap);
					break;
				case 2:
					boards = session.selectList("BoardSearch.searchBoardByCont", paramMap);
					break;
				case 3:
					boards = session.selectList("BoardSearch.searchBoardByWriter", paramMap);
					break;
			}

		} finally {
			if(session != null) {
				session.close();
			}
		}
		return boards;
	}
}
