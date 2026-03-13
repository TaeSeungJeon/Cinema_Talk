package Service.Member;

import java.util.List;
import java.util.Map;

import DTO.Member.MemberDTO;

public interface MemberService {

	void insertMember(MemberDTO member);

	MemberDTO idCheck(String memId);

	MemberDTO loginCheck(String id);
	
    MemberDTO getMemberInfo(Integer memNo);

	MemberDTO findId(MemberDTO mdto);

	MemberDTO findByIdAndPhone(String memId, String memPhone);

	boolean resetPwdSendEmail(MemberDTO mdto);

	MemberDTO phoneCheck(String memPhone);

	MemberDTO emailCheck(String memEmail);

	int withdrawMember(int memNo);	

	List<MemberDTO> getMemberList(int startRow, int endRow);

	List<MemberDTO> getMemberListByState(String memState, int startRow, int endRow);

	int updateMemberState(int memNo, int targetState);

	List<MemberDTO> searchMembers(String keyword, int startRow, int endRow);

	List<MemberDTO> searchMembersByState(String keyword, String memState, int startRow, int endRow);

	int countMembers(Map<String, Object> countParam);

}
