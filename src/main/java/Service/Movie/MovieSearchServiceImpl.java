package Service.Movie;

import java.util.Arrays;
import java.util.List;

import DAO.Movie.MovieDAO;
import DAO.Movie.MovieDAOImpl;
import DTO.Movie.MovieDTO;
import DTO.Movie.Recommend.MovieRecResponse;

public class MovieSearchServiceImpl implements MovieSearchService {
	private MovieDAO movieDAO = MovieDAOImpl.getInstance();

	@Override
	public List<MovieDTO> getMovieDTOList(MovieDTO movieDTO, int searchOption) {
		String searchText = movieDTO.getSearchWords().trim();
		List<String> words;
		
		// 인물 검색(감독=1, 배우=2, 제작진=4)은 전체 이름을 하나의 검색어로 사용
		// 제목(0), 장르(3) 검색은 공백으로 분리하여 다중 키워드 검색
		if (searchOption == 1 || searchOption == 2 || searchOption == 4) {
			// 인물 검색: 전체 문자열을 하나의 검색어로 사용 (정확한 이름 매칭)
			if (searchText.length() < 2) {
				return null;
			}
			words = List.of(searchText);
		} else {
			// 제목/장르 검색: 공백으로 분리, 2글자 이상 필터링
			words = Arrays.stream(searchText.split("\\s+"))
					.filter(w -> w.length() >= 2)
					.toList();
		}
		
		// 유효한 검색어가 없으면 null 반환
		if(words.isEmpty()) {
			return null;
		}
		
		List<MovieDTO> movies = movieDAO.getMovieDTOList(words, searchOption, movieDTO.getStartrow(), movieDTO.getEndrow());
		if (movies == null || movies.isEmpty()) {
			return null;
		}
		for (MovieDTO movie : movies) {
				String originalDate = movie.getMovieReleaseDate();
				String fixedDate = originalDate.substring(0, 10);
				movie.setMovieReleaseDate(fixedDate);
		}		
		return movies;
	}

	@Override
	public int getRowCount(MovieDTO movie, int searchOption) {
		String searchText = movie.getSearchWords().trim();
		List<String> words;
		
		// 인물 검색(감독=1, 배우=2, 제작진=4)은 전체 이름을 하나의 검색어로 사용
		if (searchOption == 1 || searchOption == 2 || searchOption == 4) {
			if (searchText.length() < 2) {
				return 0;
			}
			words = List.of(searchText);
		} else {
			words = Arrays.stream(searchText.split("\\s+"))
					.filter(w -> w.length() >= 2)
					.toList();
		}
		
		// 유효한 검색어가 없으면 0 반환
		if(words.isEmpty()) {
			return 0;
		}
		
		return movieDAO.getRowCount(words, searchOption);
	}

	@Override
	public List<MovieDTO> searchAdminMovies(String keyword) {
		List<MovieDTO> list = movieDAO.searchAdminMovies(keyword);
		if (list != null) {
			for (MovieDTO movie : list) {
				if (movie.getMovieReleaseDate() != null && movie.getMovieReleaseDate().length() > 10) {
					movie.setMovieReleaseDate(movie.getMovieReleaseDate().substring(0, 10));
				}
			}
		}
		return list;
	}
}