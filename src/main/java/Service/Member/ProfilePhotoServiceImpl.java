package Service.Member;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import DAO.Member.MemberDAO;
import DAO.Member.MemberDAOImpl;
import Service.AppConfig;
import Service.ImageUtil;

/**
 * 프로필 사진 업로드/삭제 서비스 구현체.
 *
 * <h3>업로드 흐름 (원자성 보장)</h3>
 * <ol>
 *   <li>검증: MIME whitelist, magic-bytes, 파일 크기</li>
 *   <li>임시 저장: external-dir/tmp/{uuid}</li>
 *   <li>대상 경로 계산: members/{memNo}/{yyyyMMdd}/{yyyyMMdd}-{uuid}.{ext}</li>
 *   <li>파일 이동 (atomic move)</li>
 *   <li>DB 트랜잭션: updateProfilePhotoPath</li>
 *   <li>DB 커밋 성공 → 이전 파일 삭제</li>
 *   <li>DB 실패 → 새 파일 삭제(보상)</li>
 *   <li>파일 이동 실패 → DB 변경 없음, 임시 파일 삭제</li>
 * </ol>
 *
 * <h3>Concurrency</h3>
 * per-member 동기화(메모리 락 맵)로 동시 요청 직렬화.
 */
public class ProfilePhotoServiceImpl implements ProfilePhotoService {

	private static ProfilePhotoServiceImpl instance;

	private MemberDAO memberDAO = MemberDAOImpl.getInstance();

	// per-member 동기화용 락 맵
	private final ConcurrentHashMap<Integer, Object> lockMap = new ConcurrentHashMap<>();

	public ProfilePhotoServiceImpl() {}

	public static synchronized ProfilePhotoServiceImpl getInstance() {
		if (instance == null) {
			instance = new ProfilePhotoServiceImpl();
		}
		return instance;
	}

	private Object getLock(int memNo) {
		return lockMap.computeIfAbsent(memNo, k -> new Object());
	}

