package DTO.Movie.Recommend;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MovieRecResponse {

	private int movie_id;
	private String movie_title;
	private String movie_overview;
	private String movie_release_date;
    private int movie_runtime;
    private String movie_poster_path;
    private String genre_name;
    
}
