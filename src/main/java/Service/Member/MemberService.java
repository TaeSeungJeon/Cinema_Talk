package Service.Member;

import DTO.Member.MemberDTO;

public interface MemberService {

	void insertMember(MemberDTO member);

	MemberDTO idCheck(String memId);

	MemberDTO loginCheck(String id);
    MemberDTO getMemberInfo(Integer memNo);

	MemberDTO findId(MemberDTO mdto);

	MemberDTO findByIdAndPhone(String memId, String memPhone);

	boolean resetPwdSendEmail(MemberDTO mdto);

}
