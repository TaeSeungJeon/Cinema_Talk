package DTO.Vote;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VoteOptionDTO {

	private int voteId;
	private int movieId;
	private int movieDeleted; //0 false, 1 true

	//선택지 매핑
	private String movieTitle;
	private String movieReleaseDate;
	private String moviePosterPath;
	

}
