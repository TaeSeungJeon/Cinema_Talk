
CREATE TABLE VOTE_REGISTER (
	vote_id	NUMBER		NOT NULL,
	vote_title	VARCHAR2(100)		NULL,
	vote_content	VARCHAR2(4000)		NULL,
	vote_start_date	DATE		NULL,
	vote_end_date	DATE		NULL,
	vote_status	VARCHAR2(20)		NULL
);



CREATE TABLE VOTE_OPTION (
	vote_id	NUMBER		NOT NULL,
	movie_id	NUMBER		NOT NULL
);

CREATE TABLE VOTE_RECORD (
	record_id	NUMBER		NOT NULL,
	record_created_date	DATE		NULL,
	mem_no	NUMBER		NOT NULL,
	vote_id	NUMBER		NOT NULL,
	movie_id	NUMBER		NOT NULL,
	vote_comment_text	VARCHAR2(4000)		NULL
);


ALTER TABLE VOTE_OPTION ADD CONSTRAINT PK_VOTE_OPTION PRIMARY KEY (
	vote_id,
	movie_id
);

ALTER TABLE VOTE_RECORD ADD CONSTRAINT PK_VOTE_RECORD PRIMARY KEY (
	record_id
);

ALTER TABLE VOTE_REGISTER ADD CONSTRAINT PK_VOTE_REGISTER PRIMARY KEY (
	vote_id
);


ALTER TABLE VOTE_OPTION ADD CONSTRAINT FK_VOTE_REGISTER_TO_VOTE_OPTION_1 FOREIGN KEY (
	vote_id
)
REFERENCES VOTE_REGISTER (
	vote_id
);

ALTER TABLE VOTE_OPTION ADD CONSTRAINT FK_MOVIE_TO_VOTE_OPTION_1 FOREIGN KEY (
	movie_id
)
REFERENCES MOVIE (
	movie_id
);


ALTER TABLE vote_record
ADD CONSTRAINT uq_vote_record
UNIQUE (vote_id, mem_no);

create sequence option_id_seq
start with 1
increment by 1
nocycle
nocache; 



create sequence record_id_seq
start with 1
increment by 1
nocycle
nocache;

create sequence vote_id_seq
start with 1
increment by 1
nocycle
nocache;

