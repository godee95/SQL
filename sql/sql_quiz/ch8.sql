-- Table & Constraints
-- 테이블 조작과 제약조건 
 
 
DROP DATABASE IF EXISTS ShopDB; 
DROP DATABASE IF EXISTS ModelDB; 
DROP DATABASE IF EXISTS sqlDB; 
DROP DATABASE IF EXISTS tableDB; 
 
 
 
 
DROP DATABASE tableDB; 
CREATE DATABASE tableDB; 
 
USE tableDB; 
DROP TABLE IF EXISTS buyTbl, userTbl; 

-- 제약조건 하나도 없는 상태 
-- colum명 data type

-- nchar unicode방식으로 인코딩
-- char은 ascii 방식으로 인코딩

CREATE TABLE userTbl -- 회원 테이블 
( userID  char(8), -- 사용자 아이디  -- 컬럼명 데이터타입, - 반복 
  name    nvarchar(10), -- 이름 
  birthYear   int,  -- 출생년도 
  addr   nchar(2), -- 지역(경기,서울,경남 등으로 글자만 입력) -- unicode(전세계 문자 표현 표준), utf-8 
  mobile1 char(3), -- 휴대폰의국번(011, 016, 017, 018, 019, 010 등)  -- ascii - 영문 문자 인코딩 방식 
  mobile2   char(8), -- 휴대폰의 나머지 전화번호(하이픈 제외) 
  height    smallint,  -- 키 
  mDate    date  -- 회원 가입일 
); 
CREATE TABLE buyTbl -- 구매 테이블 
(  num int, -- 순번(PK) 
   userid  char(8),-- 아이디(FK) 
   prodName nchar(6), -- 물품명 
   groupName nchar(4) , -- 분류 
   price     int , -- 단가 
   amount    smallint -- 수량 
); 
 
USE tableDB; 
DROP TABLE IF EXISTS buyTbl, userTbl; 


-- default는 null
-- not null 하고 싶으면 제약조건 추가해야함.
CREATE TABLE userTbl  
( userID  char(8) NOT NULL ,  
  name    varchar(10) NOT NULL,  
  birthYear   int NOT NULL,   
  addr   char(2) NOT NULL, 
  mobile1 char(3) NULL,  
  mobile2   char(8) NULL,  
  height    smallint NULL,  
  mDate    date NULL  
); 
CREATE TABLE buyTbl  
(  num int NOT NULL ,  
   userid  char(8) NOT NULL , 
   prodName char(6) NOT NULL, 
   groupName char(4) NULL ,  
   price     int  NOT NULL, 
   amount    smallint  NOT NULL  
); 
 
 
-- 제약조건(constraints) -  
 

 
/* 제약조건 
primary key - unique, not null 
foreign key -  
unique 
default 
null, not null 
*/ 
 
 
DROP TABLE IF EXISTS buyTbl, userTbl; 

-- primary key는 null값이 없어야 하고 unique한 값이어야 함.
CREATE TABLE userTbl  
( userID  char(8) NOT NULL PRIMARY KEY, -- 회원 아이디, 대부분 테이블에 설정, 하나 이상의 열에 가능 
  name    varchar(10) NOT NULL,  
  birthYear   int NOT NULL,   
  addr   char(2) NOT NULL, 
  mobile1 char(3) NULL,  
  mobile2   char(8) NULL,  
  height    smallint NULL,  
  mDate    date NULL  
); 
CREATE TABLE buyTbl  
(  num int NOT NULL PRIMARY KEY,  
   userid  char(8) NOT NULL , 
   prodName char(6) NOT NULL, 
   groupName char(4) NULL ,  
   price     int  NOT NULL, 
   amount    smallint  NOT NULL  
); 
 

 
 
 
use tabledb; 
DROP TABLE IF EXISTS buyTbl; 

-- auto_increment 회원번호 자동으로 숫자가 등록
-- primary key거나 null 값이 없어야 auto_increment 옵션 가능.
CREATE TABLE buyTbl  
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY, -- auto_increment - primary key or unique Key 
   userid  char(8) NOT NULL , 
   prodName char(6) NOT NULL, 
   groupName char(4) NULL ,  
   price     int  NOT NULL, 
   amount    smallint  NOT NULL  
); 
 
 
 
 
 
 
 
 
 
