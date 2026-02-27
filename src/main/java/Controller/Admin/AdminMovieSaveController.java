package Controller.Admin;

import java.util.ArrayList;
import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Admin.AdminMovieDetailDTO;
import DTO.Admin.MovieSaveDTO;
import DTO.Admin.MovieSaveDTO.CastSaveDTO;
import DTO.Admin.MovieSaveDTO.CrewSaveDTO;
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

        // 🔥 1️⃣ Movie 기본 정보 세팅
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

        // 🔥 2️⃣ 장르 처리
        String[] genreIds = request.getParameterValues("genreIds");
        List<Integer> genreIdList = new ArrayList<>();

        if (genreIds != null) {
            for (String gid : genreIds) {
                genreIdList.add(Integer.parseInt(gid));
            }
        }

        // 🔥 3️⃣ 출연진 처리
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

        // 🔥 4️⃣ 제작진 처리
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

        // 🔥 5️⃣ SaveDTO 구성
        MovieSaveDTO saveDTO = new MovieSaveDTO();
        saveDTO.setMovie(movie);
        saveDTO.setGenreIds(genreIdList);
        saveDTO.setCasts(castList);
        saveDTO.setCrews(crewList);

        // 🔥 6️⃣ 서비스 호출
        adminMovieService.updateMovie(saveDTO);

        // 🔥 7️⃣ ActionForward 반환 (Redirect)
        ActionForward forward = new ActionForward();
        forward.setRedirect(true);
        forward.setPath(
                request.getContextPath()
                + "/admin/movieDetail.do?movieId="
                + saveDTO.getMovie().getMovieId()
        );

        return forward;
	}

}
