-- 인덱스 자료사전
SELECT * FROM user_indexes WHERE table_name =upper('emp');

--인덱스 컬럼 자료사전
SELECT * FROM user_ind_columns;

--인덱스 조회, salgrade
SELECT * FROM user_indexes WHERE table_name = upper('salgrade'); --없음, 인덱스를 잡아주자

--인덱스 생성
CREATE INDEX idx_salgrade ON salgrade(grade);
SELECT * FROM user_indexes WHERE table_name = upper('salgrade'); --인덱스 생김

--인덱스가 중복되는 값으로 데이터삽입
INSERT INTO salgrade VALUES (5,10000,15000);
SELECT * FROM salgrade; 
--인덱스 재생성 구문(데이터가 추가되었을때 인덱스 리빌드)
ALTER INDEX idx_salgrade REBUILD;

--인덱스 삭제
DROP INDEX idx_salgrade;

--UNIQUE 인덱스생성
CREATE UNIQUE INDEX idx_salgrade ON salgrade(grade); --중복된 키발견(에러) --> 애초에 데이터에 5라는 값이 두개로 중복이된다
--5->6 으로 바꾸기
SELECT * FROM salgrade;
UPDATE salgrade SET grade=6 WHERE LOSAL=10000; --5->6으로 바꿈
SELECT * FROM user_indexes WHERE table_name =upper('salgrade');

INSERT INTO salgrade VALUES(6,10000,12000); --UNIQUE 인덱스이므로 중복되는 인덱스값은 들어가지않는다


--emp 부서별 조회
SELECT * FROM emp WHERE deptno =20; --원래 방식
--deptno을 인덱스 생성해보자

-- NONUNIQUE 인덱스 생성
CREATE INDEX idx_dept ON emp(deptno);
SELECT * FROM user_indexes WHERE table_name =upper('emp');

--부서내 이름으로 조회
SELECT * FROM emp WHERE deptno =10 AND ename ='MILLER';

--복합 컬럼 인덱스(COMPOSITE UNIQUE INDEX)
CREATE UNIQUE INDEX idx_emp_depno_ename ON emp(deptno,ename); --컬럼두개로 인덱스가 만들어진다

--자료사전 확인
SELECT * FROM user_indexes WHERE table_name = upper('emp');

--뷰, VIEW
--자주 쓰는 단락, 구문을 뷰로 저장
SELECT * FROM emp WHERE empno<2000; --이 구문을 자주 쓴다고 보면
--매번 쓰면 귀찮다 --> 뷰 지정 --> 쿼리를 간단하게 만든다

--SCOTT 사용자 계정에 뷰생성 권한(CREATE VIEW)이 없어서 수행안됨
--Insufficient Privileges
CREATE VIEW test_view AS(
    SELECT * FROM emp WHERE empno<2000); --권한을 부여받아야 가능 (문법은 맞다)

--scott 에게 뷰생성 권한 부여하기(system계정 사용)
--GRANT CREATE VIEW TO scott; --system계정에서 수행

    
CREATE OR REPLACE VIEW test_view2 AS(SELECT * FROM emp);

--뷰 자료사전 조회
SELECT * FROM user_views;

--뷰 서브쿼리 수정
CREATE OR REPLACE VIEW test_view AS(
    SELECT empno,ename FROM emp WHERE empno<2000);
    --replace 된다

--데이터 삽입
INSERT INTO test_view(empno,ename) VALUES(500,'AAA');
SELECT * FROM test_view; --view 에 들어가잇음
SELECT * FROM emp WHERE empno<2000; --emp에 들어가잇다 신기방기

INSERT INTO test_view VALUES(7000,'BBB'); --서브쿼리에 2000보다 작은애들만 이기 때문에 뷰에는 안들어간다
--하지만 원본테이블 emp에는 들어간다

--WITH CHECK OPTION 부여하기
CREATE OR REPLACE VIEW test_view AS(
    SELECT empno,ename FROM emp WHERE empno<2000)
    WITH CHECK OPTION; --제약조건에 안맞는 값은 안들어감
    
INSERT INTO test_view VALUES (8000,'CCC'); --맞지않는 값--에러 발생 안들어감
INSERT INTO test_view VALUES (600,'DDD');



--< 시퀀스 ,Sequence >

CREATE SEQUENCE seq_emp;

--시퀀스 자료사전 조회
SELECT * FROM user_sequences;

SELECT length('Banana') FROM dual;
SELECT seq_emp.currval FROM dual; --현재 밸류는 가장먼저 사용할 수 없다(nextval -> currval 순서 시행)
SELECT seq_emp.nextval FROM dual; 

--사용 방법
INSERT INTO emp(empno,ename) VALUES(seq_emp.nextval, 'PUREUM'); --이어지는 숫자가 아니어도 된다
SELECT * FROM emp;


--조건(옵션)부여해서 시퀀스 생성하기
CREATE SEQUENCE test_seq
    START WITH 2001
    MINVALUE 2001
    MAXVALUE 3000
    INCREMENT BY 100;

--2001 ~2101, 2201,2301~ 이렇게 진행(3000)되면끝
SELECT test_seq.nextval FROM dual;

-- 시퀀스 변경

ALTER SEQUENCE test_seq
    CYCLE; --에러 캐시의 사이즈는 1 사이클보다 작아야한다

ALTER SEQUENCE test_seq
    CACHE 10 --캐시를 10으로 줄여준다
    CYCLE;
--2001~2901순환

SELECT * FROM user_sequences;

