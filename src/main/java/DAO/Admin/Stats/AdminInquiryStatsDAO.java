package DAO.Admin.Stats;

import java.time.LocalDate;
import java.util.List;

import DTO.Admin.Stats.DateRangeDTO;
import DTO.Admin.Stats.InquiryStatusStatDTO;
import DTO.Admin.Stats.TrendDTO;

public interface AdminInquiryStatsDAO {

	int selTotalInquiryCnt();

	int selTotalInquiryCountByDate(LocalDate targetDate);

	int selCompletedInquiryCnt();

	int selCompletedInquiryCountByDate(LocalDate targetDate);

	int selProcessingInquiryCnt();

	double selAvgProcessingTime();

	InquiryStatusStatDTO selInquiryStatus(DateRangeDTO dataRange);

	List<TrendDTO> selDailyReceivedInquiryTrend(DateRangeDTO dataRange);

}
