create table comments
(
    commentsId      NUMBER       not NULL,-- 댓글 아이디
    boardId         NUMBER       NOT NULL, -- 게시판 아이디
    boardType       NUMBER       NOT NULL, -- 게시판 종류
    commentsContent CLOB         NULL, -- 댓글내용
    commentsName    VARCHAR2(50) NULL, -- 댓글 작성자
    commentsDate    DATE         NULL, -- 댓글 작성일
    commentsNo      NUMBER       NULL, -- 댓글 아이디
    memNo           NUMBER       NOT NULL, -- 회원번호
    parentBoardNo  NUMBER       NULL, -- 부모 댓글 ID
    parentBoardId  NUMBER       NOT NULL, -- 게시판 아이디

    constraint pk_comments primary key (commentsId, boardId, boardType)
);
alter table comments add constraint fk_memNo foreign key (memNo)
    references MEMBER (memNo);


/* mem_no, parent_board_no, parent_board_id fk 해야함*/

