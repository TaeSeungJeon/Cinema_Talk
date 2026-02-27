package Service;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.List;

import net.coobird.thumbnailator.Thumbnails;

/**
 * 이미지 검증 및 썸네일 유틸리티.
 * <ul>
 *   <li>MIME whitelist 검증</li>
 *   <li>Magic-bytes 검증</li>
 *   <li>파일 크기 검증</li>
 *   <li>썸네일 생성 (Thumbnailator)</li>
 * </ul>
 */
public class ImageUtil {

	// magic-bytes 시그니처 목록
	private static final byte[] JPEG_MAGIC = new byte[]{(byte) 0xFF, (byte) 0xD8, (byte) 0xFF};
	private static final byte[] PNG_MAGIC  = new byte[]{(byte) 0x89, 0x50, 0x4E, 0x47};
	private static final byte[] GIF87_MAGIC = "GIF87a".getBytes();
	private static final byte[] GIF89_MAGIC = "GIF89a".getBytes();

	private ImageUtil() {}

	/**
	 * MIME 타입이 허용 목록에 포함되는지 검증.
	 * @param contentType 업로드 파일의 Content-Type
	 * @param allowedTypes 쉼표 구분 허용 타입 (예: "image/jpeg,image/png,image/gif")
	 * @return 허용이면 true
	 */
	public static boolean isAllowedMimeType(String contentType, String allowedTypes) {
		if (contentType == null || allowedTypes == null) return false;
		List<String> allowed = Arrays.asList(allowedTypes.split(","));
		return allowed.stream()
				.map(String::trim)
				.anyMatch(t -> t.equalsIgnoreCase(contentType.trim()));
	}

	/**
	 * 파일 크기가 제한 이내인지 검증.
	 */
	public static boolean isWithinSizeLimit(long fileSize, long maxBytes) {
		return fileSize > 0 && fileSize <= maxBytes;
	}

	/**
	 * 파일 바이트 배열에서 magic-bytes로 실제 이미지인지 검증.
	 * @param data 파일 데이터 (최소 앞 8바이트)
	 * @return 유효한 이미지 시그니처이면 true
	 */
	public static boolean isValidImageMagicBytes(byte[] data) {
		if (data == null || data.length < 4) return false;
		if (startsWith(data, JPEG_MAGIC)) return true;
		if (startsWith(data, PNG_MAGIC)) return true;
		if (data.length >= 6 && (startsWith(data, GIF87_MAGIC) || startsWith(data, GIF89_MAGIC))) return true;
		return false;
	}

	private static boolean startsWith(byte[] data, byte[] prefix) {
		if (data.length < prefix.length) return false;
		for (int i = 0; i < prefix.length; i++) {
			if (data[i] != prefix[i]) return false;
		}
		return true;
	}

	/**
	 * 파일 확장자 추출. content-type 기반.
	 */
	public static String extensionFromContentType(String contentType) {
		if (contentType == null) return "bin";
		return switch (contentType.toLowerCase().trim()) {
			case "image/jpeg" -> "jpg";
			case "image/png" -> "png";
			case "image/gif" -> "gif";
			default -> "bin";
		};
	}

	/**
	 * 썸네일 생성. 원본 파일에서 지정 크기로 리사이즈하여 대상 경로에 저장.
	 * @param sourcePath 원본 이미지 경로
	 * @param destPath   썸네일 저장 경로
	 * @param width      썸네일 너비
	 * @param height     썸네일 높이
	 */
	public static void createThumbnail(Path sourcePath, Path destPath, int width, int height) throws IOException {
		Files.createDirectories(destPath.getParent());
		Thumbnails.of(sourcePath.toFile())
				.size(width, height)
				.keepAspectRatio(true)
				.toFile(destPath.toFile());
	}
	
	/**
	 * 바이트 배열에서 썸네일 생성.
	 */
	public static void createThumbnail(byte[] imageData, Path destPath, int width, int height) throws IOException {
		Files.createDirectories(destPath.getParent());
		try (InputStream is = new ByteArrayInputStream(imageData)) {
			Thumbnails.of(is)
					.size(width, height)
					.keepAspectRatio(true)
					.toFile(destPath.toFile());
		}
	}
}
