package Service;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

/**
 * application.xml에서 설정값을 읽어오는 싱글턴 설정 로더.
 */
public class AppConfig {

	private static AppConfig instance;
	private final Map<String, String> properties = new HashMap<>();

	private AppConfig() {
		loadConfig();
	}

	public static synchronized AppConfig getInstance() {
		if (instance == null) {
			instance = new AppConfig();
		}
		return instance;
	}

	private void loadConfig() {
		try (InputStream is = getClass().getClassLoader().getResourceAsStream("application.xml")) {
			if (is == null) {
				System.out.println("application.xml not found on classpath");
				return;
			}
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = builder.parse(is);
			doc.getDocumentElement().normalize();

			NodeList nodeList = doc.getElementsByTagName("property");
			for (int i = 0; i < nodeList.getLength(); i++) {
				Element el = (Element) nodeList.item(i);
				String name = el.getAttribute("name");
				String value = el.getAttribute("value");
				if (name != null && !name.isBlank()) {
					properties.put(name, value);
				}
			}
			System.out.println("application.xml 설정 로드 완료: " + properties.size() + "개 항목");
		} catch (Exception e) {
			System.out.println("application.xml 로드 실패");
			e.printStackTrace();
		}
	}

	public String get(String key) {
		return properties.get(key);
	}

	public String get(String key, String defaultValue) {
		return properties.getOrDefault(key, defaultValue);
	}

	public int getInt(String key, int defaultValue) {
		String val = properties.get(key);
		if (val == null) return defaultValue;
		try {
			return Integer.parseInt(val.trim());
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}

	public long getLong(String key, long defaultValue) {
		String val = properties.get(key);
		if (val == null) return defaultValue;
		try {
			return Long.parseLong(val.trim());
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
}
