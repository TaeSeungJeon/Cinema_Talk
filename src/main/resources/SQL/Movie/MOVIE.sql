CREATE TABLE "MOVIE" (
	"movie_id"	VARCHAR(50)		NOT NULL,
	"movie_title"	VARCHAR(255)		NULL,
	"movie_original_title"	VARCHAR(255)		NULL,
	"movie_overview"	CLOB		NULL,
	"movie_release_date"	DATE		NULL,
	"movie_runtime"	NUMBER(50)		NULL,
	"movie_poster_path"	VARCHAR(255)		NULL,
	"movie_backdrop_path"	VARCHAR(255)		NULL,
	"movie_rating_average"	NUMBER(5,2)		NULL,
	"movie_rating_count"	NUMBER(50)		NULL,
	"movie_created_at"	DATE		NULL
);

ALTER TABLE "MOVIE" 
ADD CONSTRAINT "PK_MOVIE" PRIMARY KEY ("movie_id");

-- CHECK 제약 조건: 데이터 검증
ALTER TABLE "MOVIE"
ADD CONSTRAINT "CK_MOVIE_RUNTIME"
CHECK ("movie_runtime" IS NULL OR ("movie_runtime" > 0 AND "movie_runtime" <= 500));

ALTER TABLE "MOVIE"
ADD CONSTRAINT "CK_MOVIE_RATING_AVG"
CHECK ("movie_rating_average" IS NULL OR ("movie_rating_average" >= 0 AND "movie_rating_average" <= 10));

ALTER TABLE "MOVIE"
ADD CONSTRAINT "CK_MOVIE_RATING_COUNT"
CHECK ("movie_rating_count" IS NULL OR "movie_rating_count" >= 0);
