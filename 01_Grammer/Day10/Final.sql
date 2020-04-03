--주석, COMMENT
-- null값으로 모두 채워져있다
SELECT * FROM  user_tab_comments WHERE table_name =upper('emp');
SELECT * FROM  user_col_comments WHERE table_name =upper('emp');

--테이블 주석
COMMENT ON TABLE emp IS '사원정보테이블';

--컬럼 주석
COMMENT ON COLUMN emp.empno IS '사원번호';
COMMENT ON COLUMN emp.ename IS '사원이름';
COMMENT ON COLUMN emp.job IS '직무';
COMMENT ON COLUMN emp.mgr IS '담당자';
COMMENT ON COLUMN emp.hiredate IS '입사일자';
COMMENT ON COLUMN emp.sal IS '급여';
COMMENT ON COLUMN emp.comm IS '상여금';
COMMENT ON COLUMN emp.deptno IS '부서번호';


--권한
SELECT * FROM dba_sys_privs --DB의 모든권한
WHERE grantee =upper('soctt'); --admin으로 로그인해야 된다
SELECT * FROM user_sys_privs; --위와같다(접속한 사람의 권한)

--ROLE 조회
SELECT * FROM dba_role_privs; --admin로그인만 가능 
SELECT * FROM dba_sys_privs WHERE grantee IN(upper('resource'),upper('connect')) ORDER BY grantee,privilege; 


--ROLE을 포함한 시스템 권한 조회하기
SELECT * FROM dba_sys_privs WHERE grantee IN(
    SELECT granted_role FROM dba_role_privs
        WHERE grantee = upper('scott'))
UNION
SELECT * FROM dba_sys_privs
    WHERE grantee= upper('scott');

--사용자 계정
CREATE USER test IDENTIFIED BY 1234;

--test에게 db접속 권한 부여하기
GRANT CREATE SESSION TO test;

--test 에게 DB접속 권한 회수하기
REVOKE CREATE SESSION FROM test;

--ROLE을 이용한 권한부여
-- RESOURCE : 기본객체 생성 권한
-- CONNECT : DB로그온 권한

GRANT RESOURCE,CONNECT to test;


--(soctt이용)
-- 롤만드는 권한 없음
CREATE ROLE role; --에러

--(system 계정 이용)
GRANT CREATE ROLE TO scott --scott한테 롤만드는 권한 부여
WITH ADMIN OPTION; --관리자급 권한 부여(롤을 부여할 수 있는 권한을 줄수 있는 권한을 부여) 

SELECT * FROM all_users;

GRANT CREATE role to test; --scott이 해도됨(관리자급 권한 부여받으면)


--QUIZ--
--1. SCOTT계정을 이용하여 ROLE 생성
--이름 :role_test
--
--롤에 권한 부여
--CREATE TABLE
--CREATE SESSION
--CREATE VIEW

--2.ROLE_test 롤을 test2에 부여

--3.확인
--test2/1234로 connection(접속)
--테이블생성
--create table testTable(num NUMBER); 수행
-->  안만들어집니다!

--1
--생성
CREATE ROLE ROLE_TEST ;

GRANT CREATE TABLE, CREATE SESSION, CREATE VIEW to ROLE_TEST; --이것도가능
GRANT CREATE SESSION to ROLE_TEST;
GRANT CREATE VIEW to ROLE_TEST;

--2.
CREATE USER test2 IDENTIFIED BY 1234; --test2 만들기

GRANT role_test to test2; -- 롤을 test 유저에게 부여

--3


--< 퀴즈 강사님 풀이 >--
-------------------롤, 권한 부여 실습 quiz ---------------------
CREATE ROLE ROLE_TEST;
-- 롤에 권한 부여
-- CREATE TABLE
-- CREATE SESSION
-- CREATE VIEW
GRANT CREATE TABLE, CREATE SESSION, CREATE VIEW
TO ROLE_TEST;

GRANT ROLE_TEST
TO TEST2;
-- 사용자 계정생성
CREATE USER test2
IDENTIFIED BY 1234;

-- test2로 로그인 후 테이블 생성
-- 'SYSTEM' 테이블 스페이스에 대한 권한이 없기때문에 실패

-- 테이블 스페이스, tablespace
-- 테이블이 저장되는 공간(파일)

-- (SYSTEM 계정으로 수행할 것)
-- test2 계정 전용 tablespace 생성하기
-- 테이블 스페이스 생성
-- 기본 크기가 100M, 부족하면 10M씩 확장됨, 최대 500M까지 가질 수 있는 TB_SPACE
CREATE TABLESPACE test2_db
DATAFILE 'C:\oraclexe\app\oracle\oradata\test2.db'
SIZE 100M
AUTOEXTEND ON NEXT 10M
MAXSIZE 500M;

-- 테이블스페이스를 사용자계정에 적용하기
ALTER USER test2
DEFAULT TABLESPACE test2_db -- 기본 테이블스페이스 지정
QUOTA UNLIMITED ON test2_db -- 테이블스페이스 용량 할당량(전부)
TEMPORARY TABLESPACE temp; --임시 테이블로 temp지정

--테이블스페이스 삭제하기
DROP TABLESPACE test2_db
    INCLUDING CONTENTS AND DATAFILES --실데이터와 DBF파일 삭제   
    CASCADE CONSTRAINTS ; --의존성을 가지는 모든 제약사항 삭제

--(scott계정 이용)
--  객체에 권한 부여할 수 있는 권한 부여
GRANT SELECT,INSERT ON dept TO test,test2;
    
REVOKE SELECT ON DEPT FROM test,test2;







