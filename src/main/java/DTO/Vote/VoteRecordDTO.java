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
	// 마이페이지용 추가 필드
	private String voteTitle;
	private String voteEndDate;
	private String movieTitle;

	private String memName;
	
}
