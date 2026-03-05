-- ============================================================
-- Cinema_Talk 전체 SQL 통합 스크립트 (SUM_SQL.sql)
-- 실행 순서: 테이블 간 제약관계(PK, FK)를 고려하여 정렬
-- ============================================================
-- 실행 순서:
--   1단계: 독립 테이블 (FK 없음)        - DAILY_VISIT, GENRE, PERSON, MOVIE, MEMBER, BOARD_TYPE
--   2단계: 시퀀스 (테이블 생성 후)       - memNoSeq, boardIdSeq, etc.
--   3단계: 1단계 테이블 참조             - BOARD, MOVIE_GENRE, MOVIE_CAST, MOVIE_CREW,
--                                         MEMBER_GENRE, MEMBER_MOVIE_RECOMMEND,
--                                         VOTE_REGISTER, VOTE_OPTION, VOTE_RECORD
--   4단계: 2~3단계 테이블 참조           - BOARD_LIKE, COMMENTS, ADD_FILE
--   5단계: 4단계 테이블 참조             - COMMENTS_LIKE
--   6단계: 트리거                     - trgOnMovieDeleted, trgVoptId
--   7단계: 테이블, 트리거, 시퀸스 전부 제거
-- ============================================================


-- ************************************************************
-- 1단계: 독립 테이블 (FK 참조 없음)
-- ************************************************************

-- ============================================================
-- DAILY_VISIT
-- ============================================================
CREATE TABLE DAILY_VISIT (
    statDate     DATE PRIMARY KEY,
    dauCount     NUMBER DEFAULT 0
);

-- ============================================================
-- GENRE
-- ============================================================
CREATE TABLE GENRE (
    genreId   NUMBER        NOT NULL,
    genreName VARCHAR2(50)  NOT NULL,
    CONSTRAINT PK_GENRE PRIMARY KEY (genreId)
);

-- ============================================================
-- PERSON
-- ============================================================
CREATE TABLE PERSON (
    personId   NUMBER        NOT NULL,
    personName VARCHAR2(255),
    biography  CLOB,
    profilePath VARCHAR2(255),
    CONSTRAINT PK_PERSON PRIMARY KEY (personId)
);

-- ============================================================
-- MOVIE
-- ============================================================
CREATE TABLE MOVIE (
    movieId            NUMBER        NOT NULL,
    movieTitle         VARCHAR2(255),
    movieOriginalTitle VARCHAR2(255),
    movieOverview      CLOB,
    movieReleaseDate   DATE,
    movieRuntime       NUMBER,
    moviePosterPath    VARCHAR2(255),
    movieBackdropPath  VARCHAR2(255),
    movieRatingAverage NUMBER(5,2),
    movieRatingCount   NUMBER,
    movieCreatedAt     DATE,
    movieRecommendCount NUMBER DEFAULT 0,
    CONSTRAINT PK_MOVIE PRIMARY KEY (movieId)
);

-- ============================================================
-- MEMBER
-- ============================================================
CREATE TABLE MEMBER (
    memNo           NUMBER(38)     PRIMARY KEY,
    memId           VARCHAR2(50)   NOT NULL UNIQUE,
    memPwd          VARCHAR2(255)  NOT NULL,
    memName         VARCHAR2(50)   NOT NULL,
    memPhone        VARCHAR2(50)   NOT NULL UNIQUE,
    memEmail        VARCHAR2(100)  NOT NULL,
    memRole         NUMBER(1)      NOT NULL CHECK (memRole IN (1,2)),
    memState        NUMBER(1)      NOT NULL CHECK (memState IN (1,2,3)),
    memDate         DATE           NOT NULL,
    memProfilePhoto VARCHAR2(1000),
    memLastLogin    DATE
);

ALTER TABLE MEMBER ADD CONSTRAINT uk_member_email UNIQUE (memEmail);

