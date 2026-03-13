package DAO.Member;

import java.util.List;
import java.util.Map;

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

	List<MemberDTO> getMemberList(int startRow, int endRow);

	List<MemberDTO> getMemberListByState(String memState, int startRow, int endRow);

	int updateMemberState(int memNo, int targetState);

	List<MemberDTO> searchMembers(String keyword, int startRow, int endRow);

	List<MemberDTO> searchMembersByState(String keyword, String memState, int startRow, int endRow);

	int countMembers(Map<String, Object> countParam);

}
