package Controller.Member;

import java.io.PrintWriter;

import Controller.Action;
import Controller.ActionForward;
import DTO.Member.MemberDTO;
import Service.Member.MemberService;
import Service.Member.MemberServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//전화번호 중복체크 컨트롤러
public class PhoneCheckController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		response.setContentType("application/json;charset=utf-8");
        PrintWriter out = response.getWriter();

        MemberService memService = new MemberServiceImpl();

        // JS에서 data: { memPhone: memPhone} 로 보내니까
        String memPhone = request.getParameter("memPhone");
        memPhone = (memPhone == null) ? "" : memPhone.trim();

//        // 전화번호 입력 안 했으면
//        if(memPhone.isEmpty()) {
//            out.println("{\"available\":false,\"msg\":\"전화번호를 입력하세요.\"}");
//            out.flush();
//            return null;
//        }

        // DB에 있으면 중복 (DTO가 있으면 중복)
        MemberDTO db_phone = memService.phoneCheck(memPhone);

        boolean available = (db_phone == null);

        String msg = available ? "사용 가능한 전화번호입니다." : "이미 가입된 전화번호입니다.";

        String json = "{\"available\":" + available + ",\"msg\":\"" + msg + "\"}";

        out.println(json);
        out.flush();

        return null;
	}

}
