package DTO.Admin.Stats;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminSummaryDTO {
	private PeriodStatDTO newMemberCnt;
    private PeriodStatDTO newBoardCnt;
    private PeriodStatDTO newVoteJoinCnt;
    private PeriodStatDTO newInquiryCnt;

    private List<TrendDTO> dailyVisitorTrend;
    private List<TrendDTO> dailyNewMemberTrend;
}
