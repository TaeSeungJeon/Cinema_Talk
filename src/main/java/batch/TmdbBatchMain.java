package batch;

import batch.service.TmdbBatchService;
import batch.service.TmdbBatchServiceImpl;

public class TmdbBatchMain {
	
	public static void main(String[] args) {
		System.out.println("\n" + "=".repeat(70));
		System.out.println("TMDB 데이터 배치 프로세싱 시작");
		System.out.println("시작 시간: " + java.time.LocalDateTime.now());
		System.out.println("=".repeat(70) + "\n");
		
		long startTime = System.currentTimeMillis();
		
		try {
			TmdbBatchService batchService = TmdbBatchServiceImpl.getInstance();
			batchService.executeBatch();
			
			long endTime = System.currentTimeMillis();
			long duration = (endTime - startTime) / 1000;
			
			System.out.println("\n" + "=".repeat(70));
			System.out.println("TMDB 데이터 배치 프로세싱 완료");
			System.out.println("종료 시간: " + java.time.LocalDateTime.now());
			System.out.println("소요 시간: " + duration + "초");
			System.out.println("=".repeat(70) + "\n");
			
		} catch (Exception e) {
			System.err.println("\n" + "=".repeat(70));
			System.err.println("TMDB 데이터 배치 프로세싱 중 오류 발생");
			System.err.println("=".repeat(70));
			e.printStackTrace();
			System.err.println();
			System.exit(1);
		}
	}
}
