import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class TmdbGenreCountTest {

    private static final String API_KEY = "14ee13d7ee07798617932afe29b5cbcd";

    public static void main(String[] args) {

        String apiUrl = "https://api.themoviedb.org/3/genre/movie/list"
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

                String json = response.toString();

                System.out.println("원본 JSON:");
                System.out.println(json);

                // 단순하게 genres 배열 개수 세기 (파싱 라이브러리 없이)
                int count = json.split("\"id\"").length - 1;

                System.out.println("\n전체 장르 개수: " + count);

            } else {
                System.out.println("API 호출 실패. 응답 코드: " + responseCode);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
