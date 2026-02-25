package Service.Admin;

import org.apache.ibatis.session.SqlSession;

import DAO.Admin.AdminMovieDAO;
import DAO.Admin.AdminMovieDAOImpl;
import DTO.Admin.MovieSaveDTO;
import DTO.Admin.MovieSaveDTO.CastSaveDTO;
import DTO.Admin.MovieSaveDTO.CrewSaveDTO;
import DTO.Movie.MovieDTO;
import mybatis.DBService;

public class AdminMovieServiceImpl implements AdminMovieService {

	private static final AdminMovieServiceImpl instance = new AdminMovieServiceImpl();

    private final AdminMovieDAO dao = AdminMovieDAOImpl.getInstance();

    private AdminMovieServiceImpl() {}

    public static AdminMovieServiceImpl getInstance() {
        return instance;
    }
    
    private SqlSession getSqlSession() {		
		return DBService.getFactory().openSession(false);
	}
    
    @Override
    public void saveMovie(MovieSaveDTO saveDTO) {

        SqlSession session = getSqlSession();

        try {

            MovieDTO movie = saveDTO.getMovie();

            boolean exists = false;

            if (movie.getMovieId() != 0) {
                exists = dao.existsMovie(session, movie.getMovieId());
            }

            if (exists) {
                dao.updateMovie(session, movie);
            } else {
                dao.insertMovie(session, movie);
            }

            int movieId = movie.getMovieId();

            // ===== 장르 =====
            dao.deleteMovieGenres(session, movieId);
            if (saveDTO.getGenreIds() != null) {
                for (Integer gid : saveDTO.getGenreIds()) {
                    dao.insertMovieGenre(session, movieId, gid);
                }
            }

            // ===== 출연진 =====
            dao.deleteMovieCasts(session, movieId);
            if (saveDTO.getCasts() != null) {
                for (CastSaveDTO cast : saveDTO.getCasts()) {
                    dao.insertMovieCast(session, movieId, cast);
                }
            }

            // ===== 제작진 =====
            dao.deleteMovieCrews(session, movieId);
            if (saveDTO.getCrews() != null) {
                for (CrewSaveDTO crew : saveDTO.getCrews()) {
                    dao.insertMovieCrew(session, movieId, crew);
                }
            }

            session.commit();

        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("AdminMovie save 실패", e);
        } finally {
            session.close();
        }
    }

}
