package mybatis;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/**
 * 배치 처리용 MyBatis 서비스
 * - BATCH ExecutorType 사용
 * - 수동 트랜잭션 제어 지원
 * - 청크 단위 커밋 지원
 */
public class BatchDBService {
	private static SqlSessionFactory factory = null;
	
	static {
		try {
			String resource = "batch-config.xml";
			InputStream is = Resources.getResourceAsStream(resource);
			factory = new SqlSessionFactoryBuilder().build(is);
		} catch (Exception e) {
			System.err.println("배치 설정 파일 로드 실패, 기본 설정 사용");
			// 배치 설정이 없으면 기본 설정 사용
			try {
				String resource = "config.xml";
				InputStream is = Resources.getResourceAsStream(resource);
				factory = new SqlSessionFactoryBuilder().build(is);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}
	
	/**
	 * 기본 SqlSessionFactory 반환
	 */
	public static SqlSessionFactory getFactory() {
		return factory;
	}
	
	/**
	 * 배치 실행용 SqlSession 반환 (auto-commit: false)
	 * 호출자가 commit/rollback/close를 직접 관리해야 함
	 */
	public static SqlSession openBatchSession() {
		return factory.openSession(ExecutorType.BATCH, false);
	}
	
	/**
	 * 일반 실행용 SqlSession 반환 (auto-commit: false)
	 */
	public static SqlSession openSession() {
		return factory.openSession(false);
	}
}
