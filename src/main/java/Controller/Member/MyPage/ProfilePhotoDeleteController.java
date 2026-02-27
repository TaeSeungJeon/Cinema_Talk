package Controller.Member.MyPage;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import DTO.Member.MyPage.MyPageDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import Service.Member.ProfilePhotoService;
import Service.Member.ProfilePhotoServiceImpl;
import Service.Member.MyPage.MyPageService;
import Service.Member.MyPage.MyPageServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * 프로필 사진 삭제(기본 아바타로 복원) 컨트롤러.
 */
public class ProfilePhotoDeleteController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("memNo") == null) {
			forward.setRedirect(true);
			forward.setPath("memberLogin.do");
			return forward;
		}

		int memNo = (int) session.getAttribute("memNo");
		ProfilePhotoService photoService = new ProfilePhotoServiceImpl();
		MemberService memberService = new MemberServiceImpl();
		MyPageService myPageService = new MyPageServiceImpl();

		try {
			photoService.deleteMemberProfilePhoto(memNo);
			request.setAttribute("profileMsg", "프로필 사진이 삭제되었습니다.");
		} catch (Exception e) {
			request.setAttribute("profileError", e.getMessage());
			e.printStackTrace();
		}

		// 마이페이지 정보 재조회
		MemberDTO member = memberService.getMemberInfo(memNo);
		MyPageDTO myPageInfo = myPageService.getMyPageInfo(memNo);
		myPageInfo.setMemId(member.getMemId());
		myPageInfo.setMemName(member.getMemName());
		myPageInfo.setMemDate(member.getMemDate());

		request.setAttribute("member", member);
		request.setAttribute("myPageInfo", myPageInfo);
		request.setAttribute("allGenreList", myPageService.getAllGenres());

		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/member/mypage/myPage.jsp");
		return forward;
	}
}