DROP TABLE IF EXISTS buyTbl; 

-- 외래키 지정 : 외부데이블과의 연결, 무결성
-- REFERENCES 외부에 있는 어떤 칼럼과 연결할지 지정
CREATE TABLE buyTbl  
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY ,  
   userid  char(8) NOT NULL,   
   prodName char(6) NOT NULL, 
   groupName char(4) NULL ,  
   price     int  NOT NULL, 
   amount    smallint  NOT NULL  
  , FOREIGN KEY(userid) REFERENCES userTbl(userID)  -- foreign key 
); 
 
 
 
 
 
 
 
 
 
 
INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8'); 
INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4'); 
INSERT INTO userTbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7'); 
 
select * from usertbl; 

-- buytbl이 usertbl을 참조(usertbl > buytbl)
-- usertbl에 없는 jyp가 buytbl에 있어서 error 발생
-- 첫번째 jyp때뭉에 그 뒤에 문제 없는 kbs데이터도 입력되지 않게 됨.
INSERT INTO buyTbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1); 
INSERT INTO buyTbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1); 
INSERT INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL, 30, 2);  -- error 
 
select * from buytbl; 
 
-- ignore은 써주면 문제가 있는 jyp는 안들어감
-- 문제 없는 kbs는 들어가짐.
INSERT ignore INTO buyTbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1); 
INSERT ignore INTO buyTbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1); 
INSERT ignore INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL, 30, 2);  -- error 
 
select * from buytbl; 

 
 
-- <Primary Key> -- 3가지 방법 

-- usertbl 이 참조되어지고 있으므로 삭제 안됨.
-- 참조되고 있는 중에는 삭제 안됨. 데이터의 연결성이 무너지기 때문에 
drop table usertbl; 
-- 연결 끊어주면 삭제가 됨.
alter table buytbl drop foreign key buytbl_ibfk_1; 
drop table usertbl; 
 
 -- <primary key  지정하는 방법 3가지>
-- 1 
CREATE TABLE userTbl  
( userID  char(8) NOT NULL PRIMARY KEY,  
  name    varchar(10) NOT NULL,  
  birthYear   int NOT NULL,   
  addr   char(2) NOT NULL, 
  mobile1 char(3) NULL,  
  mobile2   char(8) NULL,  
  height    smallint NULL,  
  mDate    date NULL  
); 
 
DESCRIBE userTBL; 
 
DROP TABLE IF EXISTS userTbl; 
 
-- 2 


-- 하단에 primary key  지정 가능  
CREATE TABLE userTbl  
(  userID  char(8) NOT NULL,   
  name    varchar(10) NOT NULL,  
  birthYear   int NOT NULL,   
  addr   char(2) NOT NULL, 
  mobile1 char(3) NULL,  
  mobile2   char(8) NULL,  
  height    smallint NULL,  
  mDate    date NULL,  
  CONSTRAINT PRIMARY KEY PK_userTbl_userID (userID) 
); 
 
DROP TABLE IF EXISTS userTbl; 
 
-- 3 
-- 데이블 만든 상태에서 제약조건 지정하고 싶을 때  alter table(테이블 수정)
CREATE TABLE userTbl  
( userID  char(8) NOT NULL,  
  name    varchar(10) NOT NULL,  
  birthYear   int NOT NULL,   
  addr   char(2) NOT NULL, 
  mobile1 char(3) NULL,  
  mobile2   char(8) NULL,  
  height    smallint NULL,  
  mDate    date NULL 
); 
ALTER TABLE userTbl 
 ADD CONSTRAINT PK_userTbl_userID  
        PRIMARY KEY (userID); 
        
ALTER TABLE userTbl 
 ADD CONSTRAINT PK_userTbl_userID  
        unique KEY (addr); 

 
 DESCRIBE userTBL; 
 
 

 
--  2개의 칼럼을 묶어서 primary key지정
-- 훨씬 더 unique한 조합의 데이터 생성
 
DROP TABLE IF EXISTS prodTbl; 
 
