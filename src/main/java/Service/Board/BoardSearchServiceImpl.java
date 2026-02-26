package Service.Board;

import java.util.Arrays;
import java.util.List;

import DAO.Board.BoardSearchDAO;
import DAO.Board.BoardSearchDAOImpl;
import DTO.Board.BoardDTO;

public class BoardSearchServiceImpl implements BoardSearchService {
	
	private static BoardSearchServiceImpl instance;
	private BoardSearchDAO boardSearchDAO;

	public BoardSearchServiceImpl() {
		boardSearchDAO = BoardSearchDAOImpl.getInstance();
	}
	
	public static BoardSearchService getInstance() {
		if (instance == null) {
            instance = new BoardSearchServiceImpl();
        }
        return instance;
	}

	@Override
	public int getBoardCountByTypeAndWord(int type, String searchWords, int searchOption) {
		// 검색어를 공백으로 분리하고, 2글자 이상인 단어만 필터링
		List<String> words = Arrays.stream(searchWords.trim().split("\\s+"))
				.filter(w -> w.length() >= 2)
				.toList();
				
		// 유효한 검색어가 없으면 0 반환
		if(words.isEmpty()) {
			return 0;
		}
		
		return boardSearchDAO.getBoardCountByTypeAndWord(type, words, searchOption);
	}

	@Override
	public List<BoardDTO> boardListPageByTypeAndWord(int type, int startRow, int endRow, String searchWords, int searchOption) {
		// 검색어를 공백으로 분리하고, 2글자 이상인 단어만 필터링
		List<String> words = Arrays.stream(searchWords.trim().split("\\s+"))
				.filter(w -> w.length() >= 2)
				.toList();
						
		// 유효한 검색어가 없으면 0 반환
		if(words.isEmpty()) {
			return null;
		}
				
		return boardSearchDAO.boardListPageByTypeAndWord(type, startRow, endRow, words, searchOption);
	}

	@Override
	public int getBoardCountByMovieId(int movieId) {
		return boardSearchDAO.getBoardCountByMovieId(movieId);
	}

	@Override
	public List<BoardDTO> boardListPageByMovieId(int movieId, int startRow, int endRow) {
		return boardSearchDAO.boardListPageByMovieId(movieId, startRow, endRow);
	}
	
}
