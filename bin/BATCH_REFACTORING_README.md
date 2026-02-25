# TMDB 배치 프로세싱 시스템 (Refactored)

## 개요
TMDB 데이터 로딩 로직이 WebListener에서 분리되어 독립적인 배치 프로세스로 리팩토링되었습니다.

## 주요 변경 사항

### 1. 아키텍처 분리
- **Web App**: 사용자 요청만 처리 (TMDB API 호출 없음)
- **Batch App**: 모든 TMDB 데이터 수집 담당 (독립 실행)

### 2. 배치 패키지 구조
```
batch/
  ├── TmdbBatchMain.java          # 스탠드얼론 진입점
  └── service/
      ├── TmdbBatchService.java      # 배치 서비스 인터페이스
      └── TmdbBatchServiceImpl.java  # 배치 서비스 구현
```

### 3. 중복 검사 제거
- 서비스 레이어의 모든 `exists*()` 체크 제거
- DB 레벨에서 Oracle MERGE (UPSERT)로 중복 처리

### 4. Oracle MERGE 적용 테이블
- GENRE
- MOVIE
- PERSON
- MOVIE_CAST
- MOVIE_CREW
- MOVIE_GENRE
- MOVIE_SIMILAR

### 5. 배치 최적화
- MyBatis Batch Executor 사용
- 수동 트랜잭션 제어
- 500개 단위 청크 커밋
- 병렬 처리 (영화 4스레드, 인물 8스레드)

## 실행 방법

### 1. API 키 설정 (필수)
`src/main/resources/batch.properties` 파일에서 설정:
```properties
# TMDB API 키 설정 (https://www.themoviedb.org/settings/api에서 발급)
tmdb.api.key=여기에_실제_API_키_입력
```

또는 환경변수로 설정 (환경변수가 우선):
```bash
set TMDB_API_KEY=your_api_key_here
```

### 2. 배치 실행
```bash
# Maven exec 플러그인 사용
mvn exec:java -Dexec.mainClass="batch.TmdbBatchMain"

# 또는 직접 실행
java -cp target/classes;[dependencies] batch.TmdbBatchMain
```

## 설정 파일

### batch.properties (배치 설정)
```properties
# TMDB API 키
tmdb.api.key=YOUR_API_KEY_HERE

# 배치 처리 설정
batch.movie.count=5
batch.commit.size=500
batch.thread.movies=4
batch.thread.persons=8

# API 재시도 설정
api.max.retry=3
api.retry.delay.ms=1000
```

## DAO 변경 사항

### 새로 추가된 메서드
- `mergeGenre(GenreDTO)`
- `mergeMovie(MovieDTO)`
- `mergePerson(PersonDTO)`
- `mergeMovieCast(MovieCastDTO)`
- `mergeMovieCrew(MovieCrewDTO)`
- `mergeMovieGenre(MovieGenreDTO)`
- `mergeMovieSimilar(MovieSimilarDTO)`

### 기존 메서드 유지 (웹앱 호환성)
- `insert*()` 메서드들
- `exists*()` 메서드들 (하위 호환성 위해 유지, 사용 비권장)

## MyBatis Mapper 변경 사항

각 Mapper XML에 Oracle MERGE 구문 추가:
```xml
<insert id="mergeGenre" parameterType="genre">
    MERGE INTO GENRE g
    USING (SELECT #{genreId} AS genre_id FROM DUAL) src
    ON (g.genre_id = src.genre_id)
    WHEN MATCHED THEN
        UPDATE SET g.genre_name = #{genreName}
    WHEN NOT MATCHED THEN
        INSERT (genre_id, genre_name)
        VALUES (#{genreId}, #{genreName})
</insert>
```

## TMDBDataPreloadListener 변경
- 모든 TMDB 데이터 로딩 로직 제거
- 서버 시작 시 단순 알림 메시지만 출력
- 배치 실행 안내 메시지 표시

## 주의 사항
1. 배치 실행 전 TMDB_API_KEY 환경 변수 설정 필수
2. DB에 PK/UNIQUE 제약조건 확인 필요
3. 대량 데이터 처리 시 BATCH_COMMIT_SIZE 조정 가능
