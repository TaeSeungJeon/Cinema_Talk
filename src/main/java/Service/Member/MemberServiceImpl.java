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
		this.mdao.insertMember(member);
	}//입력받은 회원정보 저장(회원가입)

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

	@Override
	public int phoneCheck(String memPhone) {
		return mdao.phoneCheck(memPhone);
	}//전화번호 중복 체크

	@Override
	public int emailCheck(String memEmail) {
		return mdao.emailCheck(memEmail);
	}//이메일 중복 체크

	@Override
	public int withdrawMember(int memNo) {
		return mdao.withdrawMember(memNo);
	}//회원 탈퇴 (상태값 3으로 변경)
	
	public int updateLastLogin(String memId) {
		return mdao.updateLastLogin(memId);
	}//마지막 로그인 날짜 업데이트

}