CREATE TABLE prodTbl 
( prodCode CHAR(3) NOT NULL, 
  prodID   CHAR(4)  NOT NULL, 
  prodDate DATETIME  NOT NULL, 
  prodCur  CHAR(10) NULL 
); 
ALTER TABLE prodTbl 
 ADD CONSTRAINT PK_prodTbl_proCode_prodID  
 PRIMARY KEY (prodCode, prodID) ; 
 
 
  DESCRIBE prodTbl; 
 
DROP TABLE IF EXISTS prodTbl; 
 
CREATE TABLE prodTbl 
( prodCode CHAR(3) NOT NULL, 
  prodID   CHAR(4)  NOT NULL, 
  prodDate DATETIME  NOT NULL, 
  prodCur  CHAR(10) NULL, 
  CONSTRAINT PK_prodTbl_proCode_prodID  
 PRIMARY KEY (prodCode, prodID)  
); 
 
DROP TABLE IF EXISTS prodTbl; 
 
CREATE TABLE prodTbl 
( prodCode CHAR(3) NOT NULL, 
  prodID   CHAR(4)  NOT NULL, 
  prodDate DATETIME  NOT NULL, 
  prodCur  CHAR(10) NULL, 
  PRIMARY KEY (prodCode, prodID)  
); 
 
 
 
-- Foreign Key  
-- 두 테이블의 관계 선언, 데이터의 무결성(특정 컬럼 일치성)을 보장 
-- 기준키 테이블, 외래 키 테이블 
-- 외래키 테이블에 데이터를 입력 시, 기준키 테이블에 데이터가 존재해야 (jpy예제)
-- 기준키 테이블의 참조 열은 반드시 unique or primary key이어야 
 
 
DROP TABLE IF EXISTS buyTbl, userTbl; 

-- 만약 userID가 primary key 가 아니라면 밑에 코드 에러
-- 참조 불가, 참조받는 데이블엔 primary key가 있어야 한다. 
CREATE TABLE userTbl  
( userID  char(8) NOT NULL PRIMARY KEY,   
  name    varchar(10) NOT NULL,  
  birthYear   int NOT NULL,   
  addr   char(2) NOT NULL, 
  mobile1 char(3) NULL,  
  mobile2   char(8) NULL,  
  height    smallint NULL,  
  mDate    date NULL 
); 
 
 
-- 1 
CREATE TABLE buyTbl  
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY ,  
   userid  char(8) NOT NULL , 
   FOREIGN KEY(userid) REFERENCES userTbl(userID), 
   prodName char(6) NOT NULL, 
   groupName char(4) NULL ,  
   price     int  NOT NULL, 
   amount    smallint  NOT NULL    
); 
 
DROP TABLE IF EXISTS buyTbl; 
 
-- 2 

-- FK_userTbl_buyTbl 원하는 이름 지정하고 싶을 때 사용하는 code
CREATE TABLE buyTbl  
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   userid  char(8) NOT NULL, 
   prodName char(6) NOT NULL, 
   groupName char(4) NULL ,  
   price     int  NOT NULL, 
   amount    smallint  NOT NULL,  
   CONSTRAINT FK_userTbl_buyTbl FOREIGN KEY(userid) REFERENCES userTbl(userID) 
); 
 
-- 3 
CREATE TABLE buyTbl  
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   userid  char(8) NOT NULL, 
   prodName char(6) NOT NULL, 
   groupName char(4) NULL ,  
   price     int  NOT NULL, 
   amount    smallint  NOT NULL,  
   FOREIGN KEY(userid) REFERENCES userTbl(userID) 
); 
 
 
DROP TABLE IF EXISTS buyTbl, userTbl ; 
 
-- 4 
CREATE TABLE userTbl  
( userID  char(8) NOT NULL PRIMARY KEY,   
  name    nvarchar(10) NOT NULL,  
  birthYear   int NOT NULL,   
  addr   char(2) NOT NULL, 
  mobile1 char(3) NULL,  
  mobile2   char(8) NULL,  
  height    smallint NULL,  
  mDate    date NULL 
 ); 
  
CREATE TABLE buyTbl  
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   userid  char(8) NOT NULL, 
   prodName char(6) NOT NULL, 
   groupName char(4) NULL ,  
   price     int  NOT NULL, 
   amount    smallint  NOT NULL  
); 
 
