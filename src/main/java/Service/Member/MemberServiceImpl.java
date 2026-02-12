package Service.Member;

import org.mindrot.jbcrypt.BCrypt;

import DAO.Member.MemberDAO;
import DAO.Member.MemberDAOImpl;
import DTO.Member.MemberDTO;

public class MemberServiceImpl implements MemberService {

	private MemberDAO mdao = MemberDAOImpl.getInstance();
	
	@Override
	public void insertMember(MemberDTO member) {
		
		// 사용자가 입력한 비밀번호
		String memPwd = member.getMemPwd();
		
		// BCrypt로 암호화
		String memPassword = BCrypt.hashpw(memPwd, BCrypt.gensalt(12));
		
		// DTO에 암호화된 비밀번호 다시 저장
		member.setMemPwd(memPassword);
		
		// DAO 호출 (DB저장)
		this.mdao.insertMember(member);
		
	}//입력받은 회원정보 저장

	@Override
	public MemberDTO idCheck(String memId) {
		return this.mdao.idCheck(memId);
	}//아이디 중복체크

	@Override
	public MemberDTO loginCheck(String id) {
		return this.mdao.loginCheck(id);
	}//아이디로 로그인 인증
}
