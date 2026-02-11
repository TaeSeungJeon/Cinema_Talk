package DTO.Movie.Recommend;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MovieRecRequest {
	
	private String type; //장르별, 선호별, 인기별
	private String genre_id; //장르 번호
	private String movie_rating_average; //평점
	private String movie_recommend_count; //좋아요 수
}
