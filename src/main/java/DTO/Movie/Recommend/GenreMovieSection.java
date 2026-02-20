package DTO.Movie.Recommend;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class GenreMovieSection {
	private int genreId;
    private String sectionGenreName;
    private List<MovieRecResponse> movies = new ArrayList<>();
}
