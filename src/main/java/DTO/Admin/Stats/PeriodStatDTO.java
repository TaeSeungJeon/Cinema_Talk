package DTO.Admin.Stats;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PeriodStatDTO {
	private int currentValue;
    private int previousValue;
    private double increaseRate;
}
