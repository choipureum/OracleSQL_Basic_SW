-- 카테시안 곱(Cartesian Product)
--CROSS JOIN
SELECT * FROM emp,dept; --카테시안곱

SELECT * FROM emp
    CROSS JOIN dept; --위와 같다

--NATURAL JOIN

SELECT * FROM emp 
NATURAL JOIN dept --deptno을 자동으로 연결시켜준다
ORDER BY deptno,empno; --정렬

--OUTER JOIN (조인에 참여하지 못하는 요인도 추가해서 모두 조인해준다)

SELECT empno, ename, D.deptno,dname
FROM emp E, dept D
WHERE E.deptno=D.deptno ORDER BY deptno,empno; -- INNER JOIN(없는 데이터는 제외됨) - 12행


SELECT empno, ename, D.deptno,dname
FROM emp E, dept D
WHERE E.deptno(+)=D.deptno ORDER BY deptno,empno; -- 없는쪽에 연산자(+)를 붙여준다(OUTER JOIN) -부족한곳에 NULL을 채워준다- 13행
--만약에 반대로 해도 에러는 발생하지 않지만 결과 값이 12행으로 INNER JOIN과 같다


-- ANSI 표준구문 OUTER
SELECT empno, ename, D.deptno,dname
FROM emp E
RIGHT OUTER JOIN dept D  -- LEFT, RIGHT 두개가 있는데 (+)가 붙는 반대방향으로 설정
ON E.deptno(+)=D.deptno ORDER BY deptno,empno;



-- --------------------
SELECT 
    E.empno, E.ename, E.mgr, M.ename MGR_Name
FROM emp E, emp M
WHERE E.mgr = M.empno(+); --그냥하면 KING의 정보가 생략됨 -> 아우터 조인해야됨

SELECT
     E.empno, E.ename, E.mgr, M.ename MGR_Name
    FROM emp E LEFT OUTER JOIN emp M ON E.mgr =M.empno;


--FULL OUTER JOIN
CREATE TABLE test1 (no NUMBER); --테이블생성
CREATE TABLE test2 (no NUMBER);

INSERT INTO test1 VALUES(10); --test1 테이블에 데이터 삽입
INSERT INTO test1 VALUES(20);
INSERT INTO test1 VALUES(30);


INSERT INTO test2 VALUES(10); --test2 테이블에 데이터 삽입
INSERT INTO test2 VALUES(20);
INSERT INTO test2 VALUES(40);

SELECT * FROM test1;
SELECT * FROM test2;

SELECT * FROM test1,test2 WHERE test1.no = test2.no; --INNERJOIN, EQUI JOIN (30,40 생략)
SELECT * FROM test1,test2 WHERE test1.no(+) = test2.no; --OUTERJOIN, (오른쪽 40 추가)
--왼쪽 오른쪽에 모두 (+)를 하면 오류가남 --> FULL OUTER JOIN은 ANSI만 가능
--ANSI JOIN
SELECT * FROM test1 
FULL OUTER JOIN test2 ON test1.no = test2.no
ORDER BY test1.no; --FULL OUTER JOIN 


--서브쿼리

--KING의 부서번호 조회
SELECT deptno FROM emp WHERE ename=upper('KING');
--10번 부서의 정보 확인
SELECT * FROM dept WHERE deptno=10;

--합치기
SELECT * FROM dept WHERE deptno =(SELECT deptno FROM emp WHERE ename =upper('king'));

--SELECT D.deptno,dname,loc
SELECT D.* FROM emp E,dept D 
WHERE E.deptno =D.deptno AND ename = 'KING';


--평균임금보다 급여를 많이 받는 사원들 조회하기
desc emp;

--잘못된 경우 : Having 그룹을 묶을 수가없다
--SELECT * FROM emp GROUP BY HAVING sal>avg(sal);

SELECT * FROM emp WHERE sal>(SELECT avg(sal) FROM emp); --평균임금보다 큰 것 모두 표시

--스칼라 쿼리(select에서 컬럼을 avg로 한줄로 추가하고 싶다?)
SELECT empno,ename,sal,(SELECT round(avg(sal),2)FROM emp) as avg FROM emp --스칼라 , 2째자리까지 반올림표시
WHERE sal>(SELECT avg(sal) FROM emp); --평균임금


-- 가장 최근에 입사한 사원

SELECT * FROM emp;

-- 날짜가 가장 큰값
SELECT empno,ename,hiredate FROM emp WHERE hiredate=(SELECT max(hiredate)FROM emp);

--잘못된 경우
--SELECT empno,ename,hiredate,max(hiredate) FROM emp;

--전체 평균 임금보다 부서 별 평균 임금이 높은 부서
    --컬럼:deptno, avg_sal
    --10 2916.67
    --20 2258.33
    -->>???? 뭐야 
    
SELECT deptno,round(avg(sal),2) FROM emp
    GROUP BY deptno HAVING avg(sal) --부서 별 평균임금
    > (SELECT avg(sal) FROM emp) --전체 평균임금
ORDER BY deptno;
    
-- 스칼라 서브쿼리 (서브쿼리를 SELECT 컬럼쪽에 넣어주면 스칼라 서브쿼리)
--dname 컬럼을 추가해준다면?
SELECT empno,ename,deptno,
(SELECT dname FROM dept D WHERE d.deptno =e.deptno) as dname,
(SELECT loc FROM dept D WHERE D.deptno =E.deptno)as loc
FROM emp E; --메인 쿼리에 영향을 받는 서브쿼리->상호연관서브쿼리 -상관쿼리


-- 부서별 인원 구하기
-- 40번 부서는 0명이라고 출력
-- 1. 서브쿼리 활용
-- 2. JOIN을 활용
-- deptno, dname, cnt_employee
SELECT * FROM emp;
SELECT * FROM dept;

SELECT 
    deptno, 
    dname,
(SELECT count(*) FROM emp E WHERE E.deptno = D.deptno) as cnt_employee
FROM dept D;

SELECT 
    D.deptno,dname,
count(empno) cnt_employee
FROM emp E,dept D 
WHERE E.deptno(+)=D.deptno
GROUP BY D.deptno, dname ORDER BY deptno;

  --ANSI로  
SELECT 
    D.deptno,dname,
count(empno) cnt_employee
FROM emp E RIGHT OUTER JOIN dept D ON E.deptno=D.deptno
GROUP BY D.deptno, dname ORDER BY deptno;


--ORDER BY 절에 서브쿼리 쓰기
    SELECT empno, ename, sal,deptno
    FROM emp E ORDER BY (
        SELECT loc FROM dept D WHERE E.deptno = D.deptno
    );

-->조인으로 풀어보기
SELECT empno, ename, sal, E.deptno FROM emp E,dept D
WHERE E.deptno=D.deptno
ORDER BY loc;

/*
--rownum(조회되는 결과에 행번호를 붙여주는 키워드)
*/

SELECT rownum, empno, ename FROM emp;

--SELECT rownum, * FROM emp; --rownum이랑 *은 바로 같이 안된다
--해결법
SELECT rownum, E.* FROM emp E; --테이블의 이름이용

--rownum 잘못사용 -> 연봉순으로 랭킹이 안매겨진다 -> rownum  실행한뒤 정렬을 함 
SELECT rownum as rnum, E.* FROM emp E 
ORDER BY sal DESC;

--정렬을하고 연봉순으로 rownum 실행하기
SELECT rownum sal_rank, E.* FROM (
SELECT * FROM emp ORDER BY sal DESC,empno
) E  --실행 순서때문에 FROM 절을 가장먼저 실행 -> 정렬됨 -> 이후 랭킹을 매김
WHERE rownum BETWEEN 1 AND 3; -- 위의 3줄만 출력 하지만 5~8등 중앙값만 나오면 안나온다(원래 번호를 매기면서 찾는데 5부터 찾음->없음)-> 해결법?

--해결법(서브쿼리 2번사용)
--FROM 이 가장먼저 실행 -
SELECT * FROM(
    SELECT rownum as rank, E.* FROM(
        SELECT * FROM emp 
        ORDER BY sal DESC, empno
            )E
)R
WHERE rank BETWEEN 5 AND 8;


--TOP-N 분석
    --top 3등등
    --rownum키워드를 이용한 TOP-N분석
/*
SELECT *FROM (
    SELECT rownum rank, TMP.* FROM(
        SELECT * FROM 테이블명 --조회하려는 대상지정
        ORDER BY 컬럼명 --정렬기준설정
    )TMP
)R
WHERE rank값 비교조건문
*/

--입사 날짜가 가장 오래된 3명 조회하기

--1
SELECT * FROM(
    SELECT rownum as rank, E.* FROM(
        SELECT * FROM emp 
        ORDER BY hiredate ASC, empno
            )E
)R
WHERE rank BETWEEN 1 AND 3;

--2
SELECT * FROM(
    SELECT rownum rank, E.* FROM(
        SELECT * FROM emp ORDER BY hiredate, empno)E
     )
     WHERE rank <=3; 



































