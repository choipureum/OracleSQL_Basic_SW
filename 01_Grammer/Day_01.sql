/* scott /tiger */
--���� ctrl + enter 
--�����ּ� : --
--����Ŭ�� ��ҹ��ڸ� ���������ʴ´�(Ű���峪 �÷������ ������)(������ �����ʹ� ����������Ѵ�)
-- ��ҹ��� ��ȯ ����Ű alt+' (���� ����ǥ)
--����� ������ ���̺� ��ȸ 
--(tabs �ڷ����)


SELECT * FROM tabs;

--���̺��� ����(��Ű��)�� ������ Ȯ��(desc = Description)
DESC emp; 

--���̺��� ������ Ȯ��
SELECT * FROM emp; --12���� ������Ȯ��

--�ּ�, Comment
--���� �ּ� ����Ű : ctrl+'/'

--SELECT ����
SELECT * FROM salgrade WHERE HISAL>2000; --SELECT � �÷��� �����ٰ��ΰ� --FROM ��� ������ ���ΰ�
--WHERE ����

--�κ� �÷�(������ �÷�) ��ȸ
SELECT 
    empno,ename,job 
FROM emp;
--as�� �̸������ؼ� �����ֱ� --������ �ٲ����� �ʰ� �����ֱ⸸
--as �ᵵ �ǰ� �Ƚᵵ�ǰ� �Ȱ��� --��ȸ�Ǵ� �÷����� ��Ī(Alias)�����ϱ�
SELECT
    empno as "���", --�����ȣ
    ename "�����"--����̸�
FROM emp;

desc emp; --��ü���� ���� ���� ���


--WHERE ��(������)
SELECT * FROM emp WHERE JOB='SALESMAN'; --job�� salesman�� �ุ ��� --���ڴ� ���� ����ǥ�� ������ش�
--��ũ��Ʈ���� ������ ������ ����(���Ե� ����) �����ȣ '=' �ϳ��� ����

--��ü ����� �� �޿��� 2000�� �Ѵ� ���
desc emp;
SELECT * FROM emp WHERE sal>2000; 

-- �޿��� 2500�� �Ѵµ� �����ڰ� �ƴѻ��
SELECT * FROM emp WHERE sal>2500 AND job!='MANAGER';
SELECT * FROM emp WHERE sal>2500 AND NOT job='MANAGER';

-- BETWEEN a AND b 
--�����ȣ�� 7700~7900���� ���
SELECT * FROM emp WHERE empno BETWEEN 7700 AND 7900;

--����̸��� 'ALLEN'~ 'KING'������ ��� ��ȸ
SELECT * FROM emp  WHERE ename BETWEEN 'ALLEN' AND 'KING';
--����̸��� 'ALLEN'~ 'KING'���̰� �ƴѻ���� ��ȸ
SELECT * FROM emp  WHERE NOT(ename BETWEEN 'ALLEN' AND 'KING');
SELECT * FROM emp  WHERE ename NOT BETWEEN 'ALLEN' AND 'KING'; --���� �Ȱ��� (���� �ʹ� ���α׷��־�� ����->�ڿ������ ��ȯ)


--IN(list)����غ���
SELECT * FROM emp WHERE empno IN(7369,7521,7777,8888);
SELECT * FROM emp WHERE NOT(empno IN(7369,7521,7777,8888)); --4���� ������ �������� ���

SELECT empno,ename FROM emp WHERE ename IN('SMITH','ALLEN','ALICE');


--LIKE--
SELECT empno, ename FROM emp WHERE ename LIKE '%A%';
SELECT empno, ename FROM emp WHERE ename LIKE '_A%';

SELECT * FROM emp WHERE ename NOT LIKE 'A_%'; --����--

SELECT empno,ename FROM emp WHERE (ename LIKE '%R%') OR (ename LIKE '%A%' ); --���� ���ַ��� �̷��� ������Ѵ�

SELECT empno,ename FROM emp WHERE empno LIKE '7654'; --������ 7654�� ���������� ����񱳴� LIKE�� ��.�� ���ָ� �ȵȴ�(Ǯ��ĵ �߻�)
SELECT empno,ename FROM emp WHERE empno =7654; --�̷��� ������ ������Ѵ�


--IS NULL--
SELECT * FROM emp WHERE mgr IS NULL;


---------QUIZ-----------
-- SELECT empno, ename, deptno FROM emp
-- WHERE	 ������ �̿��Ͽ� �ذ��� ��

 --1 �μ���ȣ�� 30�̰� ������ ������ ��� ��ȸ
	--ALLEN, WARD, MARTIN, TURNER

 --2 �μ���ȣ�� 30�̰� ������ ������ �ƴ� ��� ��ȸ
	--BLAKE, JAMES

 --3 �μ���ȣ�� 30�� �ƴϰ� ������ ������ �ƴ� ��� ��ȸ
	--SMITH, JONES, CLARK, KING, FORD, MILLER

 --4 �����ȣ�� 7782���� 7900 ������ ��� ��ȸ
	--CLARK, KING, TURNER, JAMES

 --5 ������� 'A'���� 'C'�� �����ϴ� ��� ��ȸ
	--ALLEN, BLAKE, CLARK

 --6 �μ���ȣ�� 10 �Ǵ� 30�� ��� ��ȸ (IN ���)
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
     --���������� CLACK�� C�����̹Ƿ� ǥ�õ����ʴ´� �׷��� +1������ϴµ� �׷��� between������ ��︮�� ����(��Ȯ�� ǥ�� X)
     --�׷��� C~�� �ϰԵǸ� C�� �����ϴ� ���� ǥ�õȴ�
     SELECT ename FROM emp WHERE ename < 'D';
     SELECT ename FROM emp WHERE ename LIKE 'A%' OR ename LIKE 'B%' OR ename LIKE 'C%'; --Ǯ��ĵ�̶� LIKE�� �ִ��� ���ض�(��¥ �ʿ��Ҷ���)
     --6--
     SELECT ename FROM emp WHERE deptno IN(10,30);
     

---ORDER BY��---
--������ ���ϸ� �߰��� ������ ������ ���׹����� �ȴ�--
SELECT * FROM emp ORDER BY Empno DESC; --�����ȣ ��������
SELECT * FROM emp ORDER BY ename DESC; --�⺻���� ��������(ASC)

SELECT * FROM emp ORDER BY deptno ASC,empno DESC; --�Ϲ������� �ѵΰ�������


SELECT empno, ename, comm FROM emp ORDER BY comm DESC; -- ���� ���� ū������ �;ߵ����� null���� ���� ���� ���´� --�ذ����?
SELECT empno, ename, comm FROM emp ORDER BY comm DESC NULLS LAST; --null������ �ڷ� ����� ��ɾ�
SELECT empno, ename, comm FROM emp ORDER BY comm DESC NULLS FIRST; --null������ �� ���� ������ ��ɾ�
SELECT empno, ename, comm FROM emp ORDER BY comm DESC NULLS LAST, empno,ename; --�̷��Ե� ���������� ���� �Ⱦ���

--��ȸ���� �ʴ� �÷��� �̿��ؼ��� ���ı������� ���� �� �ִ�--
SELECT empno,ename,comm FROM emp ORDER BY sal;

----DISTINCT ---Ű����
SELECT DISTINCT deptno FROM emp ORDER BY deptno;

SELECT DISTINCT deptno,ename FROM emp order by deptno,ename; --�ΰ��� �÷��� ��� ���ƾ� �ߺ����Ű� �Ǳ⶧���� -deptno�� �ߺ����� �ȵȴ�--

SELECT DISTINCT job FROM emp ORDER BY job;

SELECT DISTINCT deptno, job FROM emp ORDER BY deptno,job;







