package DTO.Movie.Recommend;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MovieRecResponse {

	private int movieId;
	private String movieTitle;
	private String movieOverview;
	private String movieReleaseDate;
    private int movieRuntime;
    private String moviePosterPath;
    private String movieBackdropPath;
    private String genreName;
    private Double movieRatingAverage;
    private int movieRecommendCount;
}
