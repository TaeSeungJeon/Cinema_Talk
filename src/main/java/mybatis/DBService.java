package mybatis;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class DBService {
	private static SqlSessionFactory factory = null;
	
	static {
		try {
			String resource = "config.xml";
			InputStream is = Resources.getResourceAsStream(resource);
			factory = new SqlSessionFactoryBuilder().build(is);
            System.out.println("✅ SqlSessionFactory 생성 성공");

		} catch (Exception e) {
            System.out.println("❌ SqlSessionFactory 생성 실패");

			e.printStackTrace();
		}
	}
	public static SqlSessionFactory getFactory() {
		return factory;
	}
}
