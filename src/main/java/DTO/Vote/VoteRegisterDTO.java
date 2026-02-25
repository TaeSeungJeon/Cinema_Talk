package DTO.Vote;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VoteRegisterDTO {
	private int voteId;
	private String voteTitle;
	private String voteContent;
	private String voteStartDate;
	private String voteEndDate;
	private String voteStatus;
	
	private List<VoteOptionDTO> optionList;
	
	private boolean voted; // 내가 투표했는지
	private List<VoteResultDTO> resultList; // 결과

	//사용자가 선택한 투표선택지 
	private int userChoice;
	
	//참여자 수
	private int voterCount;
	
	//페이징 쪽 나누기 관련변수
	private int startrow;
	private int endrow;
	
	//정렬을 위한 변수
	private String sortCol;
	private String sortDir;
}
