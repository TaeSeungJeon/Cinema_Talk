package DTO.Admin;

import java.util.List;

import DTO.Movie.MovieDTO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MovieSaveDTO {
	private MovieDTO movie;

    private List<Integer> genreIds;

    private List<CastSaveDTO> casts;

    private List<CrewSaveDTO> crews;

    @Getter
    @Setter
    public static class CastSaveDTO {
        private int personId;
        private String characterName;
        private int castOrder;
    }

    @Getter
    @Setter
    public static class CrewSaveDTO {
        private int personId;
        private String crewJob;
    }
}
