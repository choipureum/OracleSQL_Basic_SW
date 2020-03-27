--다중 행 서브쿼리--
--IN--
--1
SELECT DISTINCT sal FROM emp WHERE job=upper('salesman') ORDER BY sal;
--2
SELECT * FROM emp WHERE sal IN(1250,1500,1600);

--1과2 합치면?
SELECT * FROM emp WHERE sal IN(
    SELECT DISTINCT sal FROM emp WHERE job='SALESMAN');
    
--사장이 속한 부서번호 확인
SELECT deptno FROM emp WHERE job='PRESIDENT';

--사장이 속한 부서에 일하는 모든 사람들
SElECT * FROM emp WHERE deptno IN (SELECT deptno FROM emp WHERE job='PRESIDENT');


--ANY연산자-잘 사용X, SOME

SELECT * FROM emp WHERE sal =ANY(
    SELECT DISTINCT sal FROM emp WHERE job='SALESMAN'); --=IN

SELECT * FROM emp WHERE sal <ANY( --ANY안하고 MAX()를 사용하는게 더 편하다
    SELECT DISTINCT sal FROM emp WHERE job='SALESMAN'); --SALESMAN의 최고MAX값보다 작은 건 모두 나온다
    --반대라면 MIN값보다 큰 데이터가 나오게된다

SELECT * FROM emp WHERE sal =SOME( --ANY와 똑같음 , 결과도 같음
    SELECT DISTINCT sal FROM emp WHERE job='SALESMAN'); --=IN

--ALL

SELECT * FROM emp WHERE sal=ALL( --세개랑 같을 수가 없다
    SELECT DISTINCT sal FROM emp WHERE job='SALESMAN');

SELECT * FROM emp WHERE sal<ALL( --MIN값보다 작아야된다 -> 그냥 MIN으로 비교해주면됨
    SELECT DISTINCT sal FROM emp WHERE job='SALESMAN');
    

--EXISTS

SELECT DISTINCT mgr FROM emp; --매니저들 번호

--매니저 역할을 수행하고 있는 사원들의 정보
SELECT * FROM emp E 
    WHERE empno IN( SELECT DISTINCT mgr FROM emp ); 

--위와 같다 (IN이 편하지만 EXISTS가 빠르다)
SELECT * FROM emp E WHERE EXISTS (
    SELECT DISTINCT mgr FROM emp M WHERE E.empno =M.mgr
    );
    
--소속 인원이 존재하는 부서들의 정보
SELECT * FROM dept D WHERE EXISTS(
    SELECT * FROM emp E WHERE D.deptno =E.deptno); --40은 0명이므로 제외
    

--다중 열 서브 쿼리

--부서별 최고 임금을 받는 사원 조회하기

SELECT max(sal) FROM emp; --전체의 최고금액

SELECT deptno, max(sal) FROM emp GROUP BY deptno; --부서별 최고금액

--다중 열 서브쿼리 이용해서 풀어보기
SELECT deptno, empno, ename, sal FROM emp
WHERE (deptno,sal) IN( SELECT deptno, max(sal) FROM emp GROUP BY deptno); --IN은 앞에 항과 연결, deptno과 sal을 비교하려면 괄호를 해준다
    
SELECT E.deptno, dname, empno, ename, sal  
    FROM emp E INNER JOIN dept D ON E.deptno = D.deptno
    WHERE(E.deptno,sal) IN ( SELECT deptno,max(sal) FROM emp GROUP BY deptno) ORDER BY deptno;
    
    
    
--집합 연산자!

 --UNION 합집합
 
SELECT empno, ename, job FROM emp WHERE job='SALESMAN';
SELECT empno, ename, job FROM emp WHERE job='MANAGER';

--UNION쓰기
    
SELECT empno, ename, job,0 deptno FROM emp WHERE job='SALESMAN' --Alias로도 컬럼명이 같아도된다
UNION
SELECT empno, ename, job,deptno FROM emp WHERE job='MANAGER'
    ORDER BY ENAME;

--UNION ALL 합집합 중복 허용
SELECT empno, ename, sal FROM emp  WHERE sal<2000 --2000연봉이하
UNION ALL -- UNION 을 쓰면 중복제거,
--           UNION ALL하면 중복제거 안된다
SELECT empno, ename, sal FROM emp  WHERE sal<1000; --1000연봉이하


--INTERSECT 교집합
SELECT empno, ename, sal FROM emp  WHERE sal<2000
INTERSECT --중복만 조회
SELECT empno, ename, sal FROM emp  WHERE sal<1000;
    
--MINUS 차집합
SELECT empno, ename, sal FROM emp  WHERE sal<2000
MINUS --중복은 제거
SELECT empno, ename, sal FROM emp  WHERE sal<1000;  
