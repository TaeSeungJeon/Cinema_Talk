package Controller.Admin.Movie;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import Controller.Action;
import Controller.ActionForward;
import DTO.Admin.Movie.AdminMovieDetailDTO;
import DTO.Movie.GenreDTO;
import DTO.Movie.MovieDetailDTO;
import Service.Member.MovieRecommend.MemberMovieRecommendService;
import Service.Member.MovieRecommend.MemberMovieRecommendServiceImpl;
import Service.Movie.GenreService;
import Service.Movie.GenreServiceImpl;
import Service.Movie.MovieDetailService;
import Service.Movie.MovieDetailServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminMovieDetailController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String idParam = request.getParameter("movieId");
        int movieId = Integer.parseInt(idParam);

        MovieDetailService movieService = new MovieDetailServiceImpl();
        MovieDetailDTO movieDetail = movieService.getMovieDetail(movieId);

        if (movieDetail == null) {
            ActionForward forward = new ActionForward();
            forward.setPath("/WEB-INF/views/error/notFound.jsp");
            forward.setRedirect(false);
            return forward;
        }

        MemberMovieRecommendService recommendService =
                new MemberMovieRecommendServiceImpl();
        int favoriteCount = recommendService.getFavoriteCount(movieId);

        GenreService genreService = new GenreServiceImpl();
        List<GenreDTO> allGenres = genreService.getAllGenres();

        AdminMovieDetailDTO adminDto = new AdminMovieDetailDTO();
        
        adminDto.setMovieId(movieId);
        adminDto.setMovieTitle(movieDetail.getMovie().getMovieTitle());
        adminDto.setMovieOriginalTitle(movieDetail.getMovie().getMovieOriginalTitle());
        adminDto.setMoviePosterPath(movieDetail.getMovie().getMoviePosterPath());
        adminDto.setMovieBackdropPath(movieDetail.getMovie().getMovieBackdropPath());
        adminDto.setMovieReleaseDate(movieDetail.getMovie().getMovieReleaseDate());
        adminDto.setMovieRuntime(movieDetail.getMovie().getMovieRuntime());
        adminDto.setMovieOverview(movieDetail.getMovie().getMovieOverview());
        adminDto.setMovieRatingAverage(movieDetail.getMovie().getMovieRatingAverage());
        adminDto.setMovieRatingCount(movieDetail.getMovie().getMovieRatingCount());

        adminDto.setMovieFavoriteCount(favoriteCount);

        adminDto.setGenres(movieDetail.getGenres());      // 현재 영화 장르
        adminDto.setAllGenres(allGenres);                 // 전체 장르

        adminDto.setCasts(movieDetail.getCasts());
        adminDto.setDirectors(movieDetail.getDirectors());

        Set<Integer> movieGenreIds = movieDetail.getGenres()
                .stream()
                .map(GenreDTO::getGenreId)
                .collect(Collectors.toSet());

        request.setAttribute("movieGenreIds", movieGenreIds);
        request.setAttribute("adminMovie", adminDto);

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("/WEB-INF/views/admin/movie/adminMovieDetail.jsp");

        return forward;
	}

}
