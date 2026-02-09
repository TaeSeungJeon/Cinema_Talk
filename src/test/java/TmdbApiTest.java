import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class TmdbApiTest {

    // 여기에 본인 TMDB API 키 입력
    private static final String API_KEY = "14ee13d7ee07798617932afe29b5cbcd";

    public static void main(String[] args) {

        // 예시: TMDB 영화 ID (Fight Club = 550)
        int movieId = 550;

        String apiUrl = "https://api.themoviedb.org/3/movie/" + movieId
                + "?api_key=" + API_KEY
                + "&language=ko-KR";

        try {
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("GET");
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(5000);

            int responseCode = conn.getResponseCode();

            if (responseCode == 200) {
                BufferedReader br = new BufferedReader(
                        new InputStreamReader(conn.getInputStream(), "UTF-8")
                );

                String line;
                StringBuilder response = new StringBuilder();

                while ((line = br.readLine()) != null) {
                    response.append(line);
                }

                br.close();

                // TMDB API 응답(JSON) 출력
                System.out.println(response.toString());

            } else {
                System.out.println("API 호출 실패. 응답 코드: " + responseCode);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
