CREATE TABLE AUTHOR (
AU_ID        NUMBER(7,0) PRIMARY KEY,
AU_FNAME     VARCHAR2(30) NOT NULL  ,
AU_LNAME     VARCHAR2(30) NOT NULL  ,
AU_BIRTHYEAR NUMBER(4)
);
CREATE TABLE PATRON (
PAT_ID      NUMBER(10,0) PRIMARY KEY,
PAT_FNAME   VARCHAR2(20) NOT NULL   ,
PAT_LNAME   VARCHAR2(20) NOT NULL   ,
PAT_TYPE    VARCHAR2(10) NOT NULL
);
CREATE TABLE BOOK (
BOOK_NUM   NUMBER(10,0) PRIMARY KEY,
BOOK_TITLE VARCHAR2(120) NOT NULL  ,
BOOK_YEAR  NUMBER(4)               ,
BOOK_COST  NUMBER(8,2)             ,
BOOK_SUBJECT VARCHAR2(120)         ,
PAT_ID    NUMBER(10) REFERENCES PATRON
);
CREATE TABLE CHECKOUT (
CHECK_NUM         NUMBER(15) PRIMARY KEY,
BOOK_NUM          NUMBER(10) REFERENCES BOOK,
PAT_ID            NUMBER(10) REFERENCES PATRON,
CHECK_OUT_DATE    DATE DEFAULT SYSDATE,
CHECK_DUE_DATE    DATE,
CHECK_IN_DATE     DATE
);
CREATE TABLE WRITES (
BOOK_NUM  NUMBER(10) REFERENCES BOOK,
AU_ID     NUMBER(7) REFERENCES AUTHOR,
CONSTRAINT WRITES_BOOK_AU_PK PRIMARY KEY (BOOK_NUM, AU_ID)
);
--1 --
SELECT PAT_FNAME,PAT_LNAME
FROM PATRON
ORDER BY PAT_LNAME,PAT_FNAME;
--2--
SELECT CHECK_NUM,CHECK_OUT_DATE,CHECK_DUE_DATE
FROM CHECKOUT
ORDER BY CHECK_NUM;
--3--
SELECT BOOK_NUM, BOOK_TITLE , BOOK_SUBJECT FROM BOOK ORDER BY BOOK_NUM;
--4--
SELECT BOOK_NUM , BOOK_TITLE, BOOK_COST FROM BOOK ORDER BY BOOK_NUM;
--5--
SELECT CHECK_NUM, BOOK_NUM, PAT_ID, CHECK_OUT_DATE, CHECK_DUE_DATE 
FROM CHECKOUT ORDER BY CHECK_OUT_DATE DESC, CHECK_NUM ASC;
--6--
SELECT BOOK_NUM, BOOK_TITLE, 
BOOK_COST FROM BOOK WHERE (((BOOK_SUBJECT)="databases")) ORDER BY BOOK_NUM;
--7--
SELECT CHECK_NUM, BOOK_NUM, CHECK_OUT_DATE
FROM CHECKOUT WHERE (((CHECK_OUT_DATE)="4/5/2017")) ORDER BY CHECK_NUM;
--8--
 SELECT CHECK_NUM,BOOK_NUM,PAT_ID,CHECK_OUT_DATE, CHECK_DUE_DATE 
 FROM CHECKOUT WHERE CHECK_IN_DATE IS NULL ORDER BY BOOK_NUM;
--9--
SELECT AU_ID, AU_FNAME, AU_LNAME, AU_BIRTHYEAR FROM AUTHOR
ORDER BY AU_BIRTHYEAR DESC, AU_LNAME;
--10--
Select BOOK_SUBJECT , Count(BOOK_NUM) AS "Books In Subject" 
FROM BOOK GROUP BY BOOK_SUBJECT ORDER BY COUNT(BOOK_NUM) DESC, BOOK_SUBJECT;