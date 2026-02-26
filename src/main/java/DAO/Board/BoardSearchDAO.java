package DAO.Board;

import java.util.List;

import DTO.Board.BoardDTO;

public interface BoardSearchDAO {

	int getBoardCountByTypeAndWord(int i, List<String> words, int searchOption);

	List<BoardDTO> boardListPageByTypeAndWord(int i, int startRow, int endRow, List<String> words, int searchOption);

	int getBoardCountByMovieId(int movieId);

	List<BoardDTO> boardListPageByMovieId(int movieId, int startRow, int endRow);

}
