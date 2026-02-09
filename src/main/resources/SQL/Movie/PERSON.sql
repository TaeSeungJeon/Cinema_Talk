CREATE TABLE "PERSON" (
	"person_id"	VARCHAR(50)		NOT NULL,
	"person_name"	VARCHAR(255)		NULL,
	"biography"	CLOB		NULL,
	"profile_path"	VARCHAR(255)		NULL
);

ALTER TABLE "PERSON" 
ADD CONSTRAINT "PK_PERSON" PRIMARY KEY ("person_id");
