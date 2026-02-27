package DAO.Member;

import java.util.List;

import DTO.Member.MemberDTO;

public interface MemberDAO {

	void insertMember(MemberDTO member);

	MemberDTO idCheck(String memId);

	MemberDTO loginCheck(String id);

	MemberDTO findId(MemberDTO mdto);

	MemberDTO getMemberInfo(Integer memNo);

	MemberDTO findByIdAndPhone(String memId, String memPhone);

	int phoneCheck(String memPhone);

	int emailCheck(String memEmail);

	int updatePwd(MemberDTO mdto);

	int withdrawMember(int memNo);

	String findProfilePhotoPath(int memNo);

	int updateProfilePhotoPath(int memNo, String relativePath);
	
	int updateLastLogin(String memId);

	List<MemberDTO> getMemberList();


}
