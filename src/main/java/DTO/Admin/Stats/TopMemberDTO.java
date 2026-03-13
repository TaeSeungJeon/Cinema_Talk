package DTO.Admin.Stats;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TopMemberDTO {
	private int memNo;
    private String memId;
    private String memName;
    private String memEmail;
    private int memState;  //회원 상태(1:정상, 2:휴먼, 3:탈퇴)
    private String memProfilePhoto;
    private LocalDate memDate; //회원 가입날짜
    private LocalDate memLastLogin; //마지막 로그인 날짜
    
    private int boardCount;
    private int commentCount;
    private int totalScore;
}
