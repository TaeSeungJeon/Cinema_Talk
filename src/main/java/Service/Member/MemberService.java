package Service.Member;

import DTO.Member.MemberDTO;

public interface MemberService {

	void insertMember(MemberDTO member);

	MemberDTO idCheck(String mem_id);

	MemberDTO loginCheck(String id);
    MemberDTO getMemberInfo(Integer memNo);
}
