package Service.Member;

import java.io.InputStream;

/**
 * 프로필 사진 업로드/삭제 서비스 인터페이스.
 */
public interface ProfilePhotoService {

	/**
	 * 프로필 사진 업로드.
	 *
	 * @param memNo       회원번호
	 * @param inputStream 업로드된 파일의 InputStream
	 * @param contentType 파일의 Content-Type
	 * @param fileSize    파일 크기 (bytes)
	 * @throws Exception  검증 실패 또는 처리 오류
	 */
	void updateMemberProfilePhoto(int memNo, InputStream inputStream, String contentType, long fileSize)
			throws Exception;

	/**
	 * 프로필 사진 삭제 (기본 아바타로 복원).
	 *
	 * @param memNo 회원번호
	 * @throws Exception 삭제 오류
	 */
	void deleteMemberProfilePhoto(int memNo) throws Exception;

}