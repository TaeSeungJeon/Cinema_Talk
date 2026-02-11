package DTO.Vote;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VoteOptionDTO {

	private int vote_id;
	private int movie_id;

	//선택지 매핑
	private String movie_title;
	private String movie_release_date;
	private String movie_poster_path;
	

}
