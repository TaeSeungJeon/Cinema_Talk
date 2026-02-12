create table ADD_FILE
(
    fileNo          NUMBER primary key NOT NULL, -- 파일 번호
    boardId         NUMBER             NOT NULL, -- 게시판 아이디
    boardType       NUMBER             NOT NULL, -- 게시판 종류
    fileName        VARCHAR2(255)      NULL,     -- 첨부 파일명
    filePath        VARCHAR2(1000)     NULL,     -- 펌부 파일 경로
    fileSize        NUMBER             NULL,     -- 첨부 파일 크기
    fileUploadDate DATE               NULL      -- 첨부 파일 등록 날짜
);
    alter table ADD_FILE add constraint fk_board_ref foreign key (boardId, boardType)
        references board (boardId, boardType);


