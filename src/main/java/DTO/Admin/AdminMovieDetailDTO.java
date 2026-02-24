package DTO.Admin;

import java.util.List;

import DTO.Movie.GenreDTO;
import DTO.Movie.MovieDetailDTO.CastInfoDTO;
import DTO.Movie.MovieDetailDTO.CrewInfoDTO;
import lombok.Data;

@Data
public class AdminMovieDetailDTO {
	
	private int movieId;
    private String movieTitle;
    private String movieOriginalTitle;
    private String moviePosterPath;
    private String movieBackdropPath;
    private String movieReleaseDate;
    private int movieRuntime;
    private String movieOverview;
    private double movieRatingAverage;
    private int movieRatingCount;
    private int movieFavoriteCount;

    private List<GenreDTO> genres;
    private List<GenreDTO> allGenres; 
    private List<CastInfoDTO> casts;
    private List<CrewInfoDTO> directors;
}
