-- 1. 시퀀스 생성 (이미 있으면 삭제 후 생성)
DROP SEQUENCE SEQ_COMMENTS;
CREATE SEQUENCE SEQ_COMMENTS START WITH 1 INCREMENT BY 1;

-- 2. 제약 조건 없이 테이블만 생성 (가장 안전함)
CREATE TABLE COMMENTS (
                          COMMENTSID      NUMBER(10) PRIMARY KEY,
                          BOARDID         NUMBER(10) NOT NULL,
                          BOARDTYPE       NUMBER(10) NOT NULL,
                          COMMENTSCONTENT VARCHAR2(2000) NOT NULL,
                          COMMENTSNAME    VARCHAR2(50),
                          COMMENTSDATE    DATE DEFAULT SYSDATE,
                          MEMNO           NUMBER(10) NOT NULL,
                          PARENTBOARDID   NUMBER(10)
);

-- 3. 테이블 생성이 확인되면 커밋
COMMIT;