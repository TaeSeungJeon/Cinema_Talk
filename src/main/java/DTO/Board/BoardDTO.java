package DTO.Board;

import lombok.Getter;
import lombok.Setter;

@Setter@Getter
public class BoardDTO {

    private int boardId;
    private int boardType;
    private String boardTitle;
    private String boardContent;
    private String boardName;
	private int boardViewCount;
    private String boardDate;
    private Integer memNo;
    private int movieId;
    private int likeCount;
}
