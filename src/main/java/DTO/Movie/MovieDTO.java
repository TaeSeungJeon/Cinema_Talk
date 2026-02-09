package DTO.Movie;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MovieDTO {
	private String 	movieId;
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
}
