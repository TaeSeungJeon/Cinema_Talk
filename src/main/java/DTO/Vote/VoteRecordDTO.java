package DTO.Vote;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VoteRecordDTO {

	private int record_id;
	private String record_created_date;
	private int mem_no;
	private int vote_id;
	private int movie_id;
	private String vote_comment_text;
	
	
	
}
