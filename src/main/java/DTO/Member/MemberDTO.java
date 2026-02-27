package DTO.Member;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MemberDTO {
	
	/* 회원관리 중간 데이터 저장빈 클래스 */
	
	private int memNo; //회원 번호
	private String memId; //회원 아이디
	private String memPwd; //회원 비밀번호
	private String memName; //회원 이름
	private String memPhone; //회원 전화번호
	private String memEmail; //회원 메일
	private int memRole; //회원 구분(1:관리자, 2:일반회원)
	private int memState; //회원 상태(1:정상, 2:휴먼, 3:탈퇴)
	private String memDate; //회원 가입날짜
	private String memProfilePhoto; //프로필 사진 상대 경로 (예: members/123/20260226/20260226-uuid.jpg)
	
	private Date memLastLogin; //마지막 로그인 날짜
}
