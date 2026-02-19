create table BOARD(
    boardId              NUMBER        NOT NULL, -- 게시판 아이디
    boardType            NUMBER        not null, -- 게시판 종류
    boardTitle           VARCHAR2(200) null,     -- 게시판 제목
    boardContent         CLOB          null,     -- 게시판 내용
    boardName            VARCHAR2(50)  not null, -- 게시판 글쓴이
    boardRecommendCount NUMBER        null,     -- 게시판 추천 수
    boardDate            DATE          null,     -- 게시판 작성일
    memNo                NUMBER        null,     -- 회원번호
    movieId              NUMBER        null,  -- 영화 고유 ID

    constraint pk_board_type primary key (boardId ,boardType)

);
-- bbs_file_no 컬럼에 정수 숫자 레코드 값으로 활용할 시퀀스 생성
create sequence boardIdSeq      -- file_no_seq 시퀀스 생성
nocache;                    -- start with 1, increment by 1, nocycle 옵션은 기본값이어서 생략.

select boardIdSeq.nextval as "boardIdSeq 다음 시퀀스 번호값 확인" from dual;


alter table board add constraint fk_mem_no foreign key (memNo)
references MEMBER (memNo);

-- MOVIEID 컬럼을 NULL 허용으로 변경
ALTER TABLE BOARD MODIFY (MOVIEID NULL);
