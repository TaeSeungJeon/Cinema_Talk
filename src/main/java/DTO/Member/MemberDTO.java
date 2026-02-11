package DTO.Member;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MemberDTO {
	
	/* 회원관리 중간 데이터 저장빈 클래스 */
	
	private int mem_no; //회원 번호
	private String mem_id; //회원 아이디
	private String mem_pwd; //회원 비밀번호
	private String mem_name; //회원 이름
	private String mem_phone; //회원 전화번호
	private String mem_email; //회원 메일
	private int mem_role; //회원 구분(1:관리자, 2:일반회원)
	private int mem_state; //회원 상태(1:정상, 2:휴먼, 3:탈퇴)
	
}
