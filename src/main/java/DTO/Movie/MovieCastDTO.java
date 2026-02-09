package DTO.Movie;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MovieCastDTO {
	private String personId;
	private String movieId;
	private String characterName;
	private int castOrder;
}
