package DAO.Member;

import DTO.Member.MemberMovieRecommendDTO;

public interface MemberMovieRecommendDAO {

	void addRecommend(MemberMovieRecommendDTO mmrDto);

	void removeRecommend(MemberMovieRecommendDTO mmrDto);

	boolean isFavorite(MemberMovieRecommendDTO mmrDto);

	int getFavoriteCount(int movieId);

}
