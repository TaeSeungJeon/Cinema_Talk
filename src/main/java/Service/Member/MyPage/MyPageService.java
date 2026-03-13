package Service.Member.MyPage;

import java.util.List;

import DTO.Member.MemberDTO;
import DTO.Member.MyPage.MyPageDTO;
import DTO.Movie.GenreDTO;

public interface MyPageService {
	
	MyPageDTO getMyPageInfo(int memNo);

	void updateMemberInfo(MemberDTO mdto);
	
	// 전체 장르 목록 조회
	List<GenreDTO> getAllGenres();
	
	// 선호 장르 저장 (기존 삭제 후 새로 저장)
	void savePreferredGenres(int memNo, List<Integer> genreIds);
}