-- ============================================================
-- BOARD_TYPE
-- ============================================================
CREATE TABLE BOARD_TYPE (
    boardTypeId   NUMBER       PRIMARY KEY NOT NULL,
    boardTypeName VARCHAR2(50) NULL
);


-- ************************************************************
-- 2단계: 시퀀스
-- ************************************************************

CREATE SEQUENCE memNoSeq   NOCACHE;
CREATE SEQUENCE boardIdSeq NOCACHE;
CREATE SEQUENCE SEQ_COMMENTS START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE FILE_NO_SEQ  NOCACHE;
CREATE SEQUENCE optionidSeq  START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;
CREATE SEQUENCE recordIdSeq  START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;
CREATE SEQUENCE voteIdSeq    START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;


-- ************************************************************
-- 3단계: 1단계 테이블을 참조하는 테이블
-- ************************************************************

-- ============================================================
-- BOARD  (FK → MEMBER)
-- ============================================================
CREATE TABLE BOARD (
    boardId        NUMBER         NOT NULL,
    boardType      NUMBER         NOT NULL,
    boardTitle     VARCHAR2(200)  NULL,
    boardContent   CLOB           NULL,
    boardName      VARCHAR2(50)   NOT NULL,
    boardViewCount NUMBER         NULL,
    boardDate      DATE           NULL,
    memNo          NUMBER         NULL,
    movieId        NUMBER         NULL,
    linkUrl        VARCHAR2(500)  NULL,
    CONSTRAINT pk_board_type PRIMARY KEY (boardId, boardType)
);

ALTER TABLE BOARD ADD CONSTRAINT fk_mem_no
    FOREIGN KEY (memNo) REFERENCES MEMBER (memNo);

-- ============================================================
-- MOVIE_GENRE  (FK → GENRE, MOVIE)
-- ============================================================
CREATE TABLE MOVIE_GENRE (
    genreId NUMBER NOT NULL,
    movieId NUMBER NOT NULL,
    CONSTRAINT PK_MOVIE_GENRE PRIMARY KEY (genreId, movieId)
);

ALTER TABLE MOVIE_GENRE ADD CONSTRAINT FK_GENRE_TO_MOVIE_GENRE
    FOREIGN KEY (genreId) REFERENCES GENRE (genreId)   ON DELETE CASCADE;

ALTER TABLE MOVIE_GENRE ADD CONSTRAINT FK_MOVIE_TO_MOVIE_GENRE
    FOREIGN KEY (movieId) REFERENCES MOVIE (movieId)   ON DELETE CASCADE;

-- ============================================================
-- MOVIE_CAST  (FK → PERSON, MOVIE)
-- ============================================================
CREATE TABLE MOVIE_CAST (
    personId      NUMBER        NOT NULL,
    movieId       NUMBER        NOT NULL,
    characterName VARCHAR2(255),
    castOrder     NUMBER,
    CONSTRAINT PK_MOVIE_CAST PRIMARY KEY (personId, movieId)
);

ALTER TABLE MOVIE_CAST ADD CONSTRAINT FK_PERSON_TO_MOVIE_CAST
    FOREIGN KEY (personId) REFERENCES PERSON (personId) ON DELETE CASCADE;

ALTER TABLE MOVIE_CAST ADD CONSTRAINT FK_MOVIE_TO_MOVIE_CAST
    FOREIGN KEY (movieId)  REFERENCES MOVIE (movieId)   ON DELETE CASCADE;

-- ============================================================
-- MOVIE_CREW  (FK → PERSON, MOVIE)
-- ============================================================
CREATE TABLE MOVIE_CREW (
    personId NUMBER       NOT NULL,
    movieId  NUMBER       NOT NULL,
    crewJob  VARCHAR2(100),
    CONSTRAINT PK_MOVIE_CREW PRIMARY KEY (personId, movieId)
);

ALTER TABLE MOVIE_CREW ADD CONSTRAINT FK_PERSON_TO_MOVIE_CREW
    FOREIGN KEY (personId) REFERENCES PERSON (personId) ON DELETE CASCADE;