ALTER TABLE buyTbl 
    ADD CONSTRAINT FK_userTbl_buyTbl  
    FOREIGN KEY (userid)  
    REFERENCES userTbl(userID); 

-- 
show index from buytbl; 
show index from usertbl; 
 
 
 
-- on delete cascade, on update cascade -- \ 

-- 참조하고 있는 데이블 수정, 삭제
-- 기준 테이블의 데이터가 변경 시 외래키 테이블에도 자동 반영 
 
 
ALTER TABLE buyTbl 
 DROP FOREIGN KEY FK_userTbl_buyTbl; -- 외래 키 제거 
 
ALTER TABLE buyTbl 
 ADD CONSTRAINT FK_userTbl_buyTbl 
 FOREIGN KEY (userID) 
 REFERENCES userTbl (userID) 
 ON UPDATE CASCADE; 
 
 
 
-- Unique 
 
 DROP TABLE IF EXISTS buyTbl, userTbl ; 
 
CREATE TABLE userTbl  
( userID  char(8) NOT NULL PRIMARY KEY, 
  name    nvarchar(10) NOT NULL,  
  birthYear   int NOT NULL,   
  addr   char(2) NOT NULL, 
  mobile1 char(3) NULL,  
  mobile2   char(8) NULL,  
  height    smallint NULL,  
  mDate    date NULL, 
  email   char(30) NULL  UNIQUE 
); 
 
CREATE TABLE userTbl  
( userID  char(8) NOT NULL PRIMARY KEY, 
  name    nvarchar(10) NOT NULL,  
  birthYear   int NOT NULL,   
  addr   char(2) NOT NULL, 
  mobile1 char(3) NULL,  
  mobile2   char(8) NULL,  
  height    smallint NULL,  
  mDate    date NULL, 
  email   char(30) NULL ,   
  CONSTRAINT AK_email  UNIQUE (email) 
); 
 
 
 
 
-- Defualt 
 
drop database testdb; 
 
CREATE DATABASE IF NOT EXISTS testDB; 
use testDB; 
DROP TABLE IF EXISTS userTbl; 
 
-- 1 
CREATE TABLE userTbl  
( userID   char(8) NOT NULL PRIMARY KEY,   
  name     varchar(10) NOT NULL,  
  birthYear int NOT NULL DEFAULT -1, 
  addr    char(2) NOT NULL DEFAULT '서울', 
  mobile1 char(3) NULL,  
  mobile2 char(8) NULL,  
  height smallint NULL DEFAULT 170,  
  mDate     date NULL 
); 
 
alter table usertbl
	add constraint email_unique_key unique key(email);
 
 
use testDB; 
DROP TABLE IF EXISTS userTbl; 
CREATE TABLE userTbl  
( userID char(8) NOT NULL PRIMARY KEY,   
  name  varchar(10) NOT NULL,  
  birthYear int NOT NULL , 
  addr  char(2) NOT NULL, 
  mobile1 char(3) NULL,  
  mobile2 char(8) NULL,  
  height smallint NULL,  
  mDate date NULL  
); 
 
-- 2 
ALTER TABLE userTbl 
 ALTER COLUMN birthYear SET DEFAULT -1; 
ALTER TABLE userTbl 
 ALTER COLUMN addr SET DEFAULT '서울'; 
ALTER TABLE userTbl 
 ALTER COLUMN height SET DEFAULT 170; 
 
 
 
-- default 문은 DEFAULT로 설정된 값을 자동 입력한다. 
INSERT INTO userTbl VALUES ('LHL', '이혜리', default, default, '011', '1234567', default, '2019.12.12'); 
-- 반드시 열이름이 명시되지 않으면 DEFAULT로 설정된 값을 자동 입력한다 
INSERT INTO userTbl(userID, name) VALUES('KAY', '김아영'); 
-- 값이 직접 명기되면 DEFAULT로 설정된 값은 무시된다. 
INSERT INTO userTbl VALUES ('WB', '원빈', 1982, '대전', '019', '9876543', 176, '2017.5.5'); 
SELECT * FROM userTbl; 
 
 
 
 
-- <데이터 압축> --   
 
 
-- 시스템변수 확인 
SHOW VARIABLES LIKE 'innodb_file_format';  -- barracuda
SHOW VARIABLES LIKE 'innodb_large_prefix'; -- on
 
 
 
