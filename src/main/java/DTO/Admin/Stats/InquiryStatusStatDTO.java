package DTO.Admin.Stats;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InquiryStatusStatDTO {
	private int completedCnt;
    private int processingCnt;
    private int pendingCnt;
}
