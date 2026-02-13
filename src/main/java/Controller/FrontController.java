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
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());

		if (command.equals("/*.do")) {
			response.sendRedirect(contextPath + "/index.do");
			return;
		}

		ActionForward forward = null;
		Action action = null;

		Properties prop = new Properties();

		try {
			FileInputStream fis = new FileInputStream(
					request.getSession().getServletContext().getRealPath("WEB-INF/classes/daum.properties"));

			prop.load(fis);
			fis.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		String value = prop.getProperty(command);

			if (value.substring(0, 7).equals("execute")) {
			try {
				StringTokenizer st = new StringTokenizer(value, "|");
				String url_1 = st.nextToken();
				String url_2 = st.nextToken();

				// [수정 포인트] 최신 자바 방식의 인스턴스 생성
				Class<?> url = Class.forName(url_2);
				action = (Action) url.getDeclaredConstructor().newInstance();

				forward = action.execute(request, response);

			} catch (ClassNotFoundException ex) {
				System.out.println("클래스를 찾을 수 없습니다: " + ex.getMessage());
				ex.printStackTrace();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

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