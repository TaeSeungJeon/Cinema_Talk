package DTO.Movie;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MovieCrewDTO {
	private int personId;
	private int movieId;
	private String crewJob;
}
