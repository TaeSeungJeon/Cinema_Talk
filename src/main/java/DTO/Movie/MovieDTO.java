package DTO.Movie;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MovieDTO {
	private int 	movieId;
    private String 	movieTitle;
    private String 	movieOriginalTitle;
    private String 	movieOverview;
    private String 	movieReleaseDate;
    private int 	movieRuntime;
    private String 	moviePosterPath;
    private String 	movieBackdropPath;
    private Double 	movieRatingAverage;
    private int 	movieRatingCount;
    private String 	movieCreatedAt;
    private int     movieRecommendCount;
    
    //페이징(쪽나누기) 관련변수
  	private int startrow;	
  	private int endrow;
  	
  	//검색 관련 변수
  	private String searchWords;
}
