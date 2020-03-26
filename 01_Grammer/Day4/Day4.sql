-- ī�׽þ� ��(Cartesian Product)
--CROSS JOIN
SELECT * FROM emp,dept; --ī�׽þȰ�

SELECT * FROM emp
    CROSS JOIN dept; --���� ����

--NATURAL JOIN

SELECT * FROM emp 
NATURAL JOIN dept --deptno�� �ڵ����� ��������ش�
ORDER BY deptno,empno; --����

--OUTER JOIN (���ο� �������� ���ϴ� ���ε� �߰��ؼ� ��� �������ش�)

SELECT empno, ename, D.deptno,dname
FROM emp E, dept D
WHERE E.deptno=D.deptno ORDER BY deptno,empno; -- INNER JOIN(���� �����ʹ� ���ܵ�) - 12��


SELECT empno, ename, D.deptno,dname
FROM emp E, dept D
WHERE E.deptno(+)=D.deptno ORDER BY deptno,empno; -- �����ʿ� ������(+)�� �ٿ��ش�(OUTER JOIN) -�����Ѱ��� NULL�� ä���ش�- 13��
--���࿡ �ݴ�� �ص� ������ �߻����� ������ ��� ���� 12������ INNER JOIN�� ����


-- ANSI ǥ�ر��� OUTER
SELECT empno, ename, D.deptno,dname
FROM emp E
RIGHT OUTER JOIN dept D  -- LEFT, RIGHT �ΰ��� �ִµ� (+)�� �ٴ� �ݴ�������� ����
ON E.deptno(+)=D.deptno ORDER BY deptno,empno;



-- --------------------
SELECT 
    E.empno, E.ename, E.mgr, M.ename MGR_Name
FROM emp E, emp M
WHERE E.mgr = M.empno(+); --�׳��ϸ� KING�� ������ ������ -> �ƿ��� �����ؾߵ�

SELECT
     E.empno, E.ename, E.mgr, M.ename MGR_Name
    FROM emp E LEFT OUTER JOIN emp M ON E.mgr =M.empno;


--FULL OUTER JOIN
CREATE TABLE test1 (no NUMBER); --���̺����
CREATE TABLE test2 (no NUMBER);

INSERT INTO test1 VALUES(10); --test1 ���̺� ������ ����
INSERT INTO test1 VALUES(20);
INSERT INTO test1 VALUES(30);


INSERT INTO test2 VALUES(10); --test2 ���̺� ������ ����
INSERT INTO test2 VALUES(20);
INSERT INTO test2 VALUES(40);

SELECT * FROM test1;
SELECT * FROM test2;

SELECT * FROM test1,test2 WHERE test1.no = test2.no; --INNERJOIN, EQUI JOIN (30,40 ����)
SELECT * FROM test1,test2 WHERE test1.no(+) = test2.no; --OUTERJOIN, (������ 40 �߰�)
--���� �����ʿ� ��� (+)�� �ϸ� �������� --> FULL OUTER JOIN�� ANSI�� ����
--ANSI JOIN
SELECT * FROM test1 
FULL OUTER JOIN test2 ON test1.no = test2.no
ORDER BY test1.no; --FULL OUTER JOIN 


--��������

--KING�� �μ���ȣ ��ȸ
SELECT deptno FROM emp WHERE ename=upper('KING');
--10�� �μ��� ���� Ȯ��
SELECT * FROM dept WHERE deptno=10;

--��ġ��
SELECT * FROM dept WHERE deptno =(SELECT deptno FROM emp WHERE ename =upper('king'));

--SELECT D.deptno,dname,loc
SELECT D.* FROM emp E,dept D 
WHERE E.deptno =D.deptno AND ename = 'KING';


--����ӱݺ��� �޿��� ���� �޴� ����� ��ȸ�ϱ�
desc emp;

--�߸��� ��� : Having �׷��� ���� ��������
--SELECT * FROM emp GROUP BY HAVING sal>avg(sal);

SELECT * FROM emp WHERE sal>(SELECT avg(sal) FROM emp); --����ӱݺ��� ū �� ��� ǥ��

