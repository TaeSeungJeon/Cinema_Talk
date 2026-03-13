package Controller.Admin;

import java.io.PrintWriter;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import Controller.Action;
import Controller.ActionForward;
import DTO.Movie.PersonDTO;
import Service.Movie.PersonService;
import Service.Movie.PersonServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminPersonSearchController implements Action {

	PersonService personService = new PersonServiceImpl();
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 1️⃣ 검색어 받기
        String keyword = request.getParameter("keyword");

        if (keyword == null || keyword.trim().isEmpty()) {
            return null; // 검색어 없으면 아무것도 안함
        }

        // 2️⃣ 서비스 호출
        List<PersonDTO> personList = personService.searchPerson(keyword);

        // 3️⃣ JSON 배열 생성
        JSONArray jsonArray = new JSONArray();

        for (PersonDTO person : personList) {
            JSONObject obj = new JSONObject();
            obj.put("personId", person.getPersonId());
            obj.put("personName", person.getPersonName());
            obj.put("profilePath", person.getProfilePath());

            jsonArray.put(obj);
        }

        // 4️⃣ JSON 응답 설정
        response.setContentType("application/json; charset=UTF-8");

        PrintWriter out = response.getWriter();
        out.print(jsonArray.toString());
        out.flush();

        // 5️⃣ 페이지 이동 없음
        return null;
    }
}