ALTER TABLE MOVIE_CREW ADD CONSTRAINT FK_MOVIE_TO_MOVIE_CREW
    FOREIGN KEY (movieId)  REFERENCES MOVIE (movieId)   ON DELETE CASCADE;

-- ============================================================
-- MEMBER_GENRE  (FK → GENRE, MEMBER)
-- ============================================================
CREATE TABLE MEMBER_GENRE (
    genreId NUMBER NOT NULL,
    memNo   NUMBER NOT NULL
);

ALTER TABLE MEMBER_GENRE ADD CONSTRAINT PK_MEMBER_GENRE
    PRIMARY KEY (genreId, memNo);

ALTER TABLE MEMBER_GENRE ADD CONSTRAINT FK_MEMBER_GENRE_GENREID
    FOREIGN KEY (genreId) REFERENCES GENRE (genreId);

ALTER TABLE MEMBER_GENRE ADD CONSTRAINT FK_MEMBER_GENRE_MEMNO
    FOREIGN KEY (memNo)   REFERENCES MEMBER (memNo);

-- ============================================================
-- MEMBER_MOVIE_RECOMMEND  (FK → MEMBER, MOVIE)
-- ============================================================
CREATE TABLE MEMBER_MOVIE_RECOMMEND (
    memNo              NUMBER NOT NULL,
    movieId            NUMBER NOT NULL,
    recommendCreatedAt DATE   DEFAULT SYSDATE,
    CONSTRAINT pk_RECOMMEND PRIMARY KEY (memNo, movieId),
    CONSTRAINT fk_rec_member FOREIGN KEY (memNo)   REFERENCES MEMBER (memNo),
    CONSTRAINT fk_rec_movie  FOREIGN KEY (movieId) REFERENCES MOVIE (movieId) ON DELETE CASCADE
);

CREATE INDEX idx_rec_date ON MEMBER_MOVIE_RECOMMEND (recommendCreatedAt, movieId);

-- ============================================================
-- VOTE_REGISTER  (독립 — PK만 존재)
-- ============================================================
CREATE TABLE VOTE_REGISTER (
    voteId      NUMBER        NOT NULL,
    voteTitle   VARCHAR2(100) NULL,
    voteContent VARCHAR2(4000) NULL,
    voteStartDate DATE        NULL,
    voteEndDate   DATE        NULL,
    voteStatus    VARCHAR2(20) NULL,
    CONSTRAINT PK_VOTE_REGISTER PRIMARY KEY (voteId)
);

-- ============================================================
-- VOTE_OPTION  (FK → VOTE_REGISTER, MOVIE)
-- ============================================================
CREATE TABLE VOTE_OPTION (
    optionId         NUMBER        NOT NULL,
    voteId           NUMBER        NOT NULL,
    movieId          NUMBER        NULL,
    movieDeleted     NUMBER(1)     DEFAULT 0,
    movieTitleBackup VARCHAR2(200),
    CONSTRAINT PK_VOTE_OPTION PRIMARY KEY (optionId)
);

ALTER TABLE VOTE_OPTION ADD CONSTRAINT FK_VOTE_REGISTER_TO_VOTE_OPTION_1
    FOREIGN KEY (voteId)  REFERENCES VOTE_REGISTER (voteId) ON DELETE CASCADE;

ALTER TABLE VOTE_OPTION ADD CONSTRAINT FK_MOVIE_TO_VOTE_OPTION_1
    FOREIGN KEY (movieId) REFERENCES MOVIE (movieId);

-- 유니크 인덱스 (movieDeleted = 0 인 행만 대상)
CREATE UNIQUE INDEX UK_VOTE_OPTION_ACTIVE
    ON VOTE_OPTION (
        CASE WHEN movieDeleted = 0 THEN voteId  END,
        CASE WHEN movieDeleted = 0 THEN movieId END
    );

