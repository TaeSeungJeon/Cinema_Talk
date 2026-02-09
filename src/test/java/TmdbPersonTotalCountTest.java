import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class TmdbPersonTotalCountTest {

    private static final String API_KEY = "14ee13d7ee07798617932afe29b5cbcd";

    public static void main(String[] args) {

        String apiUrl = "https://api.themoviedb.org/3/person/popular"
                + "?api_key=" + API_KEY
                + "&language=ko-KR"
                + "&page=1";

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

                // total_results 값만 뽑기 (라이브러리 없이 단순 처리)
                String key = "\"total_results\":";
                int idx = json.indexOf(key);

                if (idx != -1) {

                    int start = idx + key.length();

                    int endComma = json.indexOf(",", start);
                    int endBrace = json.indexOf("}", start);

                    int end;

                    if (endComma == -1) {
                        end = endBrace;   // 마지막 필드인 경우
                    } else {
                        end = endComma;
                    }

                    String totalResults = json.substring(start, end).trim();

                    System.out.println("\nTMDB 전체 인물 수 규모: " + totalResults);
                }

            } else {
                System.out.println("API 호출 실패. 응답 코드: " + responseCode);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
