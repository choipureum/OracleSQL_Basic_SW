-- to_number

SELECT 
    '123.67' "1",
    to_number('123.67')"2",
    to_number('123.67','99999.99')"3" --���������������� ���ݴٸ� - �׳� �Ҽ������� 5�ڸ� '����'�ϰ� �ڷ� 2�ڸ� '����'�ϴ�
 --   to_number('123.67','99999.9)"4"  --�����߻� --���Ĺ��ڰ� ū���� ��������� ������ ����   
FROM dual;

SELECT
    67890+11111 "1",
    '67890'+11111"2",
    to_number('67890')+11111 "3", -- �� ���δ� ��� ���� (�ڵ�����ȯ����)
 --   '67,890'+11111 "4" --�����߻�(�޸��� ���� �ڵ�����ȯ �Ұ�)
 --   to_number('67,890')+11111 "5" --�����߻� 67,890 �� ���Ĺ��ڷ� �����������
    to_number('67,890','999,999')+11111 "6"  --���������ڷ� ���� ���� (ũ�� �˳��ϰ� �������ش�)
FROM dual;

SELECT
    '$78,789' "1", --������� + - �Ұ�
     to_number('$78,789','$999,999,999')+1000 "2" --���������ڸ� �������ֹǷν� ����������  
FROM dual;

--to_date

SELECT
    '19/10/7' "1",
    to_date('19/10/7')+90 "2" --90�� ��
FROM dual;

SELECT
    '12 1 11' "1",
    to_date('12 1 11') "2", --12�� 1�� 11�Ϸ� ��ȯ
    to_date('12 1 11','YY-MM-DD') "3" --12�� 1�� 11�Ϸ� ��ȯ(���������ڷ�)
FROM dual;

--��Ÿ ���� �� �Լ�

--NVL

SELECT empno, ename, NVL(comm,0) as BONUS FROM emp ORDER BY comm DESC,ename;-- comm(�󿩱�)  NULL ->0���� ġȯ���ش�

--NVL2
-- comm�� NULL�̸� sal�� ġȯ
-- comm�� NULL�� �ƴϸ� sal+comm�� ġȯ
SELECT ename, sal, comm, sal+comm FROM emp; --�ϳ��� NULL�̶�� ������ �������� �ʴ´�
SELECT ename, NVL2(comm,sal+comm,sal)AS pay FROM emp; --comm�� NULL�̾ ������ ������ �� �ְ� ����

--NULLIF

SELECT
    NULLIF(10,20)"1", --10
     NULLIF(20,10)"2", --20
      NULLIF(10,10)"3" --null
      FROM DUAL;
      
--����
--job�÷����� 'salesman' �� ã�´� ->null��ȯ
-- NULL���� NVL�� �̿��� '����'��ȯ

SELECT empno,ename,job, 
    NULLIF(job,'SALESMAN') N_IF, 
    NVL(NULLIF(job,'SALESMAN'),'����') job_kor 
FROM emp;

--DECODE
-- ���ǿ� ������ ġȯ�ؼ� ������ -> �������� ����Ʈ��
SELECT empno,ename,deptno,
    DECODE(deptno,
    10,'ȸ����',
    20,'������',
    30,'������',
    40,'���',
    '�μ�����') as dname
FROM emp;

--CASE ����
--�̷��Ե� ǥ�� �����ϴ� 
SELECT empno, ename, deptno,
    CASE deptno       
        WHEN 10 THEN 'ȸ����'
        WHEN 20 THEN '������'
        WHEN 30 THEN '������'
        WHEN 40 THEN '���'
        ELSE '�μ�����'
    END as dname --alias�� ���⿡
FROM EMP;


SELECT empno, ename, deptno,
    CASE      
        WHEN job=upper('president') THEN'����'
        WHEN deptno=10 THEN 'ȸ����'
        WHEN deptno=20 THEN '������'
        WHEN deptno=30 THEN '������'
        WHEN deptno=40 THEN '���'
        ELSE '�μ�����'
    END as dname --alias�� ���⿡
FROM EMP;


--COUNT
SELECT count(*) FROM emp;  --12���� �� --��ü ���

SELECT empno FROM emp; --��ü ���
SELECT count(empno) cnt_empno FROM emp; --�׷����ؼ� ���ٷ� 12���

SELECT mgr FROM emp; --12���� null���� �ϳ� ������ �ִ�
SELECT count(mgr) FROM emp; --null�� �����ϰ� 11(������) ���

SELECT count(comm) FROM emp ORDER BY comm; --4�� (null)�� ����

SELECT 1 FROM emp; --1�� 12�����
SELECT count(*) FROM emp; --12
SELECT count(1) FROM emp; --12

--SUM
SELECT sum(sal) total FROM emp;

--AVG
SELECT round(avg(sal),2)average FROM emp; -- ��°¥������ �ݿø�

--MAX
SELECT max(sal) maximum FROM emp;

--MIN
SELECT min(sal) minimun FROM emp;

SELECT max(ename) FROM emp; --���ĺ������� ���� ū��
SELECT min(ename) FROM emp; --���ĺ����� ���� ���� ��

SELECT max(hiredate),min(hiredate) FROM emp; --��¥�� ����(ū�� �ֱ�) , (������ ������) --�ܼ� ���ڰ� ū��


--��ü sal�� ���� �հ�
SELECT sum(sal) FROM emp; 
-->���� -�μ��� �޿� �հ�

SELECT 
    deptno,
    sum(sal)
FROM emp GROUP BY deptno ORDER BY deptno; --deptno�� �׷��� �����ش�

--�μ��� �ο���

SELECT
    deptno,
    count(*) cnt
FROM emp GROUP BY deptno;

SELECT ename from emp WHERE sal=5000;

--�μ���+ ������ �����
SELECT 
    deptno,
    job,
    count(*)
FROM emp
GROUP BY deptno,job --�ΰ��� �÷��� �ϳ�ó�� �ν�
ORDER BY deptno,job;



--��ȸ�÷� QUIZ_-----
--deptno, dname, cnt, tot_sal, avg_sal

--dname -> �ѱ۷�
--cnt ,tot_sal,avg_sal ->�μ��� ���
-- avg_sal ->�Ҽ��� 2�ڸ�����

SElECT * FROM emp;

SELECT deptno,
 CASE deptno       
        WHEN 10 THEN 'ȸ����'
        WHEN 20 THEN '������'
        WHEN 30 THEN '������'
        WHEN 40 THEN '���'
        ELSE '�μ�����'
    END as dname,
    
    count(*) as cnt, sum(sal) as tot_sal, round(avg(sal),2) as avg_sal
FROM emp 
GROUP BY deptno 
ORDER BY deptno;

--���⼭ ��� ���� 2000�̻��� ������? (where�� �ϸ� �����߻�)
--group�Լ��� �����ٰ�� where�� �ȵǰ� having���
SELECT
    deptno,
    round(avg(sal),2) as avg_sal
FROM emp 

GROUP BY deptno HAVING avg(sal)>2000 ORDER BY deptno;





--JOIN-----
--emp ���̺��� �� ����� �μ���ȣ�� �ƴ¹�
SELECT * FROM emp WHERE empno=7369; --deptno=20 -->�̰� ��?
SELECT * FROM dept WHERE deptno =20; --dept���̺� ���� deptno20 =research�̴�

--JOIN�ϱ�
--�� ���̺��� ��� ���� �����ϱ�
SELECT * FROM emp; --8cols 12rows
SELECT * FROM dept;--3cols 4rows
--12*4�� 48���� �� ����
--emp*dept = 11cols(8+3) 48rows(12*4) --�ǹ̾��� �����Ͱ� �ʹ�����
SELECT * FROM emp, dept; --emp�� dept�� �ѹ��� ���� --JOIN�� �⺻

--emp�� deptno�� dept�� deptno�� ���� ���� ��ȯ�Ѵ�.
SELECT * FROM emp,dept WHERE emp.deptno = dept.deptno;

--EQUIP JOIN

--���̺� �̸��� Alias�ϴ¹�? -> as�� ���̸� �ȵǰ� ������ �ϳ��� �� ǥ���Ѵ�
SELECT empno, ename, E.deptno, dname FROM emp E,dept D; --����Ǵ� �ø��� ��� ��� ���Ѱ����� .���� �������־���Ѵ�

SELECT empno,ename, E.deptno,dname FROM emp E,dept D 
WHERE E.deptno=D.deptno --���� ���� 
AND empno>7800; --�Ϲ� ��ȸ ����


-- INNER JOIN, ��������
SELECT empno,ename, E.deptno,dname FROM emp E
INNER JOIN dept D
    ON E.deptno =D.deptno --��������
WHERE empno>7800; --�Ϲ� ��ȸ����

--NON-EQUI JOIN, ������

SELECT * FROM emp; --���
SELECT * FROM salgrade; --�޿����(low �޿�, high�޿����̷� ����� �ű�)

SELECT ename, sal,grade FROM emp E,salgrade S 
WHERE sal BETWEEN losal AND hisal --��������
ORDER BY grade,sal,ename; --����

--NON- EQUI ANSI ����

SELECT ename, sal,grade FROM emp E
INNER JOIN salgrade ON sal BETWEEN losal AND hisal --��������
ORDER BY grade,sal,ename; --����


--SLEF JOIN (���̺��� �ΰ��� ������ �����Ѵٰ� �����ϸ� ���ϴ�)

SELECT * FROM emp EMPOYEE;
SELECT * FROM emp MANAGER;

-- mgr(�Ŵ��� �ѹ�==�����ȣ) -> �����ѹ� �غ���

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
ORDER BY E.empno,E.ename; --��������















































