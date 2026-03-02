package DTO.Admin.Stats;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminBoardStatDTO {
	private PeriodStatDTO totalBoardStat;
    private PeriodStatDTO totalCommentStat;

    private int totalLikeCnt;
    private int totalViewCnt;

    private List<TrendDTO> dailyNewBoardTrend;
    private List<TopBoardDTO> topBoards;
}
