
/* Drop Tables */

DROP TABLE ICTUSER.BBS CASCADE CONSTRAINTS;
DROP TABLE ICTUSER.USERS CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE ICTUSER.BBS
(
	ID  NOT NULL,
	USERNAME  NOT NULL,
	TITLE nvarchar2(50) NOT NULL,
	CONTENT nvarchar2(2000) NOT NULL,
	HITCOUNT  DEFAULT 0,
	POSTDATE date DEFAULT SYSDATE
,
	CONSTRAINT SYS_C0011865 PRIMARY KEY (ID)
);


CREATE TABLE ICTUSER.USERS
(
	ID  DEFAULT "ICTUSER"."ISEQ$$_78381".nextval NOT NULL,
	USERNAME varchar2(50 char) NOT NULL,
	PASSWORD varchar2(100 char) NOT NULL,
	GENDER varchar2(10 char) NOT NULL,
	INTERESTS varchar2(100 char) NOT NULL,
	GRADE varchar2(50 char) NOT NULL,
	SELF clob NOT NULL,
	PASSWORDCONFIRM varchar2(100 char),
	CONSTRAINT SYS_C0011810 PRIMARY KEY (ID)
);



/* Create Foreign Keys */

ALTER TABLE ICTUSER.BBS
	ADD FOREIGN KEY (USERNAME)
	REFERENCES ICTUSER.USERS (ID)
;



