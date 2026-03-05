package Service.Member;

import java.util.List;

import DTO.Member.MemberDTO;

public interface MemberService {

	void insertMember(MemberDTO member);

	MemberDTO idCheck(String memId);

	MemberDTO loginCheck(String id);
	
    MemberDTO getMemberInfo(Integer memNo);

	MemberDTO findId(MemberDTO mdto);

	MemberDTO findByIdAndPhone(String memId, String memPhone);

	boolean resetPwdSendEmail(MemberDTO mdto);

	int phoneCheck(String memPhone);

	int emailCheck(String memEmail);

	int withdrawMember(int memNo);
	
	int updateLastLogin(String memId);

	List<MemberDTO> getMemberList();

	List<MemberDTO> getMemberListByState(String memState);

	int updateMemberState(int memNo, int targetState);

	List<MemberDTO> searchMembers(String keyword);

	List<MemberDTO> searchMembersByState(String keyword, String memState);
}
