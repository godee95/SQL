use testdb;

CREATE TABLE PPC_MAST_201312
(
	SSN CHAR(13) NOT NULL,
	ACCT_NO CHAR(10) NOT NULL,
	ACCT_CD DECIMAL(10) NOT NULL,
	PRFT DECIMAL(15,0),
	BALANCE_AMT DECIMAL(15,0)
);

INSERT INTO PPC_MAST_201312 VALUES ('7802221111111', '22033', 130, 504, 56746);
INSERT INTO PPC_MAST_201312 VALUES ('8307153333444', '54412', 110, 585, 23540);
INSERT INTO PPC_MAST_201312 VALUES ('5605099999222', '65433', 340, 213, 987800);
INSERT INTO PPC_MAST_201312 VALUES ('8012301111333', '58721', 320, 780, 310000);
INSERT INTO PPC_MAST_201312 VALUES ('6711032222111', '23422', 120, 5679, 3);
INSERT INTO PPC_MAST_201312 VALUES ('8910103333222', '89811', 310, 240, 40011);
INSERT INTO PPC_MAST_201312 VALUES ('7802221111111', '78022', 100, 899, 4565000);
INSERT INTO PPC_MAST_201312 VALUES ('6711032222111', '35714', 300, 3780, 2545640);
INSERT INTO PPC_MAST_201312 VALUES ('8910103333222', '68740', 310, 233, 522312);
INSERT INTO PPC_MAST_201312 VALUES ('5605099999222', '96870', 330, 7000, 2158);
INSERT INTO PPC_MAST_201312 VALUES ('7802221111111', '89770', 140, 1000, 566600);
INSERT INTO PPC_MAST_201312 VALUES ('6711032222111', '33270', 130, 5600, 68770);
INSERT INTO PPC_MAST_201312 VALUES ('7802221111111', '87890', 340, 1270, 5500000);

select * from PPC_MAST_201312;

-- 고객계좌별 수익
-- SSN CHAR(13) - 주민번호
-- ACCT_NO - 계좌번호
-- ACCT_CD - 종별 코드 (수신 : 100, 110, 120, 130, 140/ 여신 - 300, 310, 320, 330, 340  )
-- PRFT - 수익
-- BALANCE_AMT - 잔액


-- 1. 수신액은 1, 여신은 0으로 구분하고 각각 총액을 구하시오

select (case 
	when ACCT_CD like '1%'
		then 1
	when ACCT_CD like '3%'
		then 0 end) as 종별코드,
	sum(PRFT) + sum(BALANCE_AMT) as 총액
	from PPC_MAST_201312
    group by 종별코드;

    
select (case 
	when ACCT_CD in(100, 110, 120, 130, 140)
		then 'liability'
	when ACCT_CD in(300, 310, 320, 330, 340)
		then 'asset' end) as balanced_sheet,
        sum(BALANCE_AMT)
	from PPC_MAST_201312
    group by balanced_sheet;
        
-- 2. 고객 당 금융상품 가입수를 구하시오

select ssn, count(ACCT_CD)
	from ppc_mast_201312
    group by ssn;


-- 3. 고객당 잔액 합계가 200만원 이상인 고객을 구하시오
-- group by 조건은 having!!
select ssn, sum(BALANCE_AMT) as bas
	from ppc_mast_201312
	group by ssn
    having bas >= 2000000;
    
    
-- 4. 고객 당 금융상품 가입자수가 3개 이상인 고객을 구하시오.
select ssn, count(ACCT_NO) as acno
    from ppc_mast_201312
	group by ssn
    having acno >=3;