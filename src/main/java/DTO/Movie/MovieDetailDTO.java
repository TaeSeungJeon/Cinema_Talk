package DTO.Movie;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MovieDetailDTO {
	// 영화 상세 정보
	private MovieDTO movie;
    
	// 장르 목록
	private List<GenreDTO> genres;
	
    // 배우 목록 (캐릭터명 포함)
    private List<CastInfoDTO> casts;
    
    // 감독 목록
    private List<CrewInfoDTO> directors;
    
    // 배우 정보 내부 클래스 (인물 + 배역)
    @Setter
    @Getter
    public static class CastInfoDTO {
        private int person_id;
        private String person_name;
        private String profile_path;
        private String character_name;
        private int cast_order;
    }
    
    // 감독 정보 내부 클래스 (인물 + 직책)
    @Setter
    @Getter
    public static class CrewInfoDTO {
        private int person_id;
        private String person_name;
        private String profile_path;
        private String crew_job;
    }
}