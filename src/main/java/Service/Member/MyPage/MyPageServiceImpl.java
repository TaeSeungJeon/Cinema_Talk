package Service.Member.MyPage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import DAO.Member.MyPage.MyPageDAO;
import DAO.Member.MyPage.MyPageDAOImpl;
import DTO.Board.BoardDTO;
import DTO.Member.MemberDTO;
import DTO.Member.MyPage.MyPageDTO;
import DTO.Movie.GenreDTO;

public class MyPageServiceImpl implements MyPageService {
	
	private MyPageDAO myPageDAO = MyPageDAOImpl.getInstance();
	
	@Override
	public MyPageDTO getMyPageInfo(int memNo) {
		MyPageDTO myPageDTO = new MyPageDTO();
		
		
		// 통계 정보 조회
		myPageDTO.setBoardCount(myPageDAO.getBoardCountByMemNo(memNo));
		myPageDTO.setCommentCount(myPageDAO.getCommentCountByMemNo(memNo));
		myPageDTO.setVoteCount(myPageDAO.getVoteCountByMemNo(memNo));
		
		// 목록 정보 조회
		myPageDTO.setBoardList(myPageDAO.getBoardListByMemNo(memNo));
		myPageDTO.setCommentList(myPageDAO.getCommentListByMemNo(memNo));
		myPageDTO.setVoteRecordList(myPageDAO.getVoteRecordListByMemNo(memNo));
		myPageDTO.setVoteCommentList(myPageDAO.getVoteCommentListByMemNo(memNo));
		
		List<BoardDTO> boardList = myPageDTO.getBoardList();
		Map<Integer, Integer> boardCommentCountMap = new HashMap<>();
		boardList.forEach(board -> {
		    int boardId = board.getBoardId();
		    List<Integer> commentCounts = myPageDAO.getBoardCommentCountByMemNo(boardId);
		    int totalComments = commentCounts.stream().mapToInt(Integer::intValue).sum();
		    
		    boardCommentCountMap.put(boardId, totalComments);
		});
		myPageDTO.setBoardCommentCount(boardCommentCountMap);
		
		// 좋아요 목록 조회
		myPageDTO.setLikedMovieList(myPageDAO.getLikedMoviesByMemNo(memNo));
		myPageDTO.setLikedBoardList(myPageDAO.getLikedBoardsByMemNo(memNo));
		
		// 선호 장르 ID 목록 조회
		myPageDTO.setPreferredGenreIds(myPageDAO.getPreferredGenreIds(memNo));
		
		return myPageDTO;
	}
	
	@Override
	public void updateMemberInfo(MemberDTO mdto) {
		myPageDAO.updateMemberInfo(mdto);
	}
	
	@Override
	public List<GenreDTO> getAllGenres() {
		return myPageDAO.getAllGenres();
	}
	
	@Override
	public void savePreferredGenres(int memNo, List<Integer> genreIds) {
		// 기존 선호 장르 삭제
		myPageDAO.deletePreferredGenres(memNo);
		
		for(int genreId : genreIds) {
			System.out.println("선호 장르 ID: " + genreId);
		}

		// 새로 저장
		if (genreIds != null) {
			for (int genreId : genreIds) {
				myPageDAO.insertPreferredGenre(memNo, genreId);
			}
		}
	}
	
}