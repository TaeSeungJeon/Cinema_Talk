package DTO.Movie;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MovieCastDTO {
	private int person_id;
	private int movie_id;
	private String character_name;
	private int cast_order;
}
