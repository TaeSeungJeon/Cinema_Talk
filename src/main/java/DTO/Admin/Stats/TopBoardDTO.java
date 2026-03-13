package DTO.Admin.Stats;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TopBoardDTO {
	private int boardId;
    private String boardTitle;
    private String boardName;
    private int boardViewCount;
    private int boardLikeCount;
    private int commentCount;
    private LocalDate boardDate;
    private String movieTitle;
}
