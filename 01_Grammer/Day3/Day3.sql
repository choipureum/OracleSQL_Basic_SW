-- to_number

SELECT 
    '123.67' "1",
    to_number('123.67')"2",
    to_number('123.67','99999.99')"3" --서식지정자이지만 조금다름 - 그냥 소수점위로 5자리 '가능'하고 뒤로 2자리 '가능'하다
 --   to_number('123.67','99999.9)"4"  --에러발생 --서식문자가 큰경우는 상관없지만 작으면 에러   
FROM dual;

SELECT
    67890+11111 "1",
    '67890'+11111"2",
    to_number('67890')+11111 "3", -- 이 위로는 모두 가능 (자동형변환때문)
 --   '67,890'+11111 "4" --에러발생(콤마가 끼면 자동형변환 불가)
 --   to_number('67,890')+11111 "5" --에러발생 67,890 은 서식문자로 지정해줘야함
    to_number('67,890','999,999')+11111 "6"  --서식지정자로 에러 제거 (크게 넉넉하게 지정해준다)
FROM dual;

SELECT
    '$78,789' "1", --문자취급 + - 불가
     to_number('$78,789','$999,999,999')+1000 "2" --서식지정자를 설정해주므로써 가능해진다  
FROM dual;

--to_date

SELECT
    '19/10/7' "1",
    to_date('19/10/7')+90 "2" --90일 뒤
FROM dual;

SELECT
    '12 1 11' "1",
    to_date('12 1 11') "2", --12년 1월 11일로 변환
    to_date('12 1 11','YY-MM-DD') "3" --12년 1월 11일로 변환(서식지정자로)
FROM dual;

--기타 단일 행 함수

--NVL

SELECT empno, ename, NVL(comm,0) as BONUS FROM emp ORDER BY comm DESC,ename;-- comm(상여금)  NULL ->0으로 치환해준다

--NVL2
-- comm이 NULL이면 sal로 치환
-- comm이 NULL이 아니면 sal+comm로 치환
SELECT ename, sal, comm, sal+comm FROM emp; --하나가 NULL이라면 덧셈을 수행하지 않는다
SELECT ename, NVL2(comm,sal+comm,sal)AS pay FROM emp; --comm이 NULL이어도 덧셈을 수행할 수 있게 변경

--NULLIF

SELECT
    NULLIF(10,20)"1", --10
     NULLIF(20,10)"2", --20
      NULLIF(10,10)"3" --null
      FROM DUAL;
      
--응용
--job컬럼에서 'salesman' 을 찾는다 ->null변환
-- NULL값을 NVL을 이용해 '영업'변환

SELECT empno,ename,job, 
    NULLIF(job,'SALESMAN') N_IF, 
    NVL(NULLIF(job,'SALESMAN'),'영업') job_kor 
FROM emp;

--DECODE
-- 조건에 맞으면 치환해서 보여줌 -> 마지막은 디폴트값
SELECT empno,ename,deptno,
    DECODE(deptno,
    10,'회계팀',
    20,'연구팀',
    30,'영업팀',
    40,'운영팀',
    '부서없음') as dname
FROM emp;

--CASE 구문
--이렇게도 표현 가능하다 
SELECT empno, ename, deptno,
    CASE deptno       
        WHEN 10 THEN '회계팀'
        WHEN 20 THEN '연구팀'
        WHEN 30 THEN '영업팀'
        WHEN 40 THEN '운영팀'
        ELSE '부서없음'
    END as dname --alias는 여기에
FROM EMP;


SELECT empno, ename, deptno,
    CASE      
        WHEN job=upper('president') THEN'사장'
        WHEN deptno=10 THEN '회계팀'
        WHEN deptno=20 THEN '연구팀'
        WHEN deptno=30 THEN '영업팀'
        WHEN deptno=40 THEN '운영팀'
        ELSE '부서없음'
    END as dname --alias는 여기에
FROM EMP;


--COUNT
SELECT count(*) FROM emp;  --12개의 행 --전체 행수

SELECT empno FROM emp; --전체 출력
SELECT count(empno) cnt_empno FROM emp; --그룹핑해서 한줄로 12출력

SELECT mgr FROM emp; --12개중 null값을 하나 가지고 있다
SELECT count(mgr) FROM emp; --null을 제외하고 11(행의합) 출력

SELECT count(comm) FROM emp ORDER BY comm; --4개 (null)값 제외

SELECT 1 FROM emp; --1을 12개출력
SELECT count(*) FROM emp; --12
SELECT count(1) FROM emp; --12

--SUM
SELECT sum(sal) total FROM emp;

--AVG
SELECT round(avg(sal),2)average FROM emp; -- 둘째짜리까지 반올림

--MAX
SELECT max(sal) maximum FROM emp;

--MIN
SELECT min(sal) minimun FROM emp;

SELECT max(ename) FROM emp; --알파벳순서로 가장 큰값
SELECT min(ename) FROM emp; --알파베순서 제일 앞의 값

SELECT max(hiredate),min(hiredate) FROM emp; --날짜도 가능(큰게 최근) , (작은게 오래된) --단순 숫자가 큰것


--전체 sal에 대한 합계
SELECT sum(sal) FROM emp; 
-->변경 -부서별 급여 합계

SELECT 
    deptno,
    sum(sal)
FROM emp GROUP BY deptno ORDER BY deptno; --deptno로 그룹을 지어준다

--부서별 인원수

SELECT
    deptno,
    count(*) cnt
FROM emp GROUP BY deptno;

SELECT ename from emp WHERE sal=5000;

--부서별+ 직무별 사원수
SELECT 
    deptno,
    job,
    count(*)
FROM emp
GROUP BY deptno,job --두개의 컬럼을 하나처럼 인식
ORDER BY deptno,job;



--조회컬럼 QUIZ_-----
--deptno, dname, cnt, tot_sal, avg_sal

--dname -> 한글로
--cnt ,tot_sal,avg_sal ->부서별 통계
-- avg_sal ->소수점 2자리까지

SElECT * FROM emp;

SELECT deptno,
 CASE deptno       
        WHEN 10 THEN '회계팀'
        WHEN 20 THEN '연구팀'
        WHEN 30 THEN '영업팀'
        WHEN 40 THEN '운영팀'
        ELSE '부서없음'
    END as dname,
    
    count(*) as cnt, sum(sal) as tot_sal, round(avg(sal),2) as avg_sal
FROM emp 
GROUP BY deptno 
ORDER BY deptno;

--여기서 평균 연봉 2000이상을 보려면? (where절 하면 에러발생)
--group함수로 묶어줄경우 where이 안되고 having사용
SELECT
    deptno,
    round(avg(sal),2) as avg_sal
FROM emp 

GROUP BY deptno HAVING avg(sal)>2000 ORDER BY deptno;





--JOIN-----
--emp 테이블의 한 사원의 부서번호를 아는법
SELECT * FROM emp WHERE empno=7369; --deptno=20 -->이건 뭐?
SELECT * FROM dept WHERE deptno =20; --dept테이블에 보면 deptno20 =research이다

--JOIN하기
--두 테이블의 모든 정보 결합하기
SELECT * FROM emp; --8cols 12rows
SELECT * FROM dept;--3cols 4rows
--12*4로 48개의 행 추출
--emp*dept = 11cols(8+3) 48rows(12*4) --의미없는 데이터가 너무많음
SELECT * FROM emp, dept; --emp와 dept를 한번에 본다 --JOIN의 기본

--emp의 deptno와 dept의 deptno가 같은 것을 반환한다.
SELECT * FROM emp,dept WHERE emp.deptno = dept.deptno;

--EQUIP JOIN

--테이블 이름에 Alias하는법? -> as를 붙이면 안되고 영문자 하나로 잘 표현한다
SELECT empno, ename, E.deptno, dname FROM emp E,dept D; --공통되는 컬림일 경우 어디에 속한것인지 .으로 구분해주어야한다

SELECT empno,ename, E.deptno,dname FROM emp E,dept D 
WHERE E.deptno=D.deptno --조인 조건 
AND empno>7800; --일반 조회 조건


-- INNER JOIN, 내부조인
SELECT empno,ename, E.deptno,dname FROM emp E
INNER JOIN dept D
    ON E.deptno =D.deptno --조인조건
WHERE empno>7800; --일반 조회조건

--NON-EQUI JOIN, 비등가조인

SELECT * FROM emp; --사원
SELECT * FROM salgrade; --급여등급(low 급여, high급여사이로 등급을 매김)

SELECT ename, sal,grade FROM emp E,salgrade S 
WHERE sal BETWEEN losal AND hisal --조인조건
ORDER BY grade,sal,ename; --정렬

--NON- EQUI ANSI 버젼

SELECT ename, sal,grade FROM emp E
INNER JOIN salgrade ON sal BETWEEN losal AND hisal --조인조건
ORDER BY grade,sal,ename; --정렬


--SLEF JOIN (테이블을 두개를 가지고 조인한다고 생각하면 편하다)

SELECT * FROM emp EMPOYEE;
SELECT * FROM emp MANAGER;

-- mgr(매니저 넘버==사원번호) -> 셀프넘버 해본다

SELECT
    E.empno , E.ename as EMPLOYEE,E.mgr, M.ename as MANAGER
FROM emp E, emp M
WHERE E.mgr =M.empno
ORDER BY E.empno,E.ename;

-->SELF JOIN -ANSI

SELECT
    E.empno , E.ename as EMPLOYEE,E.mgr, M.ename as MANAGER
FROM emp E
INNER JOIN emp M ON E.mgr =M.empno
ORDER BY E.empno,E.ename; --조인조건















































