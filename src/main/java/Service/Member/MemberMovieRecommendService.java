package Service.Member;

import DTO.Member.MemberMovieRecommendDTO;

public interface MemberMovieRecommendService {

	void addRecommend(MemberMovieRecommendDTO mmrDto);

	void removeRecommend(MemberMovieRecommendDTO mmrDto);

	boolean isFavorite(MemberMovieRecommendDTO mmrDto);

	int getFavoriteCount(int movieId);

}
