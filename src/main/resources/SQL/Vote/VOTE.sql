
CREATE TABLE VOTE_REGISTER (
	voteId	NUMBER		NOT NULL,
	voteTitle	VARCHAR2(100)		NULL,
	voteContent	VARCHAR2(4000)		NULL,
	voteStartDate	DATE		NULL,
	voteEndDate	DATE		NULL,
	voteStatus	VARCHAR2(20)		NULL
);

CREATE TABLE VOTE_OPTION (
	voteId	NUMBER		NOT NULL,
	movieId	NUMBER		NOT NULL
);

CREATE TABLE VOTE_RECORD (
	recordId	NUMBER		NOT NULL,
	recordCreatedDate	DATE		NULL,
	memNo	NUMBER		NOT NULL,
	voteId	NUMBER		NOT NULL,
	movieId	NUMBER		NOT NULL,
	voteCommentText	VARCHAR2(4000)		NULL
);


ALTER TABLE VOTE_RECORD ADD CONSTRAINT PK_VOTE_RECORD PRIMARY KEY (
	recordId
);

ALTER TABLE VOTE_REGISTER ADD CONSTRAINT PK_VOTE_REGISTER PRIMARY KEY (
	voteId
);

--on delete cascade 제약조건 추가
ALTER TABLE VOTE_OPTION ADD CONSTRAINT FK_VOTE_REGISTER_TO_VOTE_OPTION_1 
    FOREIGN KEY (voteId) REFERENCES VOTE_REGISTER (voteId) 
    ON DELETE CASCADE;

--on delete cascade 제약조건 추가
ALTER TABLE VOTE_RECORD ADD CONSTRAINT FK_VOTE_REGISTER_TO_VOTE_RECORD_1 
    FOREIGN KEY (voteId) REFERENCES VOTE_REGISTER (voteId) 
    ON DELETE CASCADE;

ALTER TABLE VOTE_RECORD ADD CONSTRAINT FK_MEMBER_TO_VOTE_RECORD 
    FOREIGN KEY (memNo) REFERENCES MEMBER (memNo);

ALTER TABLE VOTE_OPTION MODIFY (movieId NUMBER NULL); 

ALTER TABLE VOTE_OPTION ADD CONSTRAINT FK_MOVIE_TO_VOTE_OPTION_1 
    FOREIGN KEY (movieId) REFERENCES MOVIE (movieId);


ALTER TABLE VOTE_RECORD MODIFY (movieId NUMBER NULL);
ALTER TABLE VOTE_RECORD ADD CONSTRAINT FK_MOVIE_TO_VOTE_RECORD 
    FOREIGN KEY (movieId) REFERENCES MOVIE (movieId);


ALTER TABLE VOTE_OPTION ADD (optionId NUMBER NOT NULL);

ALTER TABLE VOTE_OPTION ADD CONSTRAINT PK_VOTE_OPTION PRIMARY KEY (optionId);

-- 유니크 제약조건 추가
-- 영화가 삭제되어 movieId가 NULL이 되는 것은 허용해줌
CREATE UNIQUE INDEX UK_VOTE_OPTION_ACTIVE 
ON VOTE_OPTION (CASE WHEN movieDeleted = 0 THEN voteId END, 
                CASE WHEN movieDeleted = 0 THEN movieId END);

-- 영화가 삭제되는 여부를 저장하기 위한 컬럼 추가
ALTER TABLE VOTE_OPTION 
ADD (movieDeleted NUMBER(1) DEFAULT 0);

-- 영화가 삭제되는 여부를 저장하기 위한 컬럼 추가
ALTER TABLE VOTE_RECORD 
ADD (movieDeleted NUMBER(1) DEFAULT 0);

-- VOTE_OPTION에 삭제된 제목 확인 가능하게 함
ALTER TABLE VOTE_OPTION ADD (movieTitleBackup VARCHAR2(200));

-- VOTE_RECORD에 개별 투표 이력에서 제목 확인 가능하게 함
ALTER TABLE VOTE_RECORD ADD (movieTitleBackup VARCHAR2(200));

-- 영화가 삭제 되기전 트리거
CREATE OR REPLACE TRIGGER trgOnMovieDeleted
BEFORE DELETE ON MOVIE
FOR EACH ROW
BEGIN
    -- VOTE_OPTION 처리
    UPDATE VOTE_OPTION
    SET movieDeleted = 1,
        movieTitleBackup = :old.movieTitle,
        movieId = NULL  -- 트리거가 직접 명시적으로 처리
    WHERE movieId = :old.movieId;
    
    -- VOTE_RECORD 처리
    UPDATE VOTE_RECORD
    SET movieDeleted = 1,
        movieTitleBackup = :old.movieTitle,
        movieId = NULL  -- 트리거가 직접 명시적으로 처리
    WHERE movieId = :old.movieId;
END;
/

CREATE OR REPLACE TRIGGER trgVoptId
BEFORE INSERT ON VOTE_OPTION
FOR EACH ROW
BEGIN
    IF :new.optionId IS NULL THEN
        SELECT optionidSeq.NEXTVAL INTO :new.optionId FROM DUAL;
    END IF;
END;
/

ALTER TABLE vote_record
ADD CONSTRAINT uq_vote_record
UNIQUE (voteId, memNo);

create sequence optionidSeq
start with 1
increment by 1
nocycle
nocache;

create sequence recordIdSeq
start with 1
increment by 1
nocycle
nocache;

create sequence voteIdSeq
start with 1
increment by 1
nocycle
nocache;