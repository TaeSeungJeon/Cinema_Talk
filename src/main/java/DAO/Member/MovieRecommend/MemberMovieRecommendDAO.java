package DAO.Member.MovieRecommend;

import DTO.Member.MovieRecommend.MemberMovieRecommendDTO;

public interface MemberMovieRecommendDAO {

	void addRecommend(MemberMovieRecommendDTO mmrDto);

	void removeRecommend(MemberMovieRecommendDTO mmrDto);

	boolean isFavorite(MemberMovieRecommendDTO mmrDto);

	int getFavoriteCount(int movieId);

}