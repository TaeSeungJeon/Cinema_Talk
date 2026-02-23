CREATE TABLE COMMENTS_LIKE(
    commentsId NUMBER NOT NULL,
    memNo      NUMBER NOT NULL,

    CONSTRAINT pk_comments_like PRIMARY KEY (commentsId, memNo),
    CONSTRAINT fk_like_comments FOREIGN KEY (commentsId)
        REFERENCES COMMENTS (commentsId),
    CONSTRAINT fk_like_comments_member FOREIGN KEY (memNo)
        REFERENCES MEMBER (memNo)
);