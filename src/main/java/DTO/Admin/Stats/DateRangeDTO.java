package DTO.Admin.Stats;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DateRangeDTO {
	private LocalDate startDate;
    private LocalDate endDate;
}
