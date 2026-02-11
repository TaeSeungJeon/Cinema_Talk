package DTO.Vote;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VoteRegisterDTO {
	private int vote_id;
	private String vote_title;
	private String vote_content;
	private String vote_start_date;
	private String vote_end_date;
	private String vote_status;
	
	private List<VoteOptionDTO> optionList;
	
	private boolean voted; // 내가 투표했는지
	private List<VoteResultDTO> resultList; // 결과
}
