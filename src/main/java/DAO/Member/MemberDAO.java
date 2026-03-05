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

	MemberDTO phoneCheck(String memPhone);

	MemberDTO emailCheck(String memEmail);

	int updatePwd(MemberDTO mdto);

	int withdrawMember(int memNo);

	String findProfilePhotoPath(int memNo);

	int updateProfilePhotoPath(int memNo, String relativePath);
	
	int updateLastLogin(String memId);

	List<MemberDTO> getMemberList();

	List<MemberDTO> getMemberListByState(String memState);

	int updateMemberState(int memNo, int targetState);

	List<MemberDTO> searchMembers(String keyword);

	List<MemberDTO> searchMembersByState(String keyword, String memState);

}
