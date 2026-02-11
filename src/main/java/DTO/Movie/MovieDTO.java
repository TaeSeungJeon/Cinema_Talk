package DTO.Movie;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MovieDTO {
	private int 	movie_id;
    private String 	movie_title;
    private String 	movie_original_title;
    private String 	movie_overview;
    private String 	movie_release_date;
    private int 	movie_runtime;
    private String 	movie_poster_path;
    private String 	movie_backdrop_path;
    private Double 	movie_rating_average;
    private int 	movie_rating_count;
    private String 	movie_created_at;
    private int     movie_recommend_count;
    
    //페이징(쪽나누기) 관련변수
  	private int startrow;	
  	private int endrow;
  	
  	//검색 관련 변수
  	private String search_words;
}
