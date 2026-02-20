package DTO.Member.MyPage;

import java.util.List;
import java.util.Map;

import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import DTO.Vote.VoteRecordDTO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MyPageDTO {
	
	// 회원 기본 정보
	private String memId;
	private String memName;
	private String memDate;
	
	// 통계 정보
	private int boardCount;      // 게시글 수
	private int commentCount;    // 댓글 수
	private int voteCount;       // 투표 참여 수
	
	// 목록 정보
	private List<BoardDTO> boardList;           // 작성한 게시글 목록
	private List<CommentsDTO> commentList;      // 작성한 댓글 목록
	private List<VoteRecordDTO> voteRecordList; // 참여한 투표 목록
	private List<VoteRecordDTO> voteCommentList; // 투표 댓글 목록
	private Map<Integer, Integer> boardCommentCount;  	// 게시글-댓글 수
}