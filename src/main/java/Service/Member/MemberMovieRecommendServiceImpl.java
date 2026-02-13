package Service.Member;

import DAO.Member.MemberMovieRecommendDAO;
import DAO.Member.MemberMovieRecommendDAOImpl;
import DTO.Member.MemberMovieRecommendDTO;

public class MemberMovieRecommendServiceImpl implements MemberMovieRecommendService {
	
	private MemberMovieRecommendDAO mmrdao = MemberMovieRecommendDAOImpl.getInstance();
	
	@Override
	public void addRecommend(MemberMovieRecommendDTO mmrDto) {
		mmrdao.addRecommend(mmrDto);
	}

	@Override
	public void removeRecommend(MemberMovieRecommendDTO mmrDto) {
		mmrdao.removeRecommend(mmrDto);
	}

	@Override
	public boolean isFavorite(MemberMovieRecommendDTO mmrDto) {
		return mmrdao.isFavorite(mmrDto);
	}

	@Override
	public int getFavoriteCount(int movieId) {
		return mmrdao.getFavoriteCount(movieId);
	}
	
}