CREATE DATABASE IF NOT EXISTS compressDB; 
USE compressDB; 

-- 기존 방식 테이블
CREATE TABLE normalTBL( emp_no int , first_name varchar(14)); 

-- 압축 방식 테이블
CREATE TABLE compressTBL( emp_no int , first_name varchar(14)) 
 ROW_FORMAT=COMPRESSED ; 
 
 
 
 -- INSERT INTO normalTbl  values(값)
 -- INSERT INTO normalTbl  SELECT(외부 데이터 가져오기) from 데이터베이스.테이블이름
INSERT INTO normalTbl  
     SELECT emp_no, first_name FROM employees.employees;    
INSERT INTO compressTBL  
     SELECT emp_no, first_name FROM employees.employees; 
      
      
 -- data_length(용량 1/2배), data_free 비교 but 처리 속도에서 손해가 있음(속도 느려짐)
SHOW TABLE STATUS FROM compressDB; 
 
DROP DATABASE IF EXISTS compressDB; 
 
 
 
 
 
 
-- 임시 테이블 - 잠시 사용하는 테이블, section 접속한 기간동안에만 잠시 사용
-- 세션 내에서만 사용, 생성한 클라이언트만 사용 가능 
-- 임시테이블 삭제 - drop table, workbench 종료, mysql서비스 재시작 
 

 
 
 --  집모양 아이콘 눌러 section다르게
 --  section 벗어나면 temporary table 적용 안되고 기존에 있던 데이터를 불러오게 됨.
USE employees; 
CREATE TEMPORARY TABLE  IF NOT EXISTS  tempTBL (id INT, name CHAR(5)); 
CREATE TEMPORARY TABLE  IF NOT EXISTS employees (id INT, name CHAR(5)); 
DESCRIBE tempTBL; 
DESCRIBE employees; 
 
INSERT INTO tempTBL VALUES (1, 'This'); 
INSERT INTO employees VALUES (2, 'MySQL'); 
SELECT * FROM tempTBL; 
SELECT * FROM employees; 
 
USE employees; 
SELECT * FROM tempTBL; 
SELECT * FROM employees; 
 
USE employees; 
SELECT * FROM employees; 
 
 
 
 
 
 
-- 테이블 삭제 
-- drop table 테이블 이름 
--  외래키 제약 조건의 기준 테이블은 삭제할 수 없다 
-- 먼저 외래키 테이블을 삭제해야 한다. 
-- buytbl을 먼저 삭제 후 usertbl을 삭제해야 
 
 use tabledb;
 drop table usertbl;
 
 show index from usertbl;
 
 
-- 테이블 수정-- 
-- (갑 수정)
-- cf. insert, delete, update 

-- (구조 수정)
-- alter table table_name add column 
-- alter table table_name change column 
-- alter table table_name drop column/ primary key/ foreign key 
 
 
 
USE tableDB; 
ALTER TABLE userTbl 
 ADD homepage VARCHAR(30)  -- 열추가 
  DEFAULT 'http://www.hanbit.co.kr' -- 디폴트값 
  NULL; -- Null 허용함 
         
select * from usertbl; 
 
ALTER TABLE userTbl 
 DROP COLUMN mobile1; 
     
select * from usertbl; 
 
ALTER TABLE userTbl 
 CHANGE COLUMN name uName VARCHAR(20) NULL ; 
     
select * from usertbl; 
 
show index from usertbl; 
 
 
/* 
ALTER TABLE userTbl 
 ADD CONSTRAINT PK_userTbl_userID  
        PRIMARY KEY (userID); 
 
ALTER TABLE buyTbl 
 ADD CONSTRAINT FK_userTbl_buyTbl 
 FOREIGN KEY (userID) 
 REFERENCES userTbl (userID) 
    */ 
 
 
ALTER TABLE userTbl 
 DROP PRIMARY KEY; -- error 
     
show index from usertbl; 
 
show index from buytbl; 
 
