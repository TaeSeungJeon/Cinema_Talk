CREATE TABLE MOVIE (
    movieId NUMBER NOT NULL,
    movieTitle VARCHAR2(255),
    movieOriginalTitle VARCHAR2(255),
    movieOverview CLOB,
    movieReleaseDate DATE,
    movieRuntime NUMBER,
    moviePosterPath VARCHAR2(255),
    movieBackdropPath VARCHAR2(255),
    movieRatingAverage NUMBER(5,2),
    movieRatingCount NUMBER,
    movieCreatedAt DATE,
    movieRecommendCount NUMBER DEFAULT 0, 
    CONSTRAINT PK_MOVIE PRIMARY KEY (movieId)
);
