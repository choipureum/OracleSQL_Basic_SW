-- ������ ���� ������  || 
SELECT ename || job AS EMPLOYEE FROM emp; --�ΰ��� �����͸� ���ļ� �����ش�
SELECT ename || ' is ' ||job AS EMPLOYEE FROM emp; -- �˾ƺ��Ⱑ ����Ƿ� �߰��� �̾��ִ� ���� �߰��غ���
SELECT ename || '''s job is' ||job AS EMPLOYEE FROM emp; --'�� '��ü�� ���ڷ� ����ϰ� �ʹٸ� ''�ι� �Է����ָ�ȴ�

--SQL Functions
SELECT ename, length(ename) len FROM emp; --Single Row --/�Լ��� ȣ���� ������ �ٷ� �̸��� �÷��� �ݿ��Ǵµ� as�� �ٲ��ִ°� ����
SELECT count(*) FROM emp; --Group �Լ� --/��ü���� ���ִ� �Լ� count()

--���� �̷� ��� ����X �׳� emp�� �ุŭ 3���
SELECT 1+2 FROM emp;

--dual�� ����Ŭ���� �����ϴ� �⺻Ŭ���� -> ������� ����� Ȯ���� �� �ִ�(test��)
SELECT 1 FROM dual;
SELECT  1+2 FROM dual;
SELECT 1+2,6*5,5-7 FROM dual; --������ ���ο� �÷����� 3�ٸ����
SELECT 1+2 FIRST,6*5 SECOND,5-7 THIRD FROM dual;  --as �̸� ����

--�����Լ� abs() --���밪
SELECT ABS(-15) absolute FROM dual;
SELECT ABS(-543.124) FROM dual; --������ �Ǽ��� �������(����Ŭ�� ���� X)
SELECT abs(sal) FROM emp; --emp���� �޿��� ���밪���� ��ȭ�ؼ� �����ش�


---�����Լ� QUIZ---

--�ݿø� (ROUND)

-- 12.523 -> �Ҽ������� �ݿø�
SELECT round(12.523) FROM dual; 

-- -12.723 -> �Ҽ������� �ݿø�
SELECT round(12.723) FROM dual; 

-- 12.567 -> �Ҽ��� 3°�ڸ����� �ݿø�
SELECT round(12.567,2) FROM dual; 

-- 12345 -> 1�� �ڸ����� �ݿø�
SELECT round(12345,-1) FROM dual; 

-- 56789 -> 10�� �ڸ����� �ݿø�
SELECT round(56789,-2) FROM dual; 

--���� TRUNC -- truncate(�߶󳻴�)
-- 12.456 -> �Ҽ������� ����
SELECT FLOOR(12.456) FROM dual; 
SELECT TRUNC(12.456) FROM dual;

-- 12.456 -> �Ҽ��� 3°�ڸ����� ����
SELECT FLOOR(12.456*100)/100  FROM dual; 
SELECT TRUNC(12.456,2) FROM dual;

-- 12345 -> 1���ڸ����� ����
SELECT FLOOR(12345/10)*10 FROM dual; 
SELECT TRUNC(12345,-1) FROM dual;

-- 56789 -> 10���ڸ����� ����
SELECT FLOOR(56789/100)*100 FROM dual; 
SELECT TRUNC(56789,-2) FROM dual;

--������ MOD()
-- 13�� 8�� ���� ������
SELECT MOD(13,8) FROM dual; 

--�ø� CEIL()
-- 12.345 �ø� -> 13
SELECT CEIL(12.345) FROM dual; 

-- -12.567 �ø� -> -12
SELECT CEIL(-12.567) FROM dual;

--���� FLOOR()
-- 12.567 ���� -> 12
SELECT FLOOR(12.567)FROM dual;

-- 12.123 ���� -> 12
SELECT FLOOR(12.123)FROM dual;

-- -12.567 ���� -> -13
SELECT FLOOR(-12.567)FROM dual;

-- -12.123 ���� -> -13
SELECT FLOOR(-12.123)FROM dual;

--���� POWER()
-- 3�� 4���� -> 81
SELECT POWER(3,4) FROM DUAL;

-- 3�� -1 ���� -> 0.33333333333
SELECT POWER(3,-1) FROM DUAL;

--������ SQRT()
-- 9�� ������ -> 3
SELECT SQRT(9) FROM dual;

-- 11�� ������ -> 3.3166...
SELECT SQRT(11) FROM dual;


-------------------------------

--���� �Լ�--

--  length() --�ܼ� ���̸� ���

SELECT length('Apple') AS len1 FROM dual;
SELECT length('Apple') len1, length('�ȳ�') len2, length('Hello ����Ŭ')len3 FROM dual;

-- lengthb() --byte������ ���
SELECT 
    lengthb('Apple') len1, 
    lengthb('�ȳ�') len2, 
    lengthb('Hello ����Ŭ')len3 
FROM dual;

--ĳ���ͼ�(���ڵ�) Ȯ�� --������ִ� ���̺�(nls)
SELECT * FROM nls_database_parameters WHERE parameter='NLS_CHARACTERSET';

-- ���� �Լ� QUIZ --
-- ���� �Լ� ����

-- 'hELlo' ��� �빮�ڷ� ��ȯ -> HELLO
SELECT UPPER('hELlo') FROM dual;

-- 'hELlo' ��� �ҹ��ڷ� ��ȯ -> hello
SELECT LOWER('hELlo') FROM dual;

-- 'hELlo' �̴ϼ�(ù����) �빮�� -> Hello
SELECT INITCAP('hELlo') FROM dual;

-- 'Alice Bob'�� ���ڿ� ���� -> 9
SELECT length('Alice Bob') FROM dual;

-- '�ȳ��ϼ���'�� ���ڿ� ���� -> 5
SELECT lengthb('�ȳ��ϼ���') FROM dual;

-- 'Alice Bob' ���ڿ� ����Ʈ �� -> 9
SELECT lengthb('Alice Bob') FROM dual;

-- 'ACE �ȳ��ϼ���'���ڿ� ����Ʈ �� -> 19
SELECT lengthb('ACE �ȳ��ϼ���') FROM dual;

-- (����Ŭ�� �ѱ� ���ڵ��� UTF-8�� �⺻���� �ϸ�
--  UTF-8�� �ѱ� �ѱ��ڿ� 3����Ʈ�� �ʿ��ϴ�)

-- SQL������ ù��°�� 1�̴� 
-- 'ABCDEFGHI'���� 'D' �� ��ġ -> 4
SELECT INSTR('ABCDEFGHI','D') FROM dual;

-- 'ABCDEFGHI'���� 'DEF'���ڿ��� ��ġ ->4
SELECT INSTR('ABCDEFGHI','DEF') FROM dual;

-- 'ABCDEFGHI'���� 'DF'���ڿ��� ��ġ -> 0 --������ 0
SELECT INSTR('ABCDEFGHI','DF') FROM dual;

-- '�ȳ��ϼ���'���� '��'���ڿ��� ��ġ -> 3
SELECT INSTR('�ȳ��ϼ���','��') FROM dual;

 -- '�ȳ��ϼ���'���� '��' ���ڿ����� ����Ʈ
SELECT INSTRB('�ȳ��ϼ���','��') FROM dual;

-- 'ABCABCDDD'���� 'C'���ڿ��� ��ġ -> 3
SELECT INSTR('ABCABCDDD','C') FROM dual;

--'Oracle SQL Developer'���� 5��° �ε��� ������ ���ڿ��� �ڸ���
SELECT SUBSTR('Oracle SQL Developer',5) FROM dual;

--'Oracle SQL Developer'���� 5��° �ε������� 5���ڷ� �ڸ���
SELECT SUBSTR('Oracle SQL Developer',6,5) FROM dual; --5��° ����

--'����Ŭ SQL'���� 2��° �ε������� 5���ڷ� �ڸ���
SELECT SUBSTR('����Ŭ SQL',3,5) FROM dual;
SELECT SUBSTRB('����Ŭ SQL',3,5) FROM dual; --3��°���� �߶� 5����Ʈ �����Ͷ�
--'�ȳ��ϼ������Ŭ'���� 3��° ���� �ڸ���
SELECT SUBSTR('�ȳ��ϼ������Ŭ',3) FROM dual;


--�е� Padding --
-- ���ڸ� ǥ���ϱ� ���ؼ� ������ Ȯ���ϰ�
--���ڸ� ä���ְ�

--LEFT PADDING : lpad()
SELECT lpad('SQL',10) FROM dual; --10���� ������ ����� ���������� SQL���
SELECT lpad(ename,10) FROM emp;  -- 10ĭ�� Ȯ���ϰ� ���������� �� ���
-- ���ڼ����� ������ �۴ٸ� ���ڼ� ��ŭ�� ǥ�����ش�

--RIGHT PADDING : rpad()
SELECT rpad('SQL',10) FROM dual; --�����ʿ� 10���� ������ ����� SQL���

SELECT rpad('SQL',10,'*') FROM dual; --������ *�� ��


--TRIM()
 -- ������ �糡�ܿ� �ִ� ��������
SELECT '   SQL   ', ltrim('   SQL   '), rtrim('   SQL   '), trim('   SQL   ') FROM dual; --���ʰ������� ������ �������� ��--
SELECT ltrim(rtrim('   SQL   ')) FROM dual; -- = trim()



--��¥�Լ�, DATETIME--
 --sysdate 
 
SELECT sysdate FROM dual; --���ó�¥ ��� 20/3/24 :�����

--��¥�ð� Ÿ��->���� Ÿ��(��������)
SELECT to_char(sysdate,'YYYY/MM/DD HH24:MI:SS') now FROM dual; 

--MONTHS_BETWEEN : ���� �� ����
SELECT months_between('20-01-01','20-02-01') A FROM dual; --����-������ (1=1����)
SELECT months_between('20-01-01','20-02-01') A,round(months_between('20-01-01','20-02-15'),2) B FROM dual; --round�� �ݿø�

--next_day : ������ ������ �ٰ����� ��¥ ���ϱ�
SELECT next_day(sysdate,'��') FROM dual;


--trunc �Լ� (������)--trunc�� �Ű������� ����or��¥���� ** �߿�(�ð���00�÷� ������)
--trunc(datetime)
SELECT sysdate,to_char(sysdate,'YYYY/MM/DD HH24:MI:SS'),to_char(trunc(sysdate),'YYYY/MM/DD HH24:MI:SS') FROM dual;
--20/03/24	2020/03/24 19:43:17	2020/03/24 00:00:00

--���̴� ����� ������ �ð��� ���ԵǾ� ���� �ٸ� ���� ������
SELECT sysdate,trunc(sysdate) FROM dual;



-- ��ȯ�Լ� --
--2�� ���
--to_char(number)
--to_char(number,fmt) : ���Ĺ��ڸ� �̿��� ��ȯ --��������

SELECT 12345 "0" from dual; --����Ÿ��
SELECT to_char(12345) "1" from dual; --����Ÿ��
SELECT to_char(12345) "0", length(to_char(12345)) "1" from dual; --���̵� ��ȯ
SELECT length(12345) from dual; --���ڷ� �ȹٲ㵵 5�����´�(�ʿ����) --���� ���ڸ� �� �� ������ �ڵ�����ȯ�ȴ�

    --��������
    SELECT  to_char(12345,'99999') as ff FROM dual; --#�� ������ �Է°����� �������̾ ǥ�ð� �����ʴ´ٴ� ����
    SELECT  trim(to_char(12345,'999999999')) as ff FROM dual; --9�� ���ڰ� �����ִ� 1�ڸ� ��¶��̴�(������ ����)
    SELECT to_char(12345,'000000000000') FROM dual; -- 0���� ��ü ǥ���� �� ���ڸ� ä��
    SELECT to_char(12345,'999000000000') FROM dual;


    SELECT to_char(12345.6789)"1", to_char(12345.6789,'99999.9') "2" ,
         to_char(12345.6789,'9999999.99')"3",
         to_char(12345.6789,'9,999,999.99')"4", -->�˾Ƽ� ,(comma)�� ����
         to_char(12345.6789,'9,999,999.999999') "5" -->�Ҽ��� �Ʒ� ������ 0���� �˾Ƽ� ä���� ��ȯ
    FROM dual; --12345.6789 | 12345.7 --> ���ϰ� ���Ĵ�γ��´�
    
    SELECT 
        to_char(12345) "1",
        to_char(12345,'$9999999') "2", --> $�� �տ� �ٿ��ָ� $�� �����
        to_char(12345,'L9999999') "3", --> L�� ���̸� ���� �����.(Locale�� ����)--���� ȯ�濡 ���� �´� ���� ��ȯ
        trim(to_char(12345,'L9999999')) "4"
    FROM dual;

    
--to_char(datetime)
SELECT 
 --   sysdate,
--    to_char(sysdate,'SCC'), --21 --�������
--    to_char(to_date('369/1/7'),'SCC'), --��¥�� ��ȯ�ؼ� ������ �ν��� ��
--    to_char(sysdate,'YEAR'),--TWENTY TWENTY
--    to_char(sysdate,'Year'), --Twenty Twenty
--    to_char(sysdate,'YYYY'), --2020
--    to_char(sysdate,'YY'), --20
--    to_char(sysdate,'YYY'), --020
--    to_char(sysdate,'Y') --0
--    to_char(sysdate,'YYYYY') --20200 --0�� �ϳ� �� �پ��� (�߰����� ���� X)�׳�  YYYY Y�� ����
--    to_char(sysdate,'MM'), --03
--    to_char(sysdate,'MONTH'), --3��
--    to_char(sysdate,'MON') --3�� (������� �ѱ��̶� �Ȱ���)
--    to_char(sysdate,'Q'), --1(�б⸦ ��Ÿ��)
--    to_char(sysdate,'DD'), --24 (�Ѵ޴��� �ϼ�)
--    to_char(sysdate,'D'), --3(������ ���� �ϼ�)
--    to_char(sysdate,'DDD'), --084(�ϳ���� �ϼ�)
--    to_char(sysdate,'DAY'), --ȭ����
--    to_char(sysdate,'DY') --ȭ
--    to_char(sysdate, 'HH'), --09
      to_char(sysdate, 'HH12'), --09(��)
      to_char(sysdate, 'HH24'), --21(��)
      to_char(sysdate, 'MI'), --36(��)
      to_char(sysdate, 'SS'), -- 25(��)     
      to_char(sysdate, 'AM'), -- ����
      to_char(sysdate, 'PM'), --����
--    to_char(sysdate,'FF') --sysdate�� �и��ʰ� ����Ǿ����� �ʱ⶧���� ������ �߻��Ѵ�
      to_char(systimestamp,'FF') --483000(�и���)        
FROM dual;

SELECT systimestamp, sysdate FROM dual;--20/03/24 21:43:34.399000000 +09:00(timestamp) --Ÿ������ ����
                                     --20/03/24(sysdate)
--���� ��������   

SELECT 
    to_char(sysdate,'YYYY/MM/DD DAY HH24:MI:SS')
FROM dual;

--Q����
SELECT * FROM emp WHERE to_char(hiredate,'Q')=3; --3�б� ��ȯ





