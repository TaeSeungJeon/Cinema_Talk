package DTO.Movie;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MovieCrewDTO {
	private int person_id;
	private int movie_id;
	private String crew_job;
}
