package DTO.Admin.Stats;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminMemberStatDTO {
	private PeriodStatDTO totalMemberStat;
    private PeriodStatDTO newMemberStat;

    private int sleepMemberCnt;
    private int outMemberCnt;

    private List<TrendDTO> dailyNewMemberTrend;
    
    private List<TopMemberDTO> topBoardMembers;
    private List<TopMemberDTO> topCommentMembers;
}
