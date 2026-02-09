package batch.service;

/**
 * TMDB 배치 처리 서비스 인터페이스
 */
public interface TmdbBatchService {
	/**
	 * TMDB 배치 작업 실행
	 */
	void executeBatch() throws Exception;
}