-- ============================================================
-- VOTE_RECORD  (FK → VOTE_REGISTER, MEMBER, MOVIE)
-- ============================================================
CREATE TABLE VOTE_RECORD (
    recordId         NUMBER         NOT NULL,
    recordCreatedDate DATE          NULL,
    memNo            NUMBER         NOT NULL,
    voteId           NUMBER         NOT NULL,
    movieId          NUMBER         NULL,
    voteCommentText  VARCHAR2(4000) NULL,
    movieDeleted     NUMBER(1)      DEFAULT 0,
    movieTitleBackup VARCHAR2(200),
    CONSTRAINT PK_VOTE_RECORD PRIMARY KEY (recordId)
);

ALTER TABLE VOTE_RECORD ADD CONSTRAINT FK_VOTE_REGISTER_TO_VOTE_RECORD_1
    FOREIGN KEY (voteId)  REFERENCES VOTE_REGISTER (voteId) ON DELETE CASCADE;

ALTER TABLE VOTE_RECORD ADD CONSTRAINT FK_MEMBER_TO_VOTE_RECORD
    FOREIGN KEY (memNo)   REFERENCES MEMBER (memNo);

ALTER TABLE VOTE_RECORD ADD CONSTRAINT FK_MOVIE_TO_VOTE_RECORD
    FOREIGN KEY (movieId) REFERENCES MOVIE (movieId);

ALTER TABLE VOTE_RECORD ADD CONSTRAINT uq_vote_record
    UNIQUE (voteId, memNo);


-- ************************************************************
-- 4단계: 3단계 테이블을 참조하는 테이블
-- ************************************************************

-- ============================================================
-- BOARD_LIKE  (FK → BOARD, MEMBER)
-- ============================================================
CREATE TABLE BOARD_LIKE (
    boardId   NUMBER NOT NULL,
    boardType NUMBER NOT NULL,
    memNo     NUMBER NOT NULL,
    CONSTRAINT pk_board_like   PRIMARY KEY (boardId, boardType, memNo),
    CONSTRAINT fk_like_board   FOREIGN KEY (boardId, boardType)
        REFERENCES BOARD (boardId, boardType) ON DELETE CASCADE,
    CONSTRAINT fk_like_member  FOREIGN KEY (memNo)
        REFERENCES MEMBER (memNo)
);

-- ============================================================
-- COMMENTS  (FK → BOARD, MEMBER, 자기참조)
-- ============================================================
CREATE TABLE COMMENTS (
    COMMENTSID      NUMBER(10),
    BOARDID         NUMBER(10)     NOT NULL,
    BOARDTYPE       NUMBER(10)     NOT NULL,
    COMMENTSCONTENT VARCHAR2(2000) NOT NULL,
    COMMENTSNAME    VARCHAR2(50),
    COMMENTSDATE    DATE DEFAULT SYSDATE,
    COMMENTSNO      NUMBER(10),
    MEMNO           NUMBER(10)     NOT NULL,
    PARENTBOARDNO   NUMBER(10),
    PARENTBOARDID   NUMBER(10),
    CONSTRAINT PK_COMMENTS PRIMARY KEY (COMMENTSID),
    CONSTRAINT FK_COMMENTS_BOARD FOREIGN KEY (BOARDID, BOARDTYPE)
        REFERENCES BOARD (BOARDID, BOARDTYPE) ON DELETE CASCADE,
    CONSTRAINT FK_COMMENTS_MEMBER FOREIGN KEY (MEMNO)
        REFERENCES MEMBER (MEMNO),
    CONSTRAINT FK_COMMENTS_PARENT_ID FOREIGN KEY (PARENTBOARDID)
        REFERENCES COMMENTS (COMMENTSID) ON DELETE CASCADE,
    CONSTRAINT FK_COMMENTS_PARENT_NO FOREIGN KEY (PARENTBOARDNO)
        REFERENCES COMMENTS (COMMENTSID)
);

