package DTO.Movie;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MovieCastDTO {
	private int personId;
	private int movieId;
	private String characterName;
	private int castOrder;
}
