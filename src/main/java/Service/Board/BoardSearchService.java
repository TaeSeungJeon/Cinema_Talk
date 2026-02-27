package Service.Board;

import java.util.List;

import DTO.Board.BoardDTO;

public interface BoardSearchService {

	int getBoardCountByTypeAndWord(int i, String searchWords, int searchOption);

	List<BoardDTO> boardListPageByTypeAndWord(int i, int startRow, int endRow, String searchWords, int searchOption);

	int getBoardCountByMovieId(int movieId);

	List<BoardDTO> boardListPageByMovieId(int movieId, int startRow, int endRow);

}
