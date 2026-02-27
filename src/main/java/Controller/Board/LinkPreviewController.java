package Controller.Board;

import Controller.Action;
import Controller.ActionForward;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.URI;
import java.net.URL;

public class LinkPreviewController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String urlParam = request.getParameter("url");
        JSONObject result = new JSONObject();

        try {
            if (urlParam == null || urlParam.isBlank()) {
                result.put("ok", false);
                result.put("message", "url 파라미터가 없습니다.");
                out.println(result.toString());
                out.flush();
                return null;
            }

            String normalized = normalizeUrl(urlParam.trim());
            validateUrl(normalized);

            Connection conn = Jsoup.connect(normalized)
                    .userAgent("Mozilla/5.0 (compatible; CinemaTalkBot/1.0)")
                    .timeout(5000)
                    .followRedirects(true)
                    .ignoreHttpErrors(true);

            Document doc = conn.get();

            String title = pickMeta(doc, "meta[property=og:title]", "content");
            if (isBlank(title)) title = doc.title();

            String description = pickMeta(doc, "meta[property=og:description]", "content");
            if (isBlank(description)) description = pickMeta(doc, "meta[name=description]", "content");

            String image = pickMeta(doc, "meta[property=og:image]", "content");
            String siteName = pickMeta(doc, "meta[property=og:site_name]", "content");

            image = resolveUrl(normalized, image);

            result.put("ok", true);
            result.put("url", normalized);
            result.put("title", safe(title));
            result.put("description", safe(description));
            result.put("image", safe(image));
            result.put("siteName", safe(siteName));

        } catch (Exception e) {
            result.put("ok", false);
            result.put("message", "링크 미리보기 실패");
        }

        out.println(result.toString());
        out.flush();
        return null;
    }

    private String pickMeta(Document doc, String cssQuery, String attr) {
        Element el = doc.selectFirst(cssQuery);
        return el == null ? "" : el.attr(attr);
    }

    private String normalizeUrl(String input) {
        if (input.startsWith("http://") || input.startsWith("https://")) return input;
        return "https://" + input;
    }

    private void validateUrl(String url) throws Exception {
        URI uri = new URI(url);
        String scheme = uri.getScheme();
        if (!"http".equalsIgnoreCase(scheme) && !"https".equalsIgnoreCase(scheme)) {
            throw new IllegalArgumentException("http/https만 허용");
        }

        String host = uri.getHost();
        if (host == null || host.isBlank()) throw new IllegalArgumentException("host 없음");

        InetAddress addr = InetAddress.getByName(host);
        if (addr.isAnyLocalAddress() || addr.isLoopbackAddress() || addr.isSiteLocalAddress()) {
            throw new IllegalArgumentException("로컬/사설망 접근 차단");
        }
    }

    private String resolveUrl(String base, String maybeRelative) {
        if (isBlank(maybeRelative)) return "";
        try {
            URL baseUrl = new URL(base);
            URL resolved = new URL(baseUrl, maybeRelative);
            return resolved.toString();
        } catch (Exception e) {
            return maybeRelative;
        }
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private String safe(String s) {
        return s == null ? "" : s;
    }
}