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
    private int genreId;
    private String genreName;
    private String sectionGenreName;
    private Double movieRatingAverage;
    private int movieRecommendCount;
}
