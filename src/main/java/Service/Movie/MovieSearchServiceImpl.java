package Service.Movie;

import java.util.Arrays;
import java.util.List;

import DAO.Movie.MovieDAO;
import DAO.Movie.MovieDAOImpl;
import DTO.Movie.MovieDTO;

public class MovieSearchServiceImpl implements MovieSearchService {
	private MovieDAO movieDAO = MovieDAOImpl.getInstance();

	@Override
	public List<MovieDTO> getMovieDTOList(MovieDTO movieDTO, int searchOption) {
		// 검색어를 공백으로 분리하고, 2글자 이상인 단어만 필터링
		List<String> words = Arrays.stream(movieDTO.getSearchWords().trim().split("\\s+"))
				.filter(w -> w.length() >= 2)
				.toList();
		
		// 유효한 검색어가 없으면 null 반환
		if(words.isEmpty()) {
			return null;
		}
		
		return movieDAO.getMovieDTOList(words, searchOption, movieDTO.getStartrow(), movieDTO.getEndrow());
	}

	@Override
	public int getRowCount(MovieDTO movie, int searchOption) {
		// 검색어를 공백으로 분리하고, 2글자 이상인 단어만 필터링
		List<String> words = Arrays.stream(movie.getSearchWords().trim().split("\\s+"))
				.filter(w -> w.length() >= 2)
				.toList();
		
		// 유효한 검색어가 없으면 0 반환
		if(words.isEmpty()) {
			return 0;
		}
		
		return movieDAO.getRowCount(words, searchOption);
	}

	@Override
	public List<MovieDTO> searchAdminMovies(String keyword) {
		return movieDAO.searchAdminMovies(keyword);
	}
}