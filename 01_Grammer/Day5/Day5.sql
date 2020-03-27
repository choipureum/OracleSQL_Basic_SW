--���� 1

--1. ������ ������ �������� ���� ȯ�� ��ȸ
SELECT PAT_CODE, PAT_NAME  FROM PATIENT WHERE PAT_NAME LIKE '��%';

--2. ������ ������ �������� ���� ȯ���� 1979����� �ƴ� ��ȸ
SELECT PAT_CODE,PAT_NAME  FROM PATIENT WHERE PAT_NAME LIKE '��%' AND PAT_GENDER ='M' AND NOT(PAT_BIRTH LIKE '1979%');

--3. ��������� 1980��� ���� 1989��� ���� ȯ�� �� ���ڸ� ��ȸ
SELECT PAT_CODE,PAT_NAME FROM PATIENT WHERE PAT_BIRTH LIKE '198%' AND PAT_GENDER ='F'; 

--4. ȯ���̸��� 4���̸� '����'���� ������ ȯ�� �� ��������� 2004��� ���� ȯ�ڸ� ��ȸ
SELECT PAT_CODE,PAT_NAME FROM PATIENT WHERE PAT_NAME LIKE '__����' AND PAT_BIRTH LIKE '2004%';

--5. 2000��� ���� �� �̸� �� �α��ڰ� 'ȯ��'�� ������ �ʴ� ȯ����ȸ
SELECT PAT_CODE,PAT_NAME FROM PATIENT WHERE PAT_BIRTH LIKE '2000%' AND NOT(PAT_NAME LIKE '%ȯ��') AND PAT_GENDER ='F';

--6. ȯ���̸��� 4���λ�� �߿� �޴��� ��ȣ�� ��ϵǾ����� ���� ȯ����ȸ 
SELECT PAT_CODE,PAT_NAME FROM PATIENT WHERE PAT_NAME LIKE '____' AND PAT_TEL IS NULL;


--���� 2

--1. 2012�� 1�� 3�� ����ȯ�� �� 
-- �����ܰ�(�ڵ�:05xx)�� �����ܰ�(�ڵ�:08xx)�� �̺����İ�(�ڵ�:13xx)
-- ȯ����ȸ

SELECT PAT_CODE,PAT_NAME FROM PATIENT WHERE PAT_CODE IN(
SELECT  PAT_CODE FROM TREAT T WHERE (TRT_YEAR=2012 AND TRT_DATE=0103) 
    AND DOC_CODE IN (SELECT DOC_CODE FROM DOCTOR WHERE DEP_CODE LIKE '05%' OR DEP_CODE LIKE '08%' OR DEP_CODE LIKE '13%')) ORDER BY PAT_CODE;

--2. 2012�� 1�� 3�� ����ȯ�� �� ���� ����ð��� 09:00 ~ 12:00 �̰�
-- ������� �����ܰ�(�ڵ�:05xx)�� �����ܰ�(�ڵ�:08xx)�� �̺����İ�(�ڵ�:13xx)
-- �� �ƴ� ȯ����ȸ

SELECT PAT_CODE,PAT_NAME FROM PATIENT WHERE PAT_CODE IN(
SELECT  PAT_CODE FROM TREAT T WHERE (TRT_YEAR=2012 AND TRT_DATE=0103) 
    AND (TRT_TIME BETWEEN '0900' AND '1200') AND DOC_CODE NOT IN(
    SELECT DOC_CODE FROM DOCTOR WHERE DEP_CODE LIKE '05%' OR DEP_CODE LIKE '08%' OR DEP_CODE LIKE '13%')) ORDER BY PAT_CODE;
    
   

--3. 2014�� 1�� 1�� ����ȯ�� �� 5�� ���
-- (����ð����� �� ������ ����ȯ�� 5��)
SELECT P.PAT_CODE, PAT_NAME FROM PATIENT P,(
    SELECT rownum rank, PAT_CODE FROM (
        SELECT PAT_CODE FROM TREAT T WHERE TRT_YEAR=2014 AND TRT_DATE =0101 ORDER BY TRT_TIME DESC
            )E
        )R
        WHERE P.PAT_CODE=R.PAT_CODE AND rank<=5 ORDER BY P.PAT_CODE;
        

--���� 3
--1. 2013�� 1�� 25�� ������ ȯ���� ������ ������ȸ
-- �������, �����ǻ��, �����ð�, ȯ�ڹ�ȣ, ȯ���̸�, �������, ����
--(�����, ������, �����ð����� �������� ����)

--���� ������ �߿��ϴ�!!!! �߸��Ǹ� �ȵ�
SELECT dep.dep_name,doc.doc_name, tre.trt_time , pat.pat_name,
        pat.pat_birth,pat.pat_gender
FROM DEPARTMENT dep
INNER JOIN DOCTOR doc ON dep.dep_code=doc.dep_code
INNER JOIN TREAT tre ON tre.doc_code=doc.doc_code
INNER JOIN PATIENT pat ON pat.PAT_code=tre.pat_code
WHERE tre.trt_year=2013 and tre.trt_date=0125
ORDER BY dep.dep_name,doc.doc_name,tre.TRT_time;


--2. 2013�� 12�� 25�� ������ ȯ���� ���� ������ȸ
--��������, ȯ�ڹ�ȣ, ȯ���̸�, �������, ����
--*�� 2014�� ���ķ� �Կ��ߴ����� �ִٸ� �Կ�����, �Կ��ð��� ���
--(����ð� ���� ����)
-- OUTER JOIN (+)

SELECT tre.TRT_date,pat.pat_code, pat.pat_name,pat.pat_birth,pat.pat_gender,
inp.inp_date,inp.inp_time
FROM TREAT tre
INNER JOIN PATIENT pat ON tre.pat_code=pat.pat_code
LEFT OUTER JOIN INPATIENT inp ON inp.pat_code=pat.pat_code
WHERE tre.trt_year=2013 and tre.trt_date=1225
ORDER BY tre.TRT_time;


--���� 4
--1. 2014�� 1�� 2�� ����ȯ�� ��ü ������ȸ
--   ȯ�ڹ�ȣ, ȯ���̸�, �������, ����, �����ǻ��, �������
-- ��Į�� ���������� ǥ��
SELECT
    (SELECT pat_code FROM patient P WHERE p.pat_code=E.pat_code) as pnum,
    (SELECT pat_name FROM patient P WHERE p.pat_code=E.pat_code) as pname,
    (SELECT pat_birth from patient p where p.pat_code=E.pat_code) as pbirth,
    (SELECT pat_GENder from patient p where p.pat_code=E.pat_code) as pgender,
    (SELECT doc_name from doctor doc where doc.doc_code=E.doc_code) as docode,
    (SELECT dep_name from department dep where dep.dep_code=dc.dep_code)as dename
FROM
(SELECT * FROM TREAT T WHERE trt_year=2014 and trt_date=0102)E, DOCTOR dc WHERE E.doc_code=dc.doc_code
ORDER BY pnum;

    
--2.2014�� 1�� 2�� ����ȯ�� �� �μ����̺��� WHERE �� SubQuery�� 
--����Ͽ� ��ȸ
--   ȯ�ڹ�ȣ, ȯ���̸�, �������, ����, �����ǻ��, �������

-- �� �ܰ��迭 ȯ�ڸ���ȸ('02xx')
-- where�� subquery
    



