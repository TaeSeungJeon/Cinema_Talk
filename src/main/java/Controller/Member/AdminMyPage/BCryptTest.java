package Controller.Member.AdminMyPage;

import org.mindrot.jbcrypt.BCrypt;

public class BCryptTest {
	    public static void main(String[] args) {

	        String password = "dkfktl1415"; // 관리자 로그인할 때 쓸 비밀번호
	        String hash = BCrypt.hashpw(password, BCrypt.gensalt());

	        System.out.println("해시값:");
	        System.out.println(hash);
	}
}