--��Į�� ����(select���� �÷��� avg�� ���ٷ� �߰��ϰ� �ʹ�?)
SELECT empno,ename,sal,(SELECT round(avg(sal),2)FROM emp) as avg FROM emp --��Į�� , 2°�ڸ����� �ݿø�ǥ��
WHERE sal>(SELECT avg(sal) FROM emp); --����ӱ�


-- ���� �ֱٿ� �Ի��� ���

SELECT * FROM emp;

-- ��¥�� ���� ū��
SELECT empno,ename,hiredate FROM emp WHERE hiredate=(SELECT max(hiredate)FROM emp);

--�߸��� ���
--SELECT empno,ename,hiredate,max(hiredate) FROM emp;

--��ü ��� �ӱݺ��� �μ� �� ��� �ӱ��� ���� �μ�
    --�÷�:deptno, avg_sal
    --10 2916.67
    --20 2258.33
    -->>???? ���� 
    
SELECT deptno,round(avg(sal),2) FROM emp
    GROUP BY deptno HAVING avg(sal) --�μ� �� ����ӱ�
    > (SELECT avg(sal) FROM emp) --��ü ����ӱ�
ORDER BY deptno;
    
-- ��Į�� �������� (���������� SELECT �÷��ʿ� �־��ָ� ��Į�� ��������)
--dname �÷��� �߰����شٸ�?
SELECT empno,ename,deptno,
(SELECT dname FROM dept D WHERE d.deptno =e.deptno) as dname,
(SELECT loc FROM dept D WHERE D.deptno =E.deptno)as loc
FROM emp E; --���� ������ ������ �޴� ��������->��ȣ������������ -�������


-- �μ��� �ο� ���ϱ�
-- 40�� �μ��� 0���̶�� ���
-- 1. �������� Ȱ��
-- 2. JOIN�� Ȱ��
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

  --ANSI��  
SELECT 
    D.deptno,dname,
count(empno) cnt_employee
FROM emp E RIGHT OUTER JOIN dept D ON E.deptno=D.deptno
GROUP BY D.deptno, dname ORDER BY deptno;


--ORDER BY ���� �������� ����
    SELECT empno, ename, sal,deptno
    FROM emp E ORDER BY (
        SELECT loc FROM dept D WHERE E.deptno = D.deptno
    );

-->�������� Ǯ���
SELECT empno, ename, sal, E.deptno FROM emp E,dept D
WHERE E.deptno=D.deptno
ORDER BY loc;

/*
--rownum(��ȸ�Ǵ� ����� ���ȣ�� �ٿ��ִ� Ű����)
*/

SELECT rownum, empno, ename FROM emp;

--SELECT rownum, * FROM emp; --rownum�̶� *�� �ٷ� ���� �ȵȴ�
--�ذ��
SELECT rownum, E.* FROM emp E; --���̺��� �̸��̿�

--rownum �߸���� -> ���������� ��ŷ�� �ȸŰ����� -> rownum  �����ѵ� ������ �� 
SELECT rownum as rnum, E.* FROM emp E 
ORDER BY sal DESC;

--�������ϰ� ���������� rownum �����ϱ�
SELECT rownum sal_rank, E.* FROM (
SELECT * FROM emp ORDER BY sal DESC,empno
) E  --���� ���������� FROM ���� ������� ���� -> ���ĵ� -> ���� ��ŷ�� �ű�
WHERE rownum BETWEEN 1 AND 3; -- ���� 3�ٸ� ��� ������ 5~8�� �߾Ӱ��� ������ �ȳ��´�(���� ��ȣ�� �ű�鼭 ã�µ� 5���� ã��->����)-> �ذ��?

--�ذ��(�������� 2�����)
--FROM �� ������� ���� -
SELECT * FROM(
    SELECT rownum as rank, E.* FROM(
        SELECT * FROM emp 
        ORDER BY sal DESC, empno
            )E
)R
WHERE rank BETWEEN 5 AND 8;


--TOP-N �м�
    --top 3���
    --rownumŰ���带 �̿��� TOP-N�м�
/*
SELECT *FROM (
    SELECT rownum rank, TMP.* FROM(
        SELECT * FROM ���̺�� --��ȸ�Ϸ��� �������
        ORDER BY �÷��� --���ı��ؼ���
    )TMP
)R
WHERE rank�� �����ǹ�
*/

--�Ի� ��¥�� ���� ������ 3�� ��ȸ�ϱ�

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



































