package Service.Member;

import java.util.Random;

import org.mindrot.jbcrypt.BCrypt;

import Controller.Member.MailUtil;
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

	@Override
	public MemberDTO getMemberInfo(Integer memNo) {
		return this.mdao.getMemberInfo(memNo);
	}

	@Override
	public MemberDTO findId(MemberDTO mdto) {
		return this.mdao.findId(mdto);
	}//이름과 전화번호를 기준으로 회원 검색

	@Override
	public MemberDTO findByIdAndPhone(String memId, String memPhone) {
		return this.mdao.findByIdAndPhone(memId, memPhone);
	}//아이디와 전화번호를 기준으로 회원 검색

	@Override
	public boolean resetPwdSendEmail(MemberDTO mdto) {
		try {
		//임시 비밀번호 생성
		String tempPwd = makeTempPwd(10);
		
		//BCrypt로 암호화
		String encPwd = BCrypt.hashpw(tempPwd, BCrypt.gensalt());
		
		//DB에 암호화된 임시비번 저장
		mdto.setMemPwd(encPwd);
		
		int result = mdao.updatePwd(mdto);
		if(result <= 0) return false;
		
		//이메일 전송
		MailUtil.sendTempPassword(mdto.getMemEmail(), tempPwd);
		
		return true;
		
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}//임시 비밀번호로 재설정, 메일 전송
	}
	
	private String makeTempPwd(int len) {
		String chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789";
		StringBuilder sb = new StringBuilder();
		Random r = new Random();
	
		for(int i=0; i<len; i++){
		sb.append(chars.charAt(r.nextInt(chars.length())));
		}
		return sb.toString();
	}//임시비밀번호 생성 메서드

}


