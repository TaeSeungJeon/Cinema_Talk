package DTO.Board;

import lombok.Getter;
import lombok.Setter;

@Setter@Getter
public class BoardDTO {

    public int getBoardType() { return boardType; }
    public void setBoardType(int boardType) { this.boardType = boardType; }

    private int boardId;
    private int boardType;
    private String boardTitle;
    private String boardContent;
    private String boardName;
    private int boardRecommendCount;
    private String boardDate;
    private Integer memNo;
    private int movieId;
}
