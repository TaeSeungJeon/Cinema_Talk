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
import jakarta.servlet.http.Part;

/**
 * 프로필 사진 업로드 처리 컨트롤러.
 * multipart/form-data로 전송된 profilePhoto 파일을 처리한다.
 */
public class ProfilePhotoUploadController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession(false);

		// 세션 체크
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
			// multipart에서 파일 파트 추출
			Part filePart = request.getPart("profilePhoto");

			if (filePart != null && filePart.getSize() > 0) {
				String contentType = filePart.getContentType();
				long fileSize = filePart.getSize();

				photoService.updateMemberProfilePhoto(
						memNo,
						filePart.getInputStream(),
						contentType,
						fileSize
				);

				request.setAttribute("profileMsg", "프로필 사진이 업데이트되었습니다.");
			} else {
				request.setAttribute("profileMsg", "파일을 선택해주세요.");
			}
		} catch (Exception e) {
			request.setAttribute("profileError", e.getMessage());
			e.printStackTrace();
		}

		// 마이페이지 정보 재조회하여 뷰에 전달
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