ALTER TABLE buyTbl 
 DROP FOREIGN KEY fk_usertbl_buytbl; 
 
ALTER TABLE userTbl 
 DROP PRIMARY KEY;  
     
show index from usertbl; 

 
 
 
 
create database tabledb; 
USE tableDB; 
DROP TABLE IF EXISTS buyTbl, userTbl; 
CREATE TABLE userTbl  
( userID  char(8),  
  name    nvarchar(10), 
  birthYear   int,   
  addr   nchar(2),  
  mobile1 char(3),  
  mobile2   char(8),  
  height    smallint,  
  mDate    date  
); 
CREATE TABLE buyTbl  
(  num int AUTO_INCREMENT PRIMARY KEY, 
   userid  char(8), 
   prodName nchar(6), 
   groupName nchar(4), 
   price     int , 
   amount    smallint 
); 
 
INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8'); 
INSERT INTO userTbl VALUES('KBS', '김범수', NULL, '경남', '011', '2222222', 173, '2012-4-4'); 
INSERT INTO userTbl VALUES('KKH', '김경호', 1871, '전남', '019', '3333333', 177, '2007-7-7'); 
INSERT INTO userTbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4'); 
INSERT INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2); 
INSERT INTO buyTbl VALUES(NULL,'KBS', '노트북', '전자', 1000, 1); 
INSERT INTO buyTbl VALUES(NULL,'JYP', '모니터', '전자', 200,  1); 
INSERT INTO buyTbl VALUES(NULL,'BBK', '모니터', '전자', 200,  5); 
 
select * from usertbl; 
select * from buytbl; 
 
 
 
 
ALTER TABLE userTbl 
 ADD CONSTRAINT PK_userTbl_userID 
 PRIMARY KEY (userID); 
 
ALTER TABLE buyTbl 
 ADD CONSTRAINT FK_userTbl_buyTbl 
 FOREIGN KEY (userID) 
 REFERENCES userTbl (userID); -- error - BBK가 usertbl에 없어서 에러 발생
 

delete FROM buyTbl WHERE userid = 'BBK'; 
-- BBK를 삭제

ALTER TABLE buyTbl 
 ADD CONSTRAINT FK_userTbl_buyTbl 
 FOREIGN KEY (userID) 
 REFERENCES userTbl (userID); 
 
INSERT INTO buyTbl VALUES(NULL,'BBK', '모니터', '전자', 200,  5); -- 오류 
 

 
 
SET foreign_key_checks = 0; -- 외래키조건 해제 
INSERT INTO buyTbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5); 
INSERT INTO buyTbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3); 
INSERT INTO buyTbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10); 
INSERT INTO buyTbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5); 
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2); 
INSERT INTO buyTbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1); 
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2); 
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1); 
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2); 
SET foreign_key_checks = 1; -- 외래키조건 재설정 
 
 
 
-- check - mysql에서 지원하지 않는다 
select * from usertbl; 
 
ALTER TABLE userTbl 
 ADD CONSTRAINT CK_birthYear 
 CHECK  (birthYear >= 1900 AND birthYear <= YEAR(CURDATE())) ; 
 
INSERT INTO userTbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL , 186, '2013-12-12'); 
INSERT INTO userTbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9'); 
INSERT INTO userTbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL , 170, '2005-5-5'); 
INSERT INTO userTbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3'); 
INSERT INTO userTbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10'); 
INSERT INTO userTbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5'); 
 

 
select * from usertbl; 
 
 
-- update 
 
 
 
UPDATE userTbl SET userID = 'VVK' WHERE userID='BBK';  -- error 
 
SET foreign_key_checks = 0; 
UPDATE userTbl SET userID = 'VVK' WHERE userID='BBK'; 
SET foreign_key_checks = 1; 
 
 
SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2  AS '연락처' -- 4건 부족 
   FROM buyTbl B 
     INNER JOIN userTbl U 
        ON B.userid = U.userid ; 
 
SELECT COUNT(*) FROM buyTbl; 
select * from buytbl; 

select * FROM usertbl;
 
SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2  AS '연락처' 
   FROM buyTbl B 
     LEFT OUTER JOIN userTbl U 
        ON B.userid = U.userid 
   ORDER BY B.userid ; 
 
 -- 동일성이 사라져버림 이런식으로 값을 수정해주면,
SET foreign_key_checks = 0; 
UPDATE userTbl SET userID = 'BBK' WHERE userID='VVK'; 
SET foreign_key_checks = 1; 
 
 
ALTER TABLE buyTbl 
 DROP FOREIGN KEY FK_userTbl_buyTbl; 
     
     
     
     
-- on update cascade 
 
alter table usertbl 
add constraint primary key (userid); 

--  ON UPDATE CASCADE 기본키에서 값을 바꾸면 외래키에도 자동으로 값이 변함.
ALTER TABLE buyTbl  
 ADD CONSTRAINT FK_userTbl_buyTbl 
  FOREIGN KEY (userID) 
  REFERENCES userTbl (userID) 
  ON UPDATE CASCADE; 
 
UPDATE userTbl SET userID = 'VVK' WHERE userID='BBK'; 
SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2  AS '연락처' -- 함계 수정 
   FROM buyTbl B 
     INNER JOIN userTbl U 
        ON B.userid = U.userid 
  ORDER BY B.userid; 
  
select * FROM BUYTBL;
 
DELETE FROM userTbl WHERE userID = 'VVK'; -- 삭제 안 딤 
 
 
ALTER TABLE buyTbl 
 DROP FOREIGN KEY FK_userTbl_buyTbl; 
ALTER TABLE buyTbl  
 ADD CONSTRAINT FK_userTbl_buyTbl 
  FOREIGN KEY (userID) 
  REFERENCES userTbl (userID) 
  ON UPDATE CASCADE 
  ON DELETE CASCADE; 
 
DELETE FROM userTbl WHERE userID = 'VVK';  -- 함께 삭제됨 
 
SELECT * FROM buyTbl ;    
 
ALTER TABLE userTbl 
 DROP COLUMN birthYear ; 
 
 
 
 
-- < view > -- 
--  하나의 가상테이블을 만들어줌
 
USE tableDB; 
CREATE VIEW v_userTbl 
AS 
 SELECT userid, name, addr FROM userTbl; 
 
SELECT * FROM v_userTbl;  -- 뷰를 테이블이라고 생각해도 무방 
 
/* 
1. 보안에 도움 
2. 복잡한 쿼리를 단순화 
*/ 
 
SELECT U.userid, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처' 
FROM userTbl U 
  INNER JOIN buyTbl B 
     ON U.userid = B.userid ; 
 
CREATE VIEW v_userbuyTbl 
AS 
SELECT U.userid, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처' 
FROM userTbl U 
 INNER JOIN buyTbl B 
  ON U.userid = B.userid ; 
 
SELECT * FROM v_userbuyTbl WHERE name = '김범수'; 
 
 
/*
CREATE DATABASE sqlDB; 
 
USE sqlDB; 
CREATE TABLE userTbl -- 회원 테이블 
( userID   CHAR(8) NOT NULL PRIMARY KEY, -- 사용자아이디 
  name     VARCHAR(10) NOT NULL, -- 이름 
  birthYear INT NOT NULL,  -- 출생년도 
  addr    CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력) 
  mobile1 CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등) 
  mobile2 CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외) 
  height     SMALLINT,  -- 키 
  mDate     DATE  -- 회원 가입일 
); 
CREATE TABLE buyTbl -- 회원 구매 테이블 
(  num   INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK) 
   userID   CHAR(8) NOT NULL, -- 아이디(FK) 
   prodName  CHAR(6) NOT NULL, --  물품명 
   groupName  CHAR(4)  , -- 분류 
   price      INT  NOT NULL, -- 단가 
   amount     SMALLINT  NOT NULL, -- 수량 
   FOREIGN KEY (userID) REFERENCES userTbl(userID) 
); 
 
INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8'); 
INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4'); 
INSERT INTO userTbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7'); 
INSERT INTO userTbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4'); 
INSERT INTO userTbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12'); 
INSERT INTO userTbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9'); 
INSERT INTO userTbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5'); 
INSERT INTO userTbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3'); 
INSERT INTO userTbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10'); 
INSERT INTO userTbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5'); 
INSERT INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2); 
INSERT INTO buyTbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1); 
INSERT INTO buyTbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1); 
INSERT INTO buyTbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5); 
INSERT INTO buyTbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3); 
INSERT INTO buyTbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10); 
INSERT INTO buyTbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5); 
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2); 
INSERT INTO buyTbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1); 
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2); 
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1); 
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2); 
*/ 
 
