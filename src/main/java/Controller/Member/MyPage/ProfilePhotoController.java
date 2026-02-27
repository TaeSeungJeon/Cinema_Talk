package Controller.Member.MyPage;

import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import Controller.Action;
import Controller.ActionForward;
import Service.AppConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ProfilePhotoController implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String externalDir = AppConfig.getInstance()
				.get("profile.photo.external-dir", "C:/dev/cinema_talk/profile_photos/");

		String relativePath = request.getParameter("path");

		// 파라미터 없으면 404
		if (relativePath == null || relativePath.isBlank()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}

		Path filePath = Paths.get(externalDir).resolve(relativePath).normalize();

		if (!Files.exists(filePath) || !Files.isRegularFile(filePath)) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}

		// Content-Type 결정
		String contentType = Files.probeContentType(filePath);
		if (contentType == null) {
			contentType = "application/octet-stream";
		}

		response.setContentType(contentType);
		response.setContentLengthLong(Files.size(filePath));
		response.setHeader("Cache-Control", "public, max-age=3600");

		try (OutputStream out = response.getOutputStream()) {
			Files.copy(filePath, out);
		}

		// 직접 바이너리 응답했으므로 forward 불필요
		return null;
	}
}
