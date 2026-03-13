package Service.Admin;

import DTO.Admin.Stats.AdminBoardStatDTO;
import DTO.Admin.Stats.AdminInquiryStatDTO;
import DTO.Admin.Stats.AdminMemberStatDTO;
import DTO.Admin.Stats.AdminSummaryDTO;
import DTO.Admin.Stats.AdminVoteStatDTO;
import DTO.Admin.Stats.DateRangeDTO;

public interface AdminStatsService {

	AdminSummaryDTO getSummaryStat(DateRangeDTO dataRange);

	AdminMemberStatDTO getMemberStat(DateRangeDTO dataRange);

	AdminBoardStatDTO getBoardStat(DateRangeDTO dataRange);

	AdminVoteStatDTO getVoteStat(DateRangeDTO dataRange);

	AdminInquiryStatDTO getInquiryStat(DateRangeDTO dataRange);

}