USE sqlDB; 
CREATE VIEW v_userbuyTbl 
AS 
   SELECT U.userid AS 'USER ID', U.name AS 'USER NAME', B.prodName AS 'PRODUCT NAME',  
  U.addr, CONCAT(U.mobile1, U.mobile2) AS 'MOBILE PHONE' 
      FROM userTbl U 
 INNER JOIN buyTbl B 
  ON U.userid = B.userid; 
 
SELECT `USER ID`, `USER NAME` FROM v_userbuyTbl; -- 주의! 백틱을 사용한다.` ` 
# SELECT 'USER ID', 'USER NAME' FROM v_userbuyTbl; 
 
 
ALTER VIEW v_userbuyTbl 
AS 
   SELECT U.userid AS '사용자 아이디', U.name AS '이름', B.prodName AS '제품 이름',  
  U.addr, CONCAT(U.mobile1, U.mobile2)  AS '전화 번호' 
      FROM userTbl U 
          INNER JOIN buyTbl B 
             ON U.userid = B.userid ; 
 
SELECT `이름`,`전화 번호` FROM v_userbuyTbl; 
 
DROP VIEW v_userbuyTbl; 
 
/* 
view를 사용하는 이유 
1. 보안에 도움이 된다. 
2. 복잡한 쿼리를 단순화한다. 
*/ 
 
USE sqlDB; 
CREATE OR REPLACE VIEW v_userTbl 
AS 
 SELECT userid, name, addr FROM userTbl; 
 
DESCRIBE v_userTbl; 
 
# SHOW CREATE VIEW v_userTbl; 
 
UPDATE v_userTbl SET addr = '부산' WHERE userid='JKW' ; 
 
INSERT INTO v_userTbl(userid, name, addr) VALUES('KBM','김병만','충북') ; 
 
CREATE VIEW v_sum 
AS 
 SELECT userid AS 'userid', SUM(price*amount) AS 'total'   
    FROM buyTbl GROUP BY userid; 
 
SELECT * FROM v_sum; 
 
SELECT * FROM INFORMATION_SCHEMA.VIEWS     -- 시스템에 저장된 모든 뷰 
     WHERE TABLE_SCHEMA = 'sqlDB' AND TABLE_NAME = 'v_sum'; 

 
CREATE VIEW v_height177 
AS 
 SELECT * FROM userTbl WHERE height >= 177 ; 
 
SELECT * FROM v_height177 ; 
 
DELETE FROM v_height177 WHERE height < 177 ; 
 
INSERT INTO v_height177 VALUES('KBM', '김병만', 1977 , '경기', '010', '5555555', 158, '2019-01-01') ; 
 
INSERT INTO v_height177 VALUES('KBM', '김병만', 1977 , '경기', '010', '5555555', 158, '2019-01-01') ; -- 뷰에는 보이지 않지 만 입력된다 
select * from usertbl; 
ALTER VIEW v_height177 
AS 
 SELECT * FROM userTbl WHERE height >= 177 
     WITH CHECK OPTION ; -- 입력차단 
 
INSERT INTO v_height177 VALUES('WDT', '서장훈', 2006 , '서울', '010', '3333333', 155, '2019-3-3') ; 
 
CREATE VIEW v_userbuyTbl 
AS 
  SELECT U.userid, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS mobile 
   FROM userTbl U 
      INNER JOIN buyTbl B 
         ON U.userid = B.userid ; 
 
INSERT INTO v_userbuyTbl VALUES('PKL','박경리','운동화','경기','00000000000','2020-2-2'); -- 두 개 이상의 테이블이 연결된 뷰는 업데이트할 수 없다 

 
DROP TABLE IF EXISTS buyTbl, userTbl; 
 
SELECT * FROM v_userbuyTbl; 
 
CHECK TABLE v_userbuyTbl; -- 뷰의 상태 체크 