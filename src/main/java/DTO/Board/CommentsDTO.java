package DTO.Board;

import lombok.Data;
import java.sql.Date;

@Data
public class CommentsDTO {
    private int commentsId;
    private int boardId;
    private int boardType;
    private String commentsContent;
    private String commentsName;
    private Date commentsDate;
    private Integer commentsNo;
    private Integer memNo;
    private Integer parentBoardNo; // null 허용을 위해 Integer 사용
    private Integer parentBoardId; // null 허용을 위해 Integer 사용
    
    // 댓글 좋아요 관련 필드
    private Integer likeCount;      // 댓글 좋아요 개수
    private Boolean isLiked;        // 현재 사용자의 좋아요 여부
    
    // 마이페이지용 추가 필드
    private String boardTitle;
}
