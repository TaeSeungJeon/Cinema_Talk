package DTO.Admin.Stats;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminInquiryStatDTO {
	private PeriodStatDTO totalInquiryStat;
    private PeriodStatDTO completedInquiryStat;

    private int pendingInquiryCnt;
    private String avgProcessingTime;  // 시간 단위

    private InquiryStatusStatDTO inquiryStatus;
    private List<TrendDTO> dailyInquiryTrend;
}
