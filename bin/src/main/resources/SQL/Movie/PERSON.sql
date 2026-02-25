CREATE TABLE PERSON (
    personId NUMBER NOT NULL,
    personName VARCHAR2(255),
    biography CLOB,
    profilePath VARCHAR2(255),
    CONSTRAINT PK_PERSON PRIMARY KEY (personId)
);

