package DTO.Admin.Stats;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TopVoteDTO {
	private int voteId;
    private String voteTitle;
    private LocalDate voteStartDate;
    private LocalDate voteEndDate;
    private String voteStatus;
    private int VoteJoinCnt;
}
