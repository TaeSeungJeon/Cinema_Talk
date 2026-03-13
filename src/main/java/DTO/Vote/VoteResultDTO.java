package DTO.Vote;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VoteResultDTO {

	private int voteId;
	private int movieId;
    private int count;
    private int totalVoterCount;
    private double percentage;
    private int rank;
    private String movieTitle;
}
