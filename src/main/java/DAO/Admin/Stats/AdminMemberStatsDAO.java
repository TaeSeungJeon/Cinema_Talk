package DAO.Admin.Stats;

import java.time.LocalDate;
import java.util.List;

import DTO.Admin.Stats.DateRangeDTO;
import DTO.Admin.Stats.TopMemberDTO;
import DTO.Admin.Stats.TrendDTO;

public interface AdminMemberStatsDAO {

	int selNewMemberCntByRange(DateRangeDTO dataRange);

	int selNewBoardCntByRange(DateRangeDTO dataRange);

	int selNewVoteJoinCntByRange(DateRangeDTO dataRange);

	int selNewInquiryCntByRange(DateRangeDTO dataRange);

	List<TrendDTO> selDailyVisitorTrend(DateRangeDTO dataRange);

	List<TrendDTO> selDailyNewMemberTrend(DateRangeDTO dataRange);
	
	int selMemberCnt();

	int selTotalMemberCountByDate(LocalDate targetDate);

	int selNewMemberCnt(DateRangeDTO dataRange);

	int selSleepMemberCnt();

	int selOutMemberCnt();

	List<TrendDTO> selNewMemberTrend(DateRangeDTO dataRange);

	List<TopMemberDTO> selTopBoardMembers();

	List<TopMemberDTO> selTopCommentMembers();

}