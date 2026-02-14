package Controller.Member;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

/* 메일 전송 컨트롤러 */
public class MailUtil {
	private static final String fromEmail = "yunhano48@gmail.com";
	private static final String appPassWord = "dzrx xyut siqb ilrl";
	
	public static void sendTempPassword(String toEmail, String tempPwd) throws MessagingException {
		
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		
		Session session = Session.getInstance(props, new Authenticator() {

			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, appPassWord);
			}
		});
		
		Message msg = new MimeMessage(session);
		msg.setFrom(new InternetAddress(fromEmail));
		msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
		msg.setSubject("[CinemaTalk] 임시 비밀번호 안내");
		msg.setText(
			"안녕하세요. \n\n" +
			"요청하신 임시 비밀번호는 아래와 같습니다.\n\n" +
			"임시 비밀번호: " + tempPwd + "\n\n" +
			"로그인 후 비밀번호를 변경해주세요. \n\n" +
			"- CinemaTalk"
		);
		
		Transport.send(msg);
	}
}

