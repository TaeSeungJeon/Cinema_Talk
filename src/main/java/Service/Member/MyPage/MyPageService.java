package Service.Member.MyPage;

import DTO.Member.MemberDTO;
import DTO.Member.MyPage.MyPageDTO;

public interface MyPageService {
	
	MyPageDTO getMyPageInfo(int memNo);

	void updateMemberInfo(MemberDTO mdto);
	
}