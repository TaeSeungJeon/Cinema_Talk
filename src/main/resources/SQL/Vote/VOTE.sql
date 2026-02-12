
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


ALTER TABLE VOTE_OPTION ADD CONSTRAINT PK_VOTE_OPTION PRIMARY KEY (
	voteId,
	movieId
);

ALTER TABLE VOTE_RECORD ADD CONSTRAINT PK_VOTE_RECORD PRIMARY KEY (
	recordId
);

ALTER TABLE VOTE_REGISTER ADD CONSTRAINT PK_VOTE_REGISTER PRIMARY KEY (
	voteId
);


ALTER TABLE VOTE_OPTION ADD CONSTRAINT FK_VOTE_REGISTER_TO_VOTE_OPTION_1 FOREIGN KEY (
	voteId
)
REFERENCES VOTE_REGISTER (
	voteId
);

ALTER TABLE VOTE_OPTION ADD CONSTRAINT FK_MOVIE_TO_VOTE_OPTION_1 FOREIGN KEY (
	movieId
)
REFERENCES MOVIE (
	movieId
);


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

