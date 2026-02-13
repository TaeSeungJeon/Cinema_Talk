package Service.Member.MovieRecommend;

import DTO.Member.MovieRecommend.MemberMovieRecommendDTO;

public interface MemberMovieRecommendService {

	void addRecommend(MemberMovieRecommendDTO mmrDto);

	void removeRecommend(MemberMovieRecommendDTO mmrDto);

	boolean isFavorite(MemberMovieRecommendDTO mmrDto);

	int getFavoriteCount(int movieId);

}