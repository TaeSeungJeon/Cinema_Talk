package Service.Member.MyPage;

import DAO.Member.MyPage.MyPageDAO;
import DAO.Member.MyPage.MyPageDAOImpl;
import DTO.Member.MemberDTO;
import DTO.Member.MyPage.MyPageDTO;

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
		
		return myPageDTO;
	}
	
	@Override
	public void updateMemberInfo(MemberDTO mdto) {
		myPageDAO.updateMemberInfo(mdto);
	}
	
}