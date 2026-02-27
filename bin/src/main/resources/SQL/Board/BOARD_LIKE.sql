CREATE TABLE BOARD_LIKE(
    boardId   NUMBER NOT NULL,
    boardType NUMBER NOT NULL,
    memNo     NUMBER NOT NULL,


    CONSTRAINT pk_board_like PRIMARY KEY (boardId, boardType, memNo),
    CONSTRAINT fk_like_board FOREIGN KEY (boardId, boardType)
        REFERENCES BOARD (boardId, boardType),
    CONSTRAINT fk_like_member FOREIGN KEY (memNo)
        REFERENCES MEMBER (memNo)
);