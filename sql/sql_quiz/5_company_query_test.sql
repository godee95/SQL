
create database company;

use company;



CREATE TABLE CUST_INFO

(

	RESIDENCE_ID CHAR(13) PRIMARY KEY NOT NULL,
    
    sex int,

	FIRST_NM CHAR(10) NOT NULL,

	LAST_NM CHAR(10) NOT NULL,

	ANNL_PERF DECIMAL(15,2)

);



INSERT INTO CUST_INFO VALUES ('8301111999999', 0, 'JIHUN', 'KIM', 330.08);

INSERT INTO CUST_INFO VALUES ('7012012888888', 1,'JINYOUNG', 'LEE', 857.61);

INSERT INTO CUST_INFO VALUES ('6705302777666', 1,'MIJA', 'HAN', -76.77);

INSERT INTO CUST_INFO VALUES ('8411011555666', 0,'YOUNGJUN', 'HA', 468.54);

INSERT INTO CUST_INFO VALUES ('7710092666777', 1,'DAYOUNG', 'SUNG', -890);

INSERT INTO CUST_INFO VALUES ('7911022444555', 1,'HYEJIN', 'SEO', 47.44);



select * from cust_info;





-- 1.남성은 m로 여성은 f로 출력하시어

-- sql에선 if문보다 case문을 많이 씀

select case sex
	when 0 then 'm'
    else 'f'
end 
from cust_info;

-- 2. 이메일을 보내기 위해 성과 이름을 결합하시오
select  concat(last_nm, ' ', first_nm) as '이름' from cust_info; 

-- 3. 고객의 수익을 소수점 첫 째자리에서 반올림하시오. 
select ANNL_PERF from cust_info;

-- 소수점 이하에선 round와 format이 반올림함.
-- 하지만 정수 부분 -1과 같은 경우 round는 반올림
-- format은 자릿수 하나 전에서 반올림해서 기능이 다르다.
select round(ANNL_PERF, 1) from cust_info;
select format(ANNL_PERF, 1) from cust_info;
-- substr 잘라내는 거






create table vendor_info(

id int,

name char(10),

country char(20));





insert into vendor_info values 

(1, 'sue', 'germany'),

(2, 'david', 'switzerland'),

(3, 'sam', 'france'),

(4, 'jihoon', 'brazil'),

(5, 'sunwoo', 'france'),

(6, 'berney', 'italy'),

(7, 'sandy', 'germany'),

(8, 'young', 'korea') ;


select * from vendor_info;


-- 1. 이름을 소문자로 변환해서 출력하시오
select lower(name) from vendor_info;

-- 2. 이름을 대문자로 변환해서 출력하시오
select upper(name) from vendor_info;

-- 3. 이름의 길이를 name_len라는 별칭으로 출력하시오
select length(name) as name_len
	from vendor_info;

-- 4. 이름의 두 번째에서 네 번째 글자를 출력하고 name_str이라는 별칭으로 출력하시오
select substring(name, 2, 3) as name_str
	from vendor_info;
    
select mid(name, 2, 3) as name_str
	from vendor_info;










create table clerk (

id int,

staff_nm char(5),

def_nm char(10),

gender char(2),

birth_dt date,

emp_flag char(2) );



insert into clerk values 

(135, '이민성', '마케팅부', 'm', '1984-02-11', 'y'),

(142, '김선명', '영업지원부', 'm', '1971-12-08', 'y'),

(121, '신지원', '리스크부', 'f', '1978-05-28','y'),

(334, '고현정', '전략기획부', 'f', '1965-01-12', 'y'),

(144, '이기동', '마케팅분석부', 'm', '1981-03-03', 'y'),

(703, '송지희', '검사부', 'f', '1985-05-14', 'f'),

(732, '연승환', '기업영업지원부', 'm', '1990-01-26', 'y'),

(911, '이명준', '여의도지점', 'm', '1988-06-11', 'n');


select * from clerk;


-- 1. 직원의 생일을 기준으로 내림차순으로 정렬하시오
select * from clerk
	order by birth_dt desc;

-- 2. 직원의 나이를 구하시오
select staff_nm, 2019-left(birth_dt, 4) as '직원 나이'
	from clerk;
    
select staff_nm, 
	floor(datediff( now(), birth_dt )/365 ) as age
	from clerk;

select staff_nm, 
	year( now() ) - year(birth_dt) as age
	from clerk
	order by age;

-- 3. 직원의 생일에 1달을 더한 날짜를 구하시오
select staff_nm, birth_dt,
	adddate(birth_dt, 30) from clerk;


-- 4. 남성의 평균 나이와 여성의 평균 나이를 구하시오
select gender,round(avg(year( now() )- year(birth_dt))) 
	as '평균나이'
	from clerk
	group by gender;

-- 5. 평균 연령이 가장 낮은 부서는 어디인가 
select def_nm, round(avg(year( now() )- year(birth_dt))) 
	as '평균연령'
	from clerk
	group by def_nm
    order by 평균연령
    limit 1;
    






select * from cust_info;



-- 1. 고객이 남성이면 1, 여성이면 2를 출력하시오.

-- 2. 남성의 평균 수익과 여성의 평균 수익을 구하시오
select sex, avg(ANNL_PERF)
	from cust_info
	group by sex;


-- 3. 수익이 가장 높은 고객의 이름을 출력하시오
select concat(last_nm, ' ', FIRST_NM) as '고객이름',
	ANNL_PERF from cust_info
    order by ANNL_PERF
    limit 1;


