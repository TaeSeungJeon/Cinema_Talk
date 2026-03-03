package DAO.Admin.Stats;

import java.time.LocalDate;
import java.util.List;

import DTO.Admin.Stats.DateRangeDTO;
import DTO.Admin.Stats.TopBoardDTO;
import DTO.Admin.Stats.TrendDTO;

public interface AdminBoardStatsDAO {

	int selBoardCnt();

	int selTotalBoardCountByDate(LocalDate targetDate);

	int selCommentCnt();

	int selTotalCommentCountByDate(LocalDate targetDate);

	int selLikeCnt();

	int selViewCnt();

	List<TrendDTO> selDailyNewBoardTrend(DateRangeDTO dataRange);

	List<TopBoardDTO> selTopBoards();

}