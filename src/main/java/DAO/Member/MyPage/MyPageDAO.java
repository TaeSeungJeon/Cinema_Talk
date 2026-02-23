package DAO.Member.MyPage;

import java.util.List;

import DTO.Board.BoardDTO;
import DTO.Board.CommentsDTO;
import DTO.Member.MemberDTO;
import DTO.Movie.GenreDTO;
import DTO.Movie.MovieDTO;
import DTO.Vote.VoteRecordDTO;

public interface MyPageDAO {
	
	// 게시글 관련
	List<BoardDTO> getBoardListByMemNo(int memNo);
	int getBoardCountByMemNo(int memNo);
	List<Integer> getBoardCommentCountByMemNo(int boardId);
	// 댓글 관련
	List<CommentsDTO> getCommentListByMemNo(int memNo);
	int getCommentCountByMemNo(int memNo);
	
	// 투표 관련
	List<VoteRecordDTO> getVoteRecordListByMemNo(int memNo);
	int getVoteCountByMemNo(int memNo);
	List<VoteRecordDTO> getVoteCommentListByMemNo(int memNo);
	void updateMemberInfo(MemberDTO myPageDTO);
	
	// 좋아요 관련
	List<MovieDTO> getLikedMoviesByMemNo(int memNo);
	List<BoardDTO> getLikedBoardsByMemNo(int memNo);
	
	// 선호 장르 관련
	List<GenreDTO> getAllGenres();
	List<Integer> getPreferredGenreIds(int memNo);
	void deletePreferredGenres(int memNo);
	void insertPreferredGenre(int memNo, int genreId);
}