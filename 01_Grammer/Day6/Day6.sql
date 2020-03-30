SELECT  empno, ename, job, mgr,
    hiredate, sal, comm, deptno
FROM emp;

--INSERT
--col������ �°� �־��ش�
--1��° ���
INSERT INTO emp (empno,ename,job,mgr, hiredate,sal,comm,deptno) VALUES(1001,'ALICE','CLERK',1003,'16/4/9',800,null,30);

--2���� ���
SELECT * FROM emp;
INSERT INTO emp VALUES(1002,'MORRIS','CLERK',1003,'16/9/2',800,null,30);

SELECT * FROM emp WHERE empno<2000; --�����Ѱ͸� ������

--�̰����� ������ �־��
SELECT 1,2,'a','b' FROM dual; --1,2a,b�� ����
--1003	MATHEW	SALESMAN		20/03/30	 1500 	100	30
SELECT 1003, 'MATHEW', 'SALESMAN', NULL, sysdate, 1500,100,30 FROM dual;

--�̸� �̿��� ���������� INSERT �����غ���
INSERT INTO emp
    SELECT 1003, 'MATHEW', 'SALESMAN', NULL, sysdate, 1500,100,30 FROM dual;

SELECT * FROM emp WHERE empno<2000;

--���� �� ����� ������ �����ϼ��� (�÷��� �����ؼ� �ֱ�)
    --1)��� 1011, �̸� EDWARD, ���� MANAGER 
    --2)��� 1015, �̸� RICHARD, �޿� 2000
--1
INSERT INTO emp(empno,ename,job) VALUES (1011,'EDWARD', 'MANAGER');
--2
INSERT INTO emp(empno,ename,sal) VALUES (1015,'RICHARD', 2000);

--commit(Ŀ��), ������ ������� ���������� �����Ѵ�
--DELETE emp -->emp ���̺��� ��ü �����Ѵ�
--rollback --(�ѹ�)������ ��������� �ǵ����� --���ݱ��� �۾��ߴ� ���� ��� �ǵ�����
-- ���Ǳ�� �����ؼ� ����ؾ� �Ѵ�

--���̺� ���� (SELECT ������ ����� �纻���̺�� �����Ѵ� --����)

CREATE TABLE emp_research AS SELECT * FROM emp;
SELECT * FROM emp_research; -- �״�� �����

--���̺� ����(DDL) --commit�̳� rollback �ȵȴ�
DROP TABLE emp_research;

--�� ���̺� ����
SELECT* FROM emp WHERE 1=1;  --true�� ����ϰ� ������ ��� �ȵ� -> 1=1�� ������ ���������� true�� ǥ���ȴ�
SELECT* FROM emp WHERE 1=0;  --false�� ��Ÿ�� -> �ƹ��͵� ��ȸ�ȵȴ�

SELECT * FROM emp WHERE 1=1
        AND empno<2000; --���ص��Ǵµ� �׳��Ѱ�
        
--�� ���̺� ����
CREATE TABLE emp_research AS SELECT * FROM emp WHERE 1=0; --�����̺� ���� (�÷��� �����´�)
SELECT * FROM emp_research;

--20�� �μ��� ��� �����͸� ����ֱ�

INSERT INTO emp_research
SELECT * FROM emp WHERE deptno=20; --20�� �μ��� ��� ���� ���Եȴ�(���������̿�)
SELECT * FROM emp_research;

--30�� �μ��� ��� �����͸� empno, ename, �� Insert
INSERT INTO emp_research(empno, ename) 
SELECT empno,ename FROM emp WHERE deptno=30; --*�� �ƴ� ���ϴ� �͸� SELECT������ �����Ѵ�
SELECT * FROM emp_research;


--INSERT ALL
--���� ���Ŀ� INSERT ALL�� ����غ���

--��絥���� ����
DELETE emp_research;
---
--�μ���ȣ 20 �ֱ�
INSERT ALL
    WHEN deptno=20 --����
        THEN INTO emp_research --deptno=20�� �� emp_research ���̺� �ִ´�
    SELECT * FROM emp;

SELECT * FROM emp_research;

--�μ���ȣ 20 ����, 30 empno,ename �ֱ�

INSERT ALL
    WHEN deptno=20
        THEN INTO emp_research
    WHEN deptno=30
        THEN INTO emp_research(empno,ename)
        VALUES (empno,ename)
SELECT * FROM emp;

SELECT * FROM emp_research;


--INSERT ALL QUIZ--

--emp�� �̿��� �����;��� emp_hire���̺� ���� (empno,ename,hiredate)
CREATE TABLE emp_hire AS SELECT empno,ename,hiredate FROM emp WHERE 1=0;
SELECT * FROM emp_hire;

--emp�� �̿��� ������ ���� emp_sal ���̺� ����(empno,ename,sal)
CREATE TABLE emp_sal AS SELECT empno,ename,sal FROM emp WHERE 1=0;
SELECT * FROM emp_sal;

--INSERT ALL ����ؼ� �ذ��ϱ�
--emp_hre ���̺�, '1981/06/01'�������
SELECT * FROM emp;

INSERT ALL
    WHEN hiredate<TO_DATE('81-06-01')
        THEN INTO emp_hire
SELECT empno,ename,hiredate FROM emp;

--emp_sal ���̺�, 2000���� ���� ���
INSERT ALL
    WHEN sal>2000
        THEN INTO emp_sal
SELECT empno,ename,sal FROM emp;


--�Բ����ֱ�

INSERT ALL
    WHEN hiredate <'1991/06/01'
        THEN INTO emp_hire
        VALUES (empno,ename,hiredate)
    WHEN sal>2000
        THEN INTO emp_sal
        VALUES (empno,ename,sal)
SELECT * FROM emp;

--commit;  --�����ؼ� :���������� ����
--rollback;

--���̺� ����
DELETE emp_hire;
DELETE emp_sal;
ROLLBACK; --���� �Ǿ����� ���ƿ´�
SELECT * FROM emp_hire;
SELECT * FROM emp_sal;

SELECT * FROM emp_sal WHERE empno= 7839;

DELETE emp_sal 
--empno=7839���� 'KING'
WHERE empno=7839;

SELECT * FROM emp_sal; --1�� ������

rollback;


--UPDATE 
SELECT * FROM emp WHERE empno=1001; --'ALICE'
UPDATE emp SET ename = 'MC',job='Donald' WHERE empno=1001; --Alice-> Mc/donal�� �ٲ�
--commit
--rollback

--emp_hire ���̺� ��ü �������� �Ի����� ����ð����� ����
UPDATE emp_hire SET hiredate = trunc(sysdate); --�׳� ������ �ð��� ���Ƿ� ������ ���� -> �������� ����
SELECT to_char(hiredate,'yyyy/mm/dd hh24:mi:ss') FROM emp_hire; --00�� 00�� 00�ʷ� �ʱ�ȭ��
SELECT * FROM emp_hire;

--emp_sal�� ����� ���� �޿� 550 �λ�
UPDATE emp_sal SET SAL=SAL+550;
SELECT * FROM emp_sal ORDER BY SAL;


---MERGE---
--merge�� ����� ������ �����
CREATE TABLE emp_merge AS SELECT empno,ename, sal,deptno FROM emp WHERE deptno IN(10,20); --10���� 20���μ� INSERT
SELECT * FROM emp_merge ORDER BY deptno,empno;

--emp ���̺��� 20,30 �μ�������� ��ȸ(SELECT)

-- emp_merge ���̺�� ������ ����(MERGE)
-- �̹�  ���̺� �����ϴ� �����Ͷ�� sal�� 30% �λ�(UPDATE)
-- ���̺� �����ϴ� �����Ͱ� �ƴ϶�� ����(INSERT)

MERGE INTO emp_merge M  --alias �ȵ� ��?
USING(
    SELECT empno,ename,sal,deptno FROM emp 
    WHERE deptno IN(20,30)
    )E 
    ON (M.empno=E.empno) 
    WHEN MATCHED THEN --�����ϴ� �����Ͷ��? , 20�� �μ�
        UPDATE SET M.sal= M.sal*1.3 --30% �λ�      --UPDATE�� SET���̿� ���̺�� ����ȴ� 
    WHEN NOT MATCHED THEN --�������� �ʴ� �����Ͷ��? , 30���μ�
        INSERT (M.empno,M.ename,M.deptno, M.sal) VALUES(E.empno,E.ename,E.deptno, E.sal) WHERE E.sal>1000;  --������ INSERT INTO�� where�ȵ�����
        --���⼭�� ���� �ִ°��� �����ϴ�

--rollback;


-- NUMBER
CREATE TABLE type_test01(
    data1 NUMBER, --�ִ� 38�ڸ����� ����
    data2 NUMBER(10), --10�ڸ����� ����
    data3 NUMBER(5,2), --���� 3, �Ǽ� 2
    data4 NUMBER(4,5)); -- 0.XXXX
    
DESC type_test01;


-- data1 : NUMBER
INSERT INTO type_test01(data1) VALUES (1111111111222222222233333333334444444444); --40����
INSERT INTO type_test01(data1) VALUES (11111111112222222222333333333344444444445555555555); --50����
SELECT data1 FROM type_test01; --5�� 1���� ������ 0���� �������� ǥ�õȴ�

--data2 : NUMBER(10)
SELECT data2 FROM type_test01;
INSERT INTO type_test01(data2) VALUES(12345);
INSERT INTO type_test01(data2) VALUES(12345678910); --�����߻� -10�� ���ؼ� ���
INSERT INTO type_test01(data2) VALUES(1234.5678); --1235�� ���ִ� (�ݿø�)--������ 

--data3 : NUMBER(5,2)
SELECT data3 FROM type_test01 WHERE data3 IS NOT NULL; --123.46 -������ ����� �ݿø�
INSERT INTO type_test01(data3) VALUES(123.456); 
INSERT INTO type_test01(data3) VALUES(23.5678); --��°�ڸ����� �ݿø�
INSERT INTO type_test01(data3) VALUES(1234.56); --������ ��ĥ��? --�̰� �����߻�
INSERT INTO type_test01(data3) VALUES(34.56); --������ �����Ҷ�?? --�̰� �׳� �� 

--data4 : NUMBER(4,5) -0.0XXXX
SELECT data4 FROM type_test01 WHERE data4 IS NOT NULL;
INSERT INTO type_test01(data4) VALUES(0.0456); --0.0XXXXX���߸� ����
INSERT INTO type_test01(data4) VALUES(123.456); --�����߻�
INSERT INTO type_test01(data4) VALUES(0.0123456789); --������ �Ҽ���6�ڸ�°���� �ݿø��ȴ�


--VARCHAR2(n) : ����
CREATE TABLE type_test02(
    data VARCHAR2(10));
DESC type_test02;

--������ �����غ���, �������� �����ʹ�~??
--'1234567890'
--'123456789012345'
--'���̻�����ĥ�ȱ���'
--'���̻�'
--�����޼����� actual / maximum�� ǥ�õ� --actual�� ���� insert�� �뷮, maximum�� �ش� ���ڿ��� �ִ� ����
SELECT * FROM type_test02;
INSERT INTO type_test02 VALUES(1234567890);
INSERT INTO type_test02 VALUES(123456789012345); --�����߻� 
INSERT INTO type_test02 VALUES('���̻�����ĥ�ȱ���'); --�����߻�
INSERT INTO type_test02 VALUES('���̻�');
INSERT INTO type_test02 VALUES('���̻��'); --3����Ʈ��*4 -> �ʰ�
INSERT INTO type_test02 VALUES(''); --null 

CREATE TABLE type_test03(
    data1 VARCHAR(10 BYTE ),
    data2 VARCHAR(10 CHAR));

SELECT * FROM type_test03;
INSERT INTO type_test03(data1,data2) VALUES('���̻�','���̻�����ĥ�ȱ���');
INSERT INTO type_test03(data1,data2) VALUES('1234567890','1234567890');
INSERT INTO type_test03(data1,data2) VALUES('1234567890','12345678901234567890'); -- data2�� 20���� ->�����߻�



--CHAR(n) : ���� ���� ����
CREATE TABLE type_test04(
    data1 CHAR, --CHAR(1)
    data2 CHAR(20),
    data3 CHAR(20 CHAR));
SELECT trim(data1)as t,trim(data2),trim(data3) FROM type_test04; --trim ���� ������Ѵ�

INSERT INTO type_test04 VALUES('Y','1234567890','���̻�����ĥ�ȱ���'); --20�� ��ġ������ ������ �������� ó�� -RPAD














































