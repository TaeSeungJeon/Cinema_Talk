package DTO.Vote;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VoteResultDTO {

	private int vote_id;
	private int movie_id;
    private int count;
    private int total_voter_count;
    private double percentage;
    private int rank;
    private String movie_title;
}