-- ============================================================
-- ADD_FILE  (FK → BOARD)
-- ============================================================
CREATE TABLE ADD_FILE (
    FILENO     NUMBER               NOT NULL,
    BOARDID    NUMBER               NOT NULL,
    BOARDTYPE  NUMBER               NOT NULL,
    FILENAME   VARCHAR2(255)        NOT NULL,
    FILEPATH   VARCHAR2(500)        NOT NULL,
    FILESIZE   NUMBER               NOT NULL,
    UPLOADDATE DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_ADD_FILE PRIMARY KEY (FILENO),
    CONSTRAINT FK_ADD_FILE_BOARD FOREIGN KEY (BOARDID, BOARDTYPE)
        REFERENCES BOARD (BOARDID, BOARDTYPE) ON DELETE CASCADE
);


-- ************************************************************
-- 5단계: 4단계 테이블을 참조하는 테이블
-- ************************************************************

-- ============================================================
-- COMMENTS_LIKE  (FK → COMMENTS, MEMBER)
-- ============================================================
CREATE TABLE COMMENTS_LIKE (
    commentsId NUMBER NOT NULL,
    memNo      NUMBER NOT NULL,
    CONSTRAINT pk_comments_like        PRIMARY KEY (commentsId, memNo),
    CONSTRAINT fk_like_comments        FOREIGN KEY (commentsId)
        REFERENCES COMMENTS (commentsId) ON DELETE CASCADE,
    CONSTRAINT fk_like_comments_member FOREIGN KEY (memNo)
        REFERENCES MEMBER (memNo)
);


-- ************************************************************
-- 6단계: 트리거
-- ************************************************************

-- 영화 삭제 전 VOTE_OPTION, VOTE_RECORD 처리 트리거
CREATE OR REPLACE TRIGGER trgOnMovieDeleted
BEFORE DELETE ON MOVIE
FOR EACH ROW
BEGIN
    UPDATE VOTE_OPTION
    SET movieDeleted     = 1,
        movieTitleBackup = :old.movieTitle,
        movieId          = NULL
    WHERE movieId = :old.movieId;

    UPDATE VOTE_RECORD
    SET movieDeleted     = 1,
        movieTitleBackup = :old.movieTitle,
        movieId          = NULL
    WHERE movieId = :old.movieId;
END;
/

-- VOTE_OPTION 자동 optionId 채번 트리거
CREATE OR REPLACE TRIGGER trgVoptId
BEFORE INSERT ON VOTE_OPTION
FOR EACH ROW
BEGIN
    IF :new.optionId IS NULL THEN
        SELECT optionidSeq.NEXTVAL INTO :new.optionId FROM DUAL;
    END IF;
END;
/


-- ************************************************************
-- 초기 데이터 삽입
-- ************************************************************

-- 관리자 계정 생성
INSERT INTO MEMBER (memNo, memId, memPwd, memName, memPhone, memEmail, memRole, memState, memDate)
VALUES (memNoSeq.NEXTVAL, 'admin',
        '$2a$10$2XSxqZfK.eccyl.pogMgguklaQOFvI/nRccNvdNIRSO0EOVw449ES',
        '관리자', '010-3333-3333', 'admin@gmail.com', 1, 1, SYSDATE);

COMMIT;

/*
-- 테이블 삭제
BEGIN
  FOR t IN (SELECT table_name FROM user_tables)
  LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
  END LOOP;
END;
/
-- 시퀸스 삭제
BEGIN
  FOR s IN (SELECT sequence_name FROM user_sequences)
  LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
  END LOOP;
END;
/
-- 트리거 삭제
BEGIN
  FOR tr IN (SELECT trigger_name FROM user_triggers)
  LOOP
    EXECUTE IMMEDIATE 'DROP TRIGGER ' || tr.trigger_name;
  END LOOP;
END;
/
*/