	@Override
	public void updateMemberProfilePhoto(int memNo, InputStream inputStream, String contentType, long fileSize)
			throws Exception {

		AppConfig config = AppConfig.getInstance();
		String allowedTypes = config.get("profile.photo.allowed-types", "image/jpeg,image/png,image/gif");
		long maxBytes = config.getLong("profile.photo.max-bytes", 5242880L);
		String externalDir = config.get("profile.photo.external-dir", "C:/dev/cinema_talk/profile_photos/");
		int thumbWidth = config.getInt("profile.photo.thumbnail-width", 150);
		int thumbHeight = config.getInt("profile.photo.thumbnail-height", 150);

		// 1. MIME 타입 검증
		if (!ImageUtil.isAllowedMimeType(contentType, allowedTypes)) {
			throw new Exception("허용되지 않는 파일 형식입니다. (허용: " + allowedTypes + ")");
		}

		// 2. 파일 크기 검증
		if (!ImageUtil.isWithinSizeLimit(fileSize, maxBytes)) {
			throw new Exception("파일 크기가 제한을 초과했습니다. (최대: " + (maxBytes / 1024 / 1024) + "MB)");
		}

		// 3. 파일 데이터 읽기
		byte[] fileData;
		try {
			fileData = inputStream.readAllBytes();
		} catch (IOException e) {
			throw new Exception("파일 읽기에 실패했습니다.", e);
		}

		// 4. Magic-bytes 검증
		if (!ImageUtil.isValidImageMagicBytes(fileData)) {
			throw new Exception("유효하지 않은 이미지 파일입니다.");
		}

		// per-member 동기화
		synchronized (getLock(memNo)) {
			Path baseDir = Paths.get(externalDir);
			Path tmpDir = baseDir.resolve("tmp");
			Files.createDirectories(tmpDir);

			String uuid = UUID.randomUUID().toString().replace("-", "");
			String ext = ImageUtil.extensionFromContentType(contentType);
			String tmpFileName = uuid + "." + ext;
			Path tmpFile = tmpDir.resolve(tmpFileName);

			// 5. 임시 저장
			try {
				Files.write(tmpFile, fileData);
			} catch (IOException e) {
				throw new Exception("임시 파일 저장에 실패했습니다.", e);
			}

			// 6. 대상 경로 계산: members/{memNo}/{yyyyMMdd}/{yyyyMMdd}-{uuid}.{ext}
			String dateStr = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
			String targetFileName = dateStr + "-" + uuid + "." + ext;
			String relativePath = "members/" + memNo + "/" + dateStr + "/" + targetFileName;
			Path targetPath = baseDir.resolve(relativePath);

			// 7. 파일 이동 (atomic move 시도, 실패 시 copy + delete)
			try {
				Files.createDirectories(targetPath.getParent());
				try {
					Files.move(tmpFile, targetPath, StandardCopyOption.ATOMIC_MOVE);
				} catch (IOException e) {
					Files.copy(tmpFile, targetPath, StandardCopyOption.REPLACE_EXISTING);
					Files.deleteIfExists(tmpFile);
				}
			} catch (IOException e) {
				deleteQuietly(tmpFile);
				throw new Exception("파일 이동에 실패했습니다.", e);
			}

			// 8. 이전 프로필 경로 조회
			String oldPath = memberDAO.findProfilePhotoPath(memNo);

			// 9. DB 트랜잭션: 프로필 경로 업데이트
			try {
				int result = memberDAO.updateProfilePhotoPath(memNo, relativePath);
				if (result <= 0) {
					deleteQuietly(targetPath);
					throw new Exception("프로필 사진 DB 업데이트에 실패했습니다.");
				}
			} catch (Exception e) {
				deleteQuietly(targetPath);
				if (e.getMessage() != null && e.getMessage().contains("DB")) {
					throw e;
				}
				throw new Exception("프로필 사진 DB 업데이트 중 오류 발생.", e);
			}

			// 10. 썸네일 생성: members/{memNo}/{yyyyMMdd}/thumb-{targetFileName}
			try {
				String thumbRelative = "members/" + memNo + "/" + dateStr + "/thumb-" + targetFileName;
				Path thumbPath = baseDir.resolve(thumbRelative);
				ImageUtil.createThumbnail(targetPath, thumbPath, thumbWidth, thumbHeight);
			} catch (IOException e) {
				System.out.println("⚠️ 썸네일 생성 실패 (memNo=" + memNo + "): " + e.getMessage());
			}

			// 11. DB 커밋 성공 → 이전 파일 삭제
			if (oldPath != null && !oldPath.isBlank()) {
				Path oldFile = baseDir.resolve(oldPath);
				if (!deleteQuietly(oldFile)) {
					System.out.println("⚠️ 이전 프로필 사진 삭제 실패 (cleanup 필요): " + oldFile);
				}
				String oldDir = oldPath.substring(0, oldPath.lastIndexOf('/') + 1);
				String oldFileName = oldPath.substring(oldPath.lastIndexOf('/') + 1);
				Path oldThumb = baseDir.resolve(oldDir + "thumb-" + oldFileName);
				deleteQuietly(oldThumb);
			}
		}
	}//updateMemberProfilePhoto() -> 프로필 사진 업로드

	@Override
	public void deleteMemberProfilePhoto(int memNo) throws Exception {
		AppConfig config = AppConfig.getInstance();
		String externalDir = config.get("profile.photo.external-dir", "C:/dev/cinema_talk/profile_photos/");

		synchronized (getLock(memNo)) {
			String oldPath = memberDAO.findProfilePhotoPath(memNo);

			int result = memberDAO.updateProfilePhotoPath(memNo, null);
			if (result <= 0) {
				throw new Exception("프로필 사진 삭제(DB)에 실패했습니다.");
			}

			if (oldPath != null && !oldPath.isBlank()) {
				Path baseDir = Paths.get(externalDir);
				Path oldFile = baseDir.resolve(oldPath);
				if (!deleteQuietly(oldFile)) {
					System.out.println("⚠️ 프로필 사진 파일 삭제 실패 (cleanup 필요): " + oldFile);
				}
				String dir = oldPath.substring(0, oldPath.lastIndexOf('/') + 1);
				String fileName = oldPath.substring(oldPath.lastIndexOf('/') + 1);
				Path thumbFile = baseDir.resolve(dir + "thumb-" + fileName);
				deleteQuietly(thumbFile);
			}
		}
	}//deleteMemberProfilePhoto() -> 프로필 사진 삭제

	private boolean deleteQuietly(Path path) {
		try {
			return Files.deleteIfExists(path);
		} catch (IOException e) {
			System.out.println("⚠️ 파일 삭제 실패: " + path + " - " + e.getMessage());
			return false;
		}
	}

}
