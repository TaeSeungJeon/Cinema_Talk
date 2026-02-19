package DAO.Member.MyPage;

import java.util.List;

import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import DTO.Member.MemberDTO;
import DTO.Vote.VoteRecordDTO;

public interface MyPageDAO {
	
	// 게시글 관련
	List<BoardDTO> getBoardListByMemNo(int memNo);
	int getBoardCountByMemNo(int memNo);
	
	// 댓글 관련
	List<CommentsDTO> getCommentListByMemNo(int memNo);
	int getCommentCountByMemNo(int memNo);
	
	// 투표 관련
	List<VoteRecordDTO> getVoteRecordListByMemNo(int memNo);
	int getVoteCountByMemNo(int memNo);
	void updateMemberInfo(MemberDTO myPageDTO);
	
}