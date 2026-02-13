package DTO.Board;


import lombok.Getter;
import lombok.Setter;

@Setter@Getter
public class CommentsDTO {
    private int commentsId;
    private int boardId;
    private int boardType;
    private String commentsContent;
    private String commentsName;
    private String commentsDate;
    private int commentsNo;
    private int memNo;
    private int parentBoardNo;
    private int parentBoardId;
    
    // 마이페이지용 추가 필드
    private String boardTitle;
}
