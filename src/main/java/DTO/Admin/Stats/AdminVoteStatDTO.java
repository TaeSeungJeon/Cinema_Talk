package DTO.Admin.Stats;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminVoteStatDTO {
	private PeriodStatDTO totalVoteStat;
    
    private PeriodStatDTO voteJoinStat;

    private int voteCommentCnt;
    private int activeVoteStat;
    private List<TrendDTO> monthlyVoteTrend;
    private List<TopVoteDTO> topVotes;
}
