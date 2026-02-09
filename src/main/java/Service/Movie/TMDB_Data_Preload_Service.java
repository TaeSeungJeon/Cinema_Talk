package Service.Movie;

import java.util.List;

import DTO.Movie.GenreDTO;

public interface TMDB_Data_Preload_Service {
	final String API_KEY = "14ee13d7ee07798617932afe29b5cbcd";
	final String BASE_URL = "https://api.themoviedb.org/3";
	
	void preloadTMDBData();
}
