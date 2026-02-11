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
		String mem_pwd = member.getMem_pwd();
		
		// BCrypt로 암호화
		String mem_password = BCrypt.hashpw(mem_pwd, BCrypt.gensalt(12));
		
		// DTO에 암호화된 비밀번호 다시 저장
		member.setMem_pwd(mem_password);
		
		// DAO 호출 (DB저장)
		this.mdao.insertMember(member);
		
	}//입력받은 회원정보 저장

	@Override
	public MemberDTO idCheck(String mem_id) {
		return this.mdao.idCheck(mem_id);
	}//아이디 중복체크
}
