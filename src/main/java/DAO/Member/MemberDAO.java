package DAO.Member;

import DTO.Member.MemberDTO;

public interface MemberDAO {

	void insertMember(MemberDTO member);

	MemberDTO idCheck(String memId);

	MemberDTO loginCheck(String id);

	MemberDTO findId(MemberDTO mdto);

	MemberDTO getMemberInfo(Integer memNo);
}
