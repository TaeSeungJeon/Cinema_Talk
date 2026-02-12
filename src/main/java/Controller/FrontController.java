package Controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.StringTokenizer;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class FrontController extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String RequestURI = request.getRequestURI();	// /Middle_Project/*.do 경로를 구함
		System.out.println("RequestURI" + RequestURI);
		String contextPath = request.getContextPath();	// /Middle_Project 컨텍스트 패스경로를 구함
		System.out.println("contextPath =" + contextPath );
		String command = RequestURI.substring(contextPath.length());// 컨텍스트 패스 경로 이후의 /*.do 즉 매핑주소를 구함.
		System.out.println("command" + command);
		// /*.do 접근 시 index.do로 리다이렉트 (주소창도 변경됨)
		if (command.equals("/*.do")) {
			response.sendRedirect(contextPath + "/index.do");
			return;
		}

		ActionForward forward = null;
		Action action = null;

		Properties prop = new Properties();// 컬렉션 클래스로 키,값 쌍으로 저장하는 자료구조
		
		FileInputStream fis = new FileInputStream(
				request.getSession().getServletContext().getRealPath("WEB-INF/classes/daum.properties"));
		// 프로퍼티 파일을 읽어들임.=>톰캣 WAS서버에 의해서 변경된 실제 톰캣프로젝트 경로의 해당파일을 읽어들임.
		/*D:\20251201_java\Java_WorkSpace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\
	      wtpwebapps\Middle_Project\WEB-INF\classes */

		prop.load(fis);// 프로퍼티 파일 로드
		fis.close();// 입력 스트림 닫는다.

		String value = prop.getProperty(command);// 키이름 매핑주소에 해당하는 값을 가져옴.

		if (value.substring(0, 7).equals("execute")) {
			// 0이상 7미만 사이의 문자가 execute와 같다면

			try {
				StringTokenizer st = new StringTokenizer(value, "|");// |를 기준으로 문자를 분리함.
				String url_1 = st.nextToken();// 분리된 토큰 문자열 execute를 저장
				String url_2 = st.nextToken();// 풀패키지명.컨트롤러 클래스명
				Class url = Class.forName(url_2);// 풀패키지경로의 컨트롤러 클래스를 객체화

				action = (Action) url.newInstance();// 새로운 인스턴스로 다운캐스팅 해서 액션 생성

				try {
					forward = action.execute(request, response);// 오버라이딩 된 컨트롤러 클래스의 해당 메서드를 호출하여 액션포워드 생성
				} catch (Exception e) {
					e.printStackTrace();
				}
			} catch (ClassNotFoundException ex) {// 해당 클래스 파일을 못찾는 경우 발생하는 예외 에러를 처리
				ex.printStackTrace();
			} catch (InstantiationException ex) {// 추상클래스나 인터페이스를 인스턴스화 하고자 할때
				ex.printStackTrace();
			} catch (IllegalAccessException ex) {// 클래스 접근을 못함.-> 클래스 필드(멤버변수,속성), 생성자, 메서드 등에 접근권한이 없을 경우 예외처리
				ex.printStackTrace();
			}
		} // if

		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);
			}
		}
	}
}
