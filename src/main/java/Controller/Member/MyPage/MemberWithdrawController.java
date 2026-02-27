package Controller.Member.MyPage;

import java.io.PrintWriter;

import org.mindrot.jbcrypt.BCrypt;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/* 회원 탈퇴 처리 컨트롤러 */
public class MemberWithdrawController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		HttpSession session = request.getSession();
		Integer memNo = (Integer) session.getAttribute("memNo");

		// 로그인 상태가 아닌 경우
		if (memNo == null) {
			out.println("<script>");
			out.println("alert('로그인이 필요합니다.');");
			out.println("location.href='memberLogin.do';");
			out.println("</script>");
			return null;
		}

		String inputPwd = request.getParameter("withdrawPwd");

		// 비밀번호가 비어있는 경우
		if (inputPwd == null || inputPwd.trim().isEmpty()) {
			out.println("<script>");
			out.println("alert('비밀번호를 입력해주세요.');");
			out.println("history.back();");
			out.println("</script>");
			return null;
		}

		// DB에서 현재 회원 정보 조회
		MemberService service = new MemberServiceImpl();
		MemberDTO member = service.getMemberInfo(memNo);

		// 비밀번호 검증
		if (member == null || !BCrypt.checkpw(inputPwd, member.getMemPwd())) {
			out.println("<script>");
			out.println("alert('비밀번호가 일치하지 않습니다.');");
			out.println("history.back();");
			out.println("</script>");
			return null;
		}

		// 회원 상태를 3(탈퇴)으로 변경
		int result = service.withdrawMember(memNo);

		if (result > 0) {
			// 세션 만료 (로그아웃)
			session.invalidate();

			out.println("<script>");
			out.println("alert('회원 탈퇴가 완료되었습니다. 그동안 이용해주셔서 감사합니다.');");
			out.println("location.href='index.do';");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('회원 탈퇴 처리 중 오류가 발생했습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}

		return null;
	}

}
