package DTO.Movie.Recommend;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MovieRecRequest {
	
	private String type; //장르별, 선호별, 인기별
	private String genreId; //장르 번호
	private String movieRatingAverage; //평점
	private String movieRecommendCount; //좋아요 수
}
