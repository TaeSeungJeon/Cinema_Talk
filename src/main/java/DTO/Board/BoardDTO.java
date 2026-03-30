package DTO.Board;

import lombok.Getter;
import lombok.Setter;

/**
 * 게시글 데이터 전달 객체 (DTO)
 * - 자유게시판, 공지사항, 문의게시판, 영화게시판 등 boardType으로 구분
 */
@Getter
@Setter
public class BoardDTO {

    private int boardId;           // 게시글 고유 번호
    private int boardType;         // 게시판 타입 (1: 자유, 2: 공지, 3: 문의, 4: 영화)
    private String boardTitle;     // 게시글 제목
    private String boardContent;   // 게시글 내용
    private String boardName;      // 작성자 닉네임
    private int boardViewCount;    // 조회수
    private String boardDate;      // 작성일
    private Integer memNo;         // 작성자 회원 번호 (비로그인 허용을 위해 Integer)
    private int movieId;           // 연관 영화 ID (영화게시판 전용)
    private int likeCount;         // 좋아요 수
    private int commentCount;      // 댓글 수
    private String linkUrl;        // 첨부 링크 URL
    private String movieTitle;     // 연관 영화 제목 (JOIN 조회용)
}
