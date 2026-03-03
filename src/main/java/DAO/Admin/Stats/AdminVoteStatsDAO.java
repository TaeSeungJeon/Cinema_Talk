package DAO.Admin.Stats;

import java.time.LocalDate;
import java.util.List;

import DTO.Admin.Stats.DateRangeDTO;
import DTO.Admin.Stats.TopVoteDTO;
import DTO.Admin.Stats.TrendDTO;

public interface AdminVoteStatsDAO {

	int selVoteCnt();

	int selTotalVoteCountByDate(LocalDate targetDate);

	int selVoteJoinCnt();

	int selTotalVoteJoinCountByDate(LocalDate targetDate);

	int selVoteCommentCnt();

	int selActiveVoteStat();

	List<TrendDTO> selMonthlyVoteTrend(DateRangeDTO dataRange);

	List<TopVoteDTO> selTopVotes();

}