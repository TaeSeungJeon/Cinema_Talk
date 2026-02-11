package Service.Member;

import DTO.Member.MemberDTO;

public interface MemberService {

	void insertMember(MemberDTO member);

	MemberDTO idCheck(String mem_id);

}
