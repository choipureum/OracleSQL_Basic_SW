/* scott /tiger */
--실행 ctrl + enter 
--한줄주석 : --
--오라클은 대소문자를 구분하지않는다(키보드나 컬럼명등은 괜찮다)(하지만 데이터는 구분해줘야한다)
-- 대소문자 전환 단축키 alt+' (작은 따옴표)
--사용자 계정의 테이블 조회 
--(tabs 자료사전)


SELECT * FROM tabs;

--테이블의 구조(스키마)를 간단히 확인(desc = Description)
DESC emp; 

--테이블의 데이터 확인
SELECT * FROM emp; --12개의 데이터확인

--주석, Comment
--한줄 주석 단축키 : ctrl+'/'

--SELECT 구문
SELECT * FROM salgrade WHERE HISAL>2000; --SELECT 어떤 컬럼을 보여줄것인가 --FROM 어디서 가져올 것인가
--WHERE 조건

--부분 컬럼(지정한 컬럼) 조회
SELECT 
    empno,ename,job 
FROM emp;
--as로 이름변경해서 보여주기 --원본이 바뀌지는 않고 보여주기만
--as 써도 되고 안써도되고 똑같다 --조회되는 컬럼명의 별칭(Alias)적용하기
SELECT
    empno as "사번", --사원번호
    ename "사원명"--사원이름
FROM emp;

desc emp; --전체보는 가장 편리한 방법


--WHERE 절(조건절)
SELECT * FROM emp WHERE JOB='SALESMAN'; --job이 salesman인 행만 출력 --문자는 작은 따옴표를 사용해준다
--스크립트언어라서 변수의 개념이 없다(대입도 없다) 동등기호 '=' 하나면 가능

--전체 사원들 중 급여가 2000이 넘는 사원
desc emp;
SELECT * FROM emp WHERE sal>2000; 

-- 급여가 2500이 넘는데 관리자가 아닌사원
SELECT * FROM emp WHERE sal>2500 AND job!='MANAGER';
SELECT * FROM emp WHERE sal>2500 AND NOT job='MANAGER';

-- BETWEEN a AND b 
--사원번호가 7700~7900사이 출력
SELECT * FROM emp WHERE empno BETWEEN 7700 AND 7900;

--사원이름이 'ALLEN'~ 'KING'사이의 사원 조회
SELECT * FROM emp  WHERE ename BETWEEN 'ALLEN' AND 'KING';
--사원이름이 'ALLEN'~ 'KING'사이가 아닌사람들 조회
SELECT * FROM emp  WHERE NOT(ename BETWEEN 'ALLEN' AND 'KING');
SELECT * FROM emp  WHERE ename NOT BETWEEN 'ALLEN' AND 'KING'; --위랑 똑같다 (위는 너무 프로그래밍언어 같음->자연어스럽게 변환)


--IN(list)사용해보기
SELECT * FROM emp WHERE empno IN(7369,7521,7777,8888);
SELECT * FROM emp WHERE NOT(empno IN(7369,7521,7777,8888)); --4개를 제외한 나머지가 출력

SELECT empno,ename FROM emp WHERE ename IN('SMITH','ALLEN','ALICE');


--LIKE--
SELECT empno, ename FROM emp WHERE ename LIKE '%A%';
SELECT empno, ename FROM emp WHERE ename LIKE '_A%';

SELECT * FROM emp WHERE ename NOT LIKE 'A_%'; --부정--

SELECT empno,ename FROM emp WHERE (ename LIKE '%R%') OR (ename LIKE '%A%' ); --같이 써주려면 이렇게 써줘야한다

SELECT empno,ename FROM emp WHERE empno LIKE '7654'; --서식을 7654로 지정하지만 동등비교는 LIKE를 절.대 써주면 안된다(풀스캔 발생)
SELECT empno,ename FROM emp WHERE empno =7654; --이렇게 무조건 써줘야한다


--IS NULL--
SELECT * FROM emp WHERE mgr IS NULL;


---------QUIZ-----------
-- SELECT empno, ename, deptno FROM emp
-- WHERE	 구조를 이용하여 해결할 것

 --1 부서번호가 30이고 직무가 영업인 사원 조회
	--ALLEN, WARD, MARTIN, TURNER

 --2 부서번호가 30이고 직무가 영업이 아닌 사원 조회
	--BLAKE, JAMES

 --3 부서번호가 30이 아니고 직무가 영업이 아닌 사원 조회
	--SMITH, JONES, CLARK, KING, FORD, MILLER

 --4 사원번호가 7782에서 7900 사이인 사원 조회
	--CLARK, KING, TURNER, JAMES

 --5 사원명이 'A'부터 'C'로 시작하는 사원 조회
	--ALLEN, BLAKE, CLARK

 --6 부서번호가 10 또는 30인 사원 조회 (IN 사용)
	--ALLEN, WARD, MARTIN, BLAKE, CLARK, KING, TURNER, JAMES, MILLER

     --1--
     SELECT ename FROM emp WHERE deptno =30 AND job='SALESMAN';
     --2--
     SELECT ename FROM emp WHERE deptno =30 AND NOT(job='SALESMAN');
     --3--
     SELECT ename FROM emp WHERE deptno !=30 AND job!='SALESMAN';
     --4--
     SELECT ename FROM emp WHERE empno BETWEEN 7782 AND 7900;
     --5--
     SELECT ename FROM emp WHERE ename BETWEEN 'A' AND 'C~'; 
     --사전순서로 CLACK은 C다음이므로 표시되지않는다 그래서 +1해줘야하는데 그래서 between구문은 어울리지 않음(정확한 표시 X)
     --그래도 C~를 하게되면 C로 시작하는 값이 표시된다
     SELECT ename FROM emp WHERE ename < 'D';
     SELECT ename FROM emp WHERE ename LIKE 'A%' OR ename LIKE 'B%' OR ename LIKE 'C%'; --풀스캔이라 LIKE는 최대한 피해라(진짜 필요할때만)
     --6--
     SELECT ename FROM emp WHERE deptno IN(10,30);
     

---ORDER BY절---
--정렬을 안하면 중간에 내용이 들어오면 뒤죽박죽이 된다--
SELECT * FROM emp ORDER BY Empno DESC; --사원번호 내림차순
SELECT * FROM emp ORDER BY ename DESC; --기본값은 오름차순(ASC)

SELECT * FROM emp ORDER BY deptno ASC,empno DESC; --일반적으로 한두개정도만


SELECT empno, ename, comm FROM emp ORDER BY comm DESC; -- 값이 가장 큰수부터 와야되지만 null값이 가장 위에 나온다 --해결법은?
SELECT empno, ename, comm FROM emp ORDER BY comm DESC NULLS LAST; --null값들은 뒤로 빼라는 명령어
SELECT empno, ename, comm FROM emp ORDER BY comm DESC NULLS FIRST; --null값들은 맨 위로 보내는 명령어
SELECT empno, ename, comm FROM emp ORDER BY comm DESC NULLS LAST, empno,ename; --이렇게도 가능하지만 많이 안쓴다

--조회되지 않는 컬럼을 이용해서도 정렬기준으로 삼을 수 있다--
SELECT empno,ename,comm FROM emp ORDER BY sal;

----DISTINCT ---키워드
SELECT DISTINCT deptno FROM emp ORDER BY deptno;

SELECT DISTINCT deptno,ename FROM emp order by deptno,ename; --두개의 컬럼이 모두 같아야 중복제거가 되기때문에 -deptno가 중복제거 안된다--

SELECT DISTINCT job FROM emp ORDER BY job;

SELECT DISTINCT deptno, job FROM emp ORDER BY deptno,job;







