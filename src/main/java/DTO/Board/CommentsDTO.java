package DTO.Board;

import lombok.Getter;
import lombok.Setter;

/**
 * 댓글 데이터 전달 객체 (DTO)
 * - 대댓글 구조를 지원하며 boardType으로 어느 게시판의 댓글인지 구분
 * - parentBoardId / parentBoardNo : 대댓글 대상 식별용 (null이면 최상위 댓글)
 * - commentsNo : 대댓글 스레드 순번 관리용
 */
@Getter
@Setter
public class CommentsDTO {

    private int commentsId;           // 댓글 고유 번호
    private int boardId;              // 소속 게시글 번호
    private int boardType;            // 소속 게시판 타입
    private String commentsContent;   // 댓글 내용
    private String commentsName;      // 작성자 닉네임
    private String commentsDate;      // 작성일
    private Integer commentsNo;       // 대댓글 스레드 순번 (null 허용)
    private Integer memNo;            // 작성자 회원 번호 (null 허용)
    private Integer parentBoardNo;    // 대댓글 대상 순번 (null이면 최상위 댓글)
    private Integer parentBoardId;    // 대댓글 대상 댓글 번호 (null이면 최상위 댓글)

    // 좋아요 관련
    private Integer likeCount;        // 댓글 좋아요 수
    private Boolean isLiked;          // 현재 로그인 사용자의 좋아요 여부

    // 마이페이지 조회용
    private String boardTitle;        // 해당 게시글 제목 (마이페이지 내 댓글 목록에서 사용)
    private String memProfilePhoto;   // 작성자 프로필 사진 경로
    private int memRole;              // 작성자 권한 (0: 일반, 1: 관리자 등)
}
