SELECT  empno, ename, job, mgr,
    hiredate, sal, comm, deptno
FROM emp;

--INSERT
--col순서에 맞게 넣어준다
--1번째 방법
INSERT INTO emp (empno,ename,job,mgr, hiredate,sal,comm,deptno) VALUES(1001,'ALICE','CLERK',1003,'16/4/9',800,null,30);

--2번재 방법
SELECT * FROM emp;
INSERT INTO emp VALUES(1002,'MORRIS','CLERK',1003,'16/9/2',800,null,30);

SELECT * FROM emp WHERE empno<2000; --대입한것만 봐보기

--이것으로 데이터 넣어보기
SELECT 1,2,'a','b' FROM dual; --1,2a,b가 담긴다
--1003	MATHEW	SALESMAN		20/03/30	 1500 	100	30
SELECT 1003, 'MATHEW', 'SALESMAN', NULL, sysdate, 1500,100,30 FROM dual;

--이를 이용한 서브쿼리로 INSERT 실행해보기
INSERT INTO emp
    SELECT 1003, 'MATHEW', 'SALESMAN', NULL, sysdate, 1500,100,30 FROM dual;

SELECT * FROM emp WHERE empno<2000;

--다음 두 사원의 정보를 삽입하세요 (컬럼을 지정해서 넣기)
    --1)사번 1011, 이름 EDWARD, 직무 MANAGER 
    --2)사번 1015, 이름 RICHARD, 급여 2000
--1
INSERT INTO emp(empno,ename,job) VALUES (1011,'EDWARD', 'MANAGER');
--2
INSERT INTO emp(empno,ename,sal) VALUES (1015,'RICHARD', 2000);

--commit(커밋), 데이터 변경사항 영구적으로 적용한다
--DELETE emp -->emp 테이블을 전체 삭제한다
--rollback --(롤백)데이터 변경사항을 되돌리기 --지금까지 작업했던 것을 모두 되돌린다
-- 주의깊게 조심해서 사용해야 한다

--테이블 생성 (SELECT 구문의 결과를 사본테이블로 생성한다 --복사)

CREATE TABLE emp_research AS SELECT * FROM emp;
SELECT * FROM emp_research; -- 그대로 복사됨

--테이블 삭제(DDL) --commit이나 rollback 안된다
DROP TABLE emp_research;

--빈 테이블 복사
SELECT* FROM emp WHERE 1=1;  --true를 사용하고 싶은데 기능 안됨 -> 1=1을 넣으면 관용적으로 true로 표현된다
SELECT* FROM emp WHERE 1=0;  --false를 나타냄 -> 아무것도 조회안된다

SELECT * FROM emp WHERE 1=1
        AND empno<2000; --안해도되는데 그냥한것
        
--빈 테이블 복사
CREATE TABLE emp_research AS SELECT * FROM emp WHERE 1=0; --빈테이블 복사 (컬럼명만 가져온다)
SELECT * FROM emp_research;

--20번 부서의 모든 데이터를 집어넣기

INSERT INTO emp_research
SELECT * FROM emp WHERE deptno=20; --20번 부서의 모든 행이 삽입된다(서브쿼리이용)
SELECT * FROM emp_research;

--30번 부서의 모든 데이터를 empno, ename, 만 Insert
INSERT INTO emp_research(empno, ename) 
SELECT empno,ename FROM emp WHERE deptno=30; --*이 아닌 원하는 것만 SELECT문에서 선택한다
SELECT * FROM emp_research;


--INSERT ALL
--삭제 이후에 INSERT ALL을 사용해보자

--모든데이터 삭제
DELETE emp_research;
---
--부서번호 20 넣기
INSERT ALL
    WHEN deptno=20 --조건
        THEN INTO emp_research --deptno=20일 때 emp_research 테이블에 넣는다
    SELECT * FROM emp;

SELECT * FROM emp_research;

--부서번호 20 전부, 30 empno,ename 넣기

INSERT ALL
    WHEN deptno=20
        THEN INTO emp_research
    WHEN deptno=30
        THEN INTO emp_research(empno,ename)
        VALUES (empno,ename)
SELECT * FROM emp;

SELECT * FROM emp_research;


--INSERT ALL QUIZ--

--emp를 이용해 데이터없이 emp_hire테이블 생성 (empno,ename,hiredate)
CREATE TABLE emp_hire AS SELECT empno,ename,hiredate FROM emp WHERE 1=0;
SELECT * FROM emp_hire;

--emp를 이용해 데이터 없이 emp_sal 테이블 생성(empno,ename,sal)
CREATE TABLE emp_sal AS SELECT empno,ename,sal FROM emp WHERE 1=0;
SELECT * FROM emp_sal;

--INSERT ALL 사용해서 해결하기
--emp_hre 테이블, '1981/06/01'이전사원
SELECT * FROM emp;

INSERT ALL
    WHEN hiredate<TO_DATE('81-06-01')
        THEN INTO emp_hire
SELECT empno,ename,hiredate FROM emp;

--emp_sal 테이블, 2000보다 많은 사원
INSERT ALL
    WHEN sal>2000
        THEN INTO emp_sal
SELECT empno,ename,sal FROM emp;


--함께해주기

INSERT ALL
    WHEN hiredate <'1991/06/01'
        THEN INTO emp_hire
        VALUES (empno,ename,hiredate)
    WHEN sal>2000
        THEN INTO emp_sal
        VALUES (empno,ename,sal)
SELECT * FROM emp;

--commit;  --조심해서 :영구적으로 적용
--rollback;

--테이블 삭제
DELETE emp_hire;
DELETE emp_sal;
ROLLBACK; --삭제 되었던게 돌아온다
SELECT * FROM emp_hire;
SELECT * FROM emp_sal;

SELECT * FROM emp_sal WHERE empno= 7839;

DELETE emp_sal 
--empno=7839삭제 'KING'
WHERE empno=7839;

SELECT * FROM emp_sal; --1개 삭제됨

rollback;


--UPDATE 
SELECT * FROM emp WHERE empno=1001; --'ALICE'
UPDATE emp SET ename = 'MC',job='Donald' WHERE empno=1001; --Alice-> Mc/donal로 바뀜
--commit
--rollback

--emp_hire 테이블 전체 데이터의 입사일을 현재시간으로 변경
UPDATE emp_hire SET hiredate = trunc(sysdate); --그냥 넣으면 시간이 들어가므로 데이터 낭비 -> 자정으로 들어간다
SELECT to_char(hiredate,'yyyy/mm/dd hh24:mi:ss') FROM emp_hire; --00시 00분 00초로 초기화됨
SELECT * FROM emp_hire;

--emp_sal의 사원들 전부 급여 550 인상
UPDATE emp_sal SET SAL=SAL+550;
SELECT * FROM emp_sal ORDER BY SAL;


---MERGE---
--merge에 사용할 데이터 만들기
CREATE TABLE emp_merge AS SELECT empno,ename, sal,deptno FROM emp WHERE deptno IN(10,20); --10번과 20번부서 INSERT
SELECT * FROM emp_merge ORDER BY deptno,empno;

--emp 테이블에서 20,30 부서사원들의 조회(SELECT)

-- emp_merge 테이블과 데이터 병합(MERGE)
-- 이미  테이블에 존재하는 데이터라면 sal만 30% 인상(UPDATE)
-- 테이블에 존재하는 데이터가 아니라면 삽입(INSERT)

MERGE INTO emp_merge M  --alias 안됨 왜?
USING(
    SELECT empno,ename,sal,deptno FROM emp 
    WHERE deptno IN(20,30)
    )E 
    ON (M.empno=E.empno) 
    WHEN MATCHED THEN --존재하는 데이터라면? , 20번 부서
        UPDATE SET M.sal= M.sal*1.3 --30% 인상      --UPDATE와 SET사이에 테이블명 없어도된다 
    WHEN NOT MATCHED THEN --존재하지 않는 데이터라면? , 30번부서
        INSERT (M.empno,M.ename,M.deptno, M.sal) VALUES(E.empno,E.ename,E.deptno, E.sal) WHERE E.sal>1000;  --원래는 INSERT INTO에 where안되지만
        --여기서는 조건 주는것이 가능하다

--rollback;


-- NUMBER
CREATE TABLE type_test01(
    data1 NUMBER, --최대 38자리까지 가능
    data2 NUMBER(10), --10자리까지 가능
    data3 NUMBER(5,2), --정수 3, 실수 2
    data4 NUMBER(4,5)); -- 0.XXXX
    
DESC type_test01;


-- data1 : NUMBER
INSERT INTO type_test01(data1) VALUES (1111111111222222222233333333334444444444); --40글자
INSERT INTO type_test01(data1) VALUES (11111111112222222222333333333344444444445555555555); --50글자
SELECT data1 FROM type_test01; --5가 1개만 더들어가고 0으로 나머지는 표시된다

--data2 : NUMBER(10)
SELECT data2 FROM type_test01;
INSERT INTO type_test01(data2) VALUES(12345);
INSERT INTO type_test01(data2) VALUES(12345678910); --에러발생 -10에 비해서 길다
INSERT INTO type_test01(data2) VALUES(1234.5678); --1235가 들어가있다 (반올림)--정수값 

--data3 : NUMBER(5,2)
SELECT data3 FROM type_test01 WHERE data3 IS NOT NULL; --123.46 -형식을 벗어나면 반올림
INSERT INTO type_test01(data3) VALUES(123.456); 
INSERT INTO type_test01(data3) VALUES(23.5678); --둘째자리까지 반올림
INSERT INTO type_test01(data3) VALUES(1234.56); --정수가 넘칠때? --이건 에러발생
INSERT INTO type_test01(data3) VALUES(34.56); --정수가 부족할때?? --이건 그냥 들어감 

--data4 : NUMBER(4,5) -0.0XXXX
SELECT data4 FROM type_test01 WHERE data4 IS NOT NULL;
INSERT INTO type_test01(data4) VALUES(0.0456); --0.0XXXXX여야만 들어간다
INSERT INTO type_test01(data4) VALUES(123.456); --에러발생
INSERT INTO type_test01(data4) VALUES(0.0123456789); --들어가지만 소수점6자리째에서 반올림된다


--VARCHAR2(n) : 문자
CREATE TABLE type_test02(
    data VARCHAR2(10));
DESC type_test02;

--데이터 삽입해보기, 에러나는 데이터는~??
--'1234567890'
--'123456789012345'
--'일이삼사오육칠팔구십'
--'일이삼'
--에러메세지에 actual / maximum이 표시됨 --actual은 내가 insert한 용량, maximum은 해당 문자열의 최대 범위
SELECT * FROM type_test02;
INSERT INTO type_test02 VALUES(1234567890);
INSERT INTO type_test02 VALUES(123456789012345); --에러발생 
INSERT INTO type_test02 VALUES('일이삼사오육칠팔구십'); --에러발생
INSERT INTO type_test02 VALUES('일이삼');
INSERT INTO type_test02 VALUES('일이삼사'); --3바이트씩*4 -> 초과
INSERT INTO type_test02 VALUES(''); --null 

CREATE TABLE type_test03(
    data1 VARCHAR(10 BYTE ),
    data2 VARCHAR(10 CHAR));

SELECT * FROM type_test03;
INSERT INTO type_test03(data1,data2) VALUES('일이삼','일이삼사오육칠팔구십');
INSERT INTO type_test03(data1,data2) VALUES('1234567890','1234567890');
INSERT INTO type_test03(data1,data2) VALUES('1234567890','12345678901234567890'); -- data2가 20글자 ->에러발생



--CHAR(n) : 고정 길이 문자
CREATE TABLE type_test04(
    data1 CHAR, --CHAR(1)
    data2 CHAR(20),
    data3 CHAR(20 CHAR));
SELECT trim(data1)as t,trim(data2),trim(data3) FROM type_test04; --trim 으로 해줘야한다

INSERT INTO type_test04 VALUES('Y','1234567890','일이삼사오육칠팔구십'); --20에 미치지못한 공간은 공백으로 처리 -RPAD














































