-- ALTER TABLE 테스트용 테이블 생성
CREATE TABLE alter_test(
    empno NUMBER(4),
    ename VARCHAR2(30),
    CONSTRAINT alter_test_pk PRIMARY KEY(empno));
    --예제 입력
INSERT INTO alter_test SELECT empno,ename FROM emp;
SELECT * FROM alter_test;    
DESC ALTER_TEST;    
--ADD

--emp.sal 컬럼을 추가하기
ALTER TABLE alter_test ADD(sal NUMBER(7,2)); --null로 들어감
--emp.job 컬럼 추가하기
ALTER TABLE alter_test ADD(job VARCHAR2(9)); 


---- QUIZ----
--sal,job에 emp 테이블의 데이터를 반영하기
--empno가 같은 데이터를 찾아서 반영할 것
SELECT * FROM alter_test;
SELECT * FROM emp;

--null을 대체한다 -->INSET가 아니다!!! UPDATE로 바꿔줘야함!!!*********
UPDATE alter_test SET sal =  (SELECT sal FROM emp E WHERE E.empno=alter_test.empno);
UPDATE alter_test SET job =  (SELECT job FROM emp E WHERE E.empno=alter_test.empno);

--위의 두 똑같은 행 한번에 반복해보기
UPDATE alter_test SET (sal,job) = (SELECT sal,job FROM emp E WHERE E.empno = alter_test.empno); --다중열 서브쿼리

--NULL값 대체해보기
UPDATE alter_test SET sal=750 WHERE sal is NULL;
UPDATE alter_test SET job='STUDENT' WHERE job is NULL;

--MODIFY
SELECT * FROM alter_test;
--alter_test.job :VARCHAR(9) -->NUMBER로 바꾸기
--ALTER TABLE alter_test MODIFY(job NUMBER); 에러발생 -> 비워둬야 가능

--job 컬럼의 모든 데이터를 null로 수정하기
UPDATE alter_test SET job=null;
ALTER TABLE alter_test MODIFY(job NUMBER); --job -> number형식으로 변환
DESC alter_test;

ALTER TABLE alter_test MODIFY(ename NOT NULL); --NOT NULL 제약조건이 붙는다

--컬럼 삭제
ALTER TABLE alter_test DROP COLUMN job;

--컬럼 비활성화(복구 불가능)
ALTER TABLE alter_test SET UNUSED (sal);

--비활성화된 컬럼 정보 자료사전
SELECT * FROM user_unused_col_tabs; --테이블에서 비활성화한 컬럼 몇개인지 보여줌

--비활성화된 컬럼 모두 제거(완전삭제)
ALTER TABLE alter_test DROP UNUSED COLUMNS;


-- 컬럼명 변경
--alter_test.empno -> alter_test.eno

--empno -> eno 컬럼명으로 바꾸기
ALTER TABLE alter_test RENAME COLUMN empno TO eno;

--테이블명 변경
ALTER TABLE eno RENAME TO alter_tb;

DESC eno;
SELECT * FROM eno;


-- 데이터 삭제 -DML
DELETE alter_tb;
rollback;--롤백가능

--TRUNCATE --DDL
TRUNCATE TABLE alter_tb;
SELECT * FROM alter_tb;
rollback; --안된다. DDL이기때문에

--테이블 삭제, DDL
DROP TABLE alter_tb;
rollback;
