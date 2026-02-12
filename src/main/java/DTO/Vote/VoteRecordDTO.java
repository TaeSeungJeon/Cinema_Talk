package DTO.Vote;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VoteRecordDTO {

	private int recordId;
	private String recordCreatedDate;
	private int memNo;
	private int voteId;
	private int movieId;
	private String voteCommentText;
	private String memName;
	
	
	
}
