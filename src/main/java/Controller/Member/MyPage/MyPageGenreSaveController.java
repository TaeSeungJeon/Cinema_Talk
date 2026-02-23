package Controller.Member.MyPage;

import java.io.BufferedReader;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import Service.Member.MyPage.MyPageService;
import Service.Member.MyPage.MyPageServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class MyPageGenreSaveController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession(false);

		// 세션 체크
		if (session == null || session.getAttribute("memId") == null) {
			ActionForward forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("memberLogin.do");
			return forward;
		}

		String memId = (String) session.getAttribute("memId");
		MemberService memberService = new MemberServiceImpl();
		MemberDTO member = memberService.loginCheck(memId);

		if (member == null) {
			session.invalidate();
			ActionForward forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("memberLogin.do");
			return forward;
		}

		int memNo = member.getMemNo();

		List<Integer> genreIds = new ArrayList<>();

		// fetch()로 전송한 application/x-www-form-urlencoded 바디가 서블릿 컨테이너에 의해
		// 아직 파싱되지 않는 경우를 대비해 바디를 직접 파싱하는 폴백을 제공
		StringBuilder sb = new StringBuilder();
		BufferedReader reader = request.getReader();
		String line;
		while ((line = reader.readLine()) != null) {
			sb.append(line);
		}
		String body = sb.toString();
		// body 형식: genreIds=1&genreIds=2 ...
		String[] pairs = body.split("&");
		for (String pair : pairs) {
			int idx = pair.indexOf('=');
			if (idx > -1) {
				String key = URLDecoder.decode(pair.substring(0, idx), StandardCharsets.UTF_8.name());
				String value = URLDecoder.decode(pair.substring(idx + 1), StandardCharsets.UTF_8.name());
				if ("genreIds".equals(key) && value != null && !value.isBlank()) {
					try {
						genreIds.add(Integer.parseInt(value));
					} catch (NumberFormatException ex) {
						// ignore invalid
					}
				}
			}
		}

		// 선호 장르 저장
		MyPageService myPageService = new MyPageServiceImpl();
		myPageService.savePreferredGenres(memNo, genreIds);

		// AJAX 요청인 경우 텍스트 응답
		PrintWriter out = response.getWriter();
		out.print("OK");
		out.flush();

		return null;
	}
}