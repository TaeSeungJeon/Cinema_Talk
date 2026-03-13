package Controller.Admin.Movie;

import java.util.ArrayList;
import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Admin.Movie.AdminMovieDetailDTO;
import DTO.Admin.Movie.MovieSaveDTO;
import DTO.Admin.Movie.MovieSaveDTO.CastSaveDTO;
import DTO.Admin.Movie.MovieSaveDTO.CrewSaveDTO;
import DTO.Movie.MovieDTO;
import Service.Admin.AdminMovieService;
import Service.Admin.AdminMovieServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminMovieSaveController implements Action {

	AdminMovieService adminMovieService = AdminMovieServiceImpl.getInstance();
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        MovieDTO movie = new MovieDTO();

        String movieIdStr = request.getParameter("movieId");
        if (movieIdStr == null || movieIdStr.isEmpty()) {
            throw new IllegalArgumentException("movieId가 전달되지 않았습니다.");
        }
        movie.setMovieId(Integer.parseInt(movieIdStr));

        movie.setMovieTitle(request.getParameter("movieTitle"));
        movie.setMovieOriginalTitle(request.getParameter("movieOriginalTitle"));
        movie.setMovieOverview(request.getParameter("movieOverview"));
        movie.setMovieReleaseDate(request.getParameter("movieReleaseDate"));
        movie.setMoviePosterPath(request.getParameter("moviePosterPath"));
        movie.setMovieBackdropPath(request.getParameter("movieBackdropPath"));

        String runtimeStr = request.getParameter("movieRuntime");
        if (runtimeStr != null && !runtimeStr.isEmpty()) {
            movie.setMovieRuntime(Integer.parseInt(runtimeStr));
        }

        String ratingAvgStr = request.getParameter("movieRatingAverage");
        if (ratingAvgStr != null && !ratingAvgStr.isEmpty()) {
            movie.setMovieRatingAverage(Double.parseDouble(ratingAvgStr));
        }

        String ratingCountStr = request.getParameter("movieRatingCount");
        if (ratingCountStr != null && !ratingCountStr.isEmpty()) {
            movie.setMovieRatingCount(Integer.parseInt(ratingCountStr));
        }

        String[] genreIds = request.getParameterValues("genreIds");
        List<Integer> genreIdList = new ArrayList<>();

        if (genreIds != null) {
            for (String gid : genreIds) {
                genreIdList.add(Integer.parseInt(gid));
            }
        }

        String[] castPersonIds = request.getParameterValues("castPersonIds");
        String[] characterNames = request.getParameterValues("characterNames");
        String[] castOrders = request.getParameterValues("castOrders");

        List<CastSaveDTO> castList = new ArrayList<>();

        if (castPersonIds != null) {
            for (int i = 0; i < castPersonIds.length; i++) {

                CastSaveDTO cast = new CastSaveDTO();

                cast.setPersonId(Integer.parseInt(castPersonIds[i]));
                if (characterNames != null && characterNames.length > i) {
                    cast.setCharacterName(characterNames[i]);
                }

                if (castOrders != null && castOrders.length > i &&
                		castOrders[i] != null && !castOrders[i].isEmpty()) {
                	cast.setCastOrder(Integer.parseInt(castOrders[i]));
                } else {
                	cast.setCastOrder(0);
                }

                castList.add(cast);
            }
        }

        String[] crewPersonIds = request.getParameterValues("crewPersonIds");
        String[] crewJobs = request.getParameterValues("crewJobs");

        List<CrewSaveDTO> crewList = new ArrayList<>();

        if (crewPersonIds != null) {
            for (int i = 0; i < crewPersonIds.length; i++) {

                CrewSaveDTO crew = new CrewSaveDTO();

                crew.setPersonId(Integer.parseInt(crewPersonIds[i]));
                if (crewJobs != null && crewJobs.length > i) {
                    crew.setCrewJob(crewJobs[i]);
                }
                crewList.add(crew);
            }
        }

        MovieSaveDTO saveDTO = new MovieSaveDTO();
        saveDTO.setMovie(movie);
        saveDTO.setGenreIds(genreIdList);
        saveDTO.setCasts(castList);
        saveDTO.setCrews(crewList);

        adminMovieService.updateMovie(saveDTO);

        if (isAjax) {
			response.setContentType("text/plain; charset=UTF-8");
		    response.getWriter().write("success");
		    return null;
		}

        ActionForward forward = new ActionForward();
        forward.setRedirect(true);
        forward.setPath(request.getContextPath() + "/adminMypage.do");

        return forward;
	}

}
