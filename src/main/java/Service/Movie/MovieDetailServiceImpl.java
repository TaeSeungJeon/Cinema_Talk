package Service.Movie;

import java.util.ArrayList;
import java.util.List;

import DAO.Movie.GenreDAO;
import DAO.Movie.GenreDAOImpl;
import DAO.Movie.MovieCastDAO;
import DAO.Movie.MovieCastDAOImpl;
import DAO.Movie.MovieCrewDAO;
import DAO.Movie.MovieCrewDAOImpl;
import DAO.Movie.MovieDAO;
import DAO.Movie.MovieDAOImpl;
import DAO.Movie.MovieGenreDAO;
import DAO.Movie.MovieGenreDAOImpl;
import DTO.Movie.GenreDTO;
import DTO.Movie.MovieDTO;
import DTO.Movie.MovieDetailDTO;
import DTO.Movie.MovieDetailDTO.CastInfoDTO;
import DTO.Movie.MovieDetailDTO.CrewInfoDTO;

public class MovieDetailServiceImpl implements MovieDetailService {
	private MovieDAO movieDAO = MovieDAOImpl.getInstance();
	private MovieGenreDAO movieGenreDAO = MovieGenreDAOImpl.getInstance();
	private GenreDAO genreDAO = GenreDAOImpl.getInstance();
	private MovieCastDAO movieCastDAO = MovieCastDAOImpl.getInstance();
	private MovieCrewDAO movieCrewDAO = MovieCrewDAOImpl.getInstance();
	
	@Override
	public MovieDetailDTO getMovieDetail(int movieId) {
		// 1. 영화 기본 정보 조회
		MovieDTO movie = movieDAO.getMovieById(movieId);
		String originalDate = movie.getMovieReleaseDate();
		String fixedDate = originalDate.substring(0, 10);
		movie.setMovieReleaseDate(fixedDate);
		
		if (movie == null) {
			return null;
		}
		
		// 2. 장르 목록 조회
		List<Integer> genreIds = movieGenreDAO.getGenreIdsByMovieId(movieId);
		List<GenreDTO> genres = new ArrayList<>();
		for (int genreId : genreIds) {
			GenreDTO genre = genreDAO.getGenreById(genreId);
			if (genre != null) {
				genres.add(genre);
			}
		}
		
		// 3. 배우 정보 조회 (캐릭터명 포함)
		List<CastInfoDTO> casts = movieCastDAO.getCastInfoByMovieId(movieId);
		
		// 4. 감독 정보 조회
		List<CrewInfoDTO> directors = movieCrewDAO.getDirectorsByMovieId(movieId);
		
		// 5. MovieDetailDTO 생성 및 반환
		MovieDetailDTO movieDetail = new MovieDetailDTO();
		movieDetail.setMovie(movie);
		movieDetail.setGenres(genres);
		movieDetail.setCasts(casts);
		movieDetail.setDirectors(directors);
		
		return movieDetail;
	}
}