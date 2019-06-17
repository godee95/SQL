use testdb;
CREATE TABLE RCPT_ACCT

(

	SSN CHAR(13) NOT NULL,
	ACCT_NO CHAR(10) primary KEY NOT NULL,
	NEW_DT DATE,
	CNCL_DT DATE,
	RCPT_AMT DECIMAL(15,0)

);



INSERT INTO RCPT_ACCT VALUES ('5707121111000', '578221', '2012-03-26', null, 500000);
INSERT INTO RCPT_ACCT VALUES ('7706302222111', '687322', '2011-12-22', '2013-12-01', 0);
INSERT INTO RCPT_ACCT VALUES ('6508112222333', '658720', '2013-06-08', null, 41324);
INSERT INTO RCPT_ACCT VALUES ('8204073333111', '554520', '2013-09-28', null, 5678740);
INSERT INTO RCPT_ACCT VALUES ('5707121111000', '656421', '2009-11-17', null, 354210);
INSERT INTO RCPT_ACCT VALUES ('7706302222111', '668721', '2010-07-27', null, 547700);
INSERT INTO RCPT_ACCT VALUES ('8204073333111', '223620', '2010-09-11', null, 1000357);
INSERT INTO RCPT_ACCT VALUES ('8204073333111', '275123', '2013-11-26', null, 123000);







CREATE TABLE CUST_PARTY

(

	SSN CHAR(13) PRIMARY KEY NOT NULL,
	PARTY_NM CHAR(10) NOT NULL,
	CUST_ID CHAR(10) NOT NULL,
	TEL_NO CHAR(20) NOT NULL,
	MOBILE_NO CHAR(20) NOT NULL

);



INSERT INTO CUST_PARTY VALUES ('5707121111000', 'AR KIM', '5670', '02-555-6678', '010-1111-1111');
INSERT INTO CUST_PARTY VALUES ('6912081111222', 'SH HONG', '2357', '031-4456-9887', '010-2222-2222');
INSERT INTO CUST_PARTY VALUES ('8311221111333', 'MK KANG', '3977', '051-999-8888', '010-3333-3333');
INSERT INTO CUST_PARTY VALUES ('7105252222000', 'JH KIM', '8988', '032-333-1111', '010-4444-4444');
INSERT INTO CUST_PARTY VALUES ('7706302222111', 'JH LEE', '7702', '033-111-3355', '010-5555-5555');
INSERT INTO CUST_PARTY VALUES ('6508112222333', 'JH RYU', '3574', '02-6666-4444', '010-6666-6666');
INSERT INTO CUST_PARTY VALUES ('8204073333111', 'YC JUNG', '5670', '02-2222-1111', '010-7777-7777');
INSERT INTO CUST_PARTY VALUES ('8911293333222', 'JH JUN', '6989', '031-224-2222', '010-8888-8888');
INSERT INTO CUST_PARTY VALUES ('9011034444111', 'SH LEE', '5570', '033-333-3333', '010-9999-9999');


select * from RCPT_ACCT;
select * from CUST_PARTY;


-- 1. 현재 계좌가 살아있는 고객의 휴대폰 번호를 찾고, 
--   살아있는 계좌수를 기준으로 오름차순 정렬하시오

select * from cust_party as cp left join rcpt_acct as ra
	on cp.ssn = ra.ssn
		where ra.cncl_dt is null
        order by num_acct;
        
select mobile_no, count(ACCT_NO) as num_acct
	from cust_party cp left join rcpt_acct ra
		on cp.ssn = ra.ssn
        where CNCL_DT is null
        group by cp.ssn
        order by num_acct;

select tmp1.ssn, tmp1.MOBILE_NO, tmp2.cnt
	from cust_party tmp1
    left outer join(
		select ssn, count(*) as cnt from rcpt_acct
        where CNCL_DT is null group by 1) tmp2
	on tmp1.ssn = tmp2.ssn
    where cnt >= 1
    order by 3;

-- 2. 현재 살아있는 계좌수가 두 개 이상이고 수신잔액의 총합이 50만원 이상인 고객의 
--   주민번호, 이름, 휴대전화, 계좌수, 수신잔액 총합을 주민번호기준으로 오름차순 정렬하시오.

select tmp1.ssn, tmp1.party_nm, tmp1.mobile_no,
	tmp2.cnt, tmp2.rcpt_amt from cust_party tmp1
    left outer join
    (select ssn, count(*) as cnt,
    sum(RCPT_AMT) as rcpt_amt from rcpt_acct
    where CNCL_DT is null
    group by ssn) tmp2 on tmp1.ssn=tmp2.ssn
    where cnt >= 2 and rcpt_amt >= 500000
    order by tmp1.ssn;
    
-- left outer join a집합만
-- inner join 교집합
select tmp1.ssn, tmp1.party_nm, tmp1.mobile_no,
	tmp2.cnt, tmp2.rcpt_amt from cust_party tmp1
    left outer join
    (select ssn, count(*) as cnt,
    sum(RCPT_AMT) as rcpt_amt from rcpt_acct
    where CNCL_DT is null
    group by 1) tmp2 on tmp1.ssn=tmp2.ssn
    where cnt >= 2 and rcpt_amt >= 500000
    order by 1;
    
