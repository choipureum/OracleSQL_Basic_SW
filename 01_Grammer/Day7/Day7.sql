--DATE
CREATE TABLE type_test05(
    data DATE);
    
INSERT INTO type_test05 VALUES(sysdate); --���ó�¥
INSERT INTO type_test05 VALUES('2020/11/21'); --���ڿ��� �ֱ�(�ڵ�����ȯ)
INSERT INTO type_test05 VALUES(systimestamp); --�и��ʱ���
--������ ������ ����Ҷ��� �ܵ����� ���Ұ�
INSERT INTO type_test05 VALUES('-2020/11/21'); --����? -- ������ �ȵȴ�
INSERT INTO type_test05 VALUES(to_date('-2020/11/21','syyyy/mm/dd')); --����� ǥ��(yyyy�տ� s�� �ٿ��ش�)

SELECT to_char(data,'syyyy/mm/dd hh24:MI:SS') FROM type_test05;

--YeaR �� y�� r
INSERT INTO type_test05 VALUES (to_date('12/7/9','yy/mm/dd')); --2012
INSERT INTO type_test05 VALUES (to_date('12/7/9','rr/mm/dd')); --2012
--yy : ����⵵+94
INSERT INTO type_test05 VALUES (to_date('94/7/9','yy/mm/dd')); --2094
--rr : ����⵵�� �Է��� �⵵�� ���� �޶�����
INSERT INTO type_test05 VALUES (to_date('94/7/9','rr/mm/dd')); --1994 --��������

--LONG 
--������ �ִ� ũ�⸸ Ŀ��  VARCHAR2
CREATE TABLE type_test06(
    data1 LONG);
    
SELECT * FROM type_test06;

INSERT INTO type_test06 VALUES('�ȳ��ϼ���'); 

--CLOB

CREATE TABLE type_test07(
    data CLOB);
INSERT INTO type_test07 VALUES('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque rhoncus, lorem tincidunt luctus egestas, risus arcu cursus risus, nec vulputate sapien magna id risus. Aliquam vel scelerisque arcu. Maecenas nec sagittis nibh. Proin venenatis nunc et elit facilisis congue. Duis laoreet dolor eget ex suscipit, et tristique tortor bibendum. Ut elit dolor, faucibus eu dignissim eget, porta quis magna. Proin dignissim metus ut dui posuere, quis euismod odio commodo. Pellentesque quis auctor lectus, non efficitur ligula. Proin quis sapien purus. Duis sed dui lobortis, porta dui non, scelerisque odio. Nullam vitae dui sit amet velit rhoncus rhoncus. Nam sit amet tincidunt leo, in convallis lorem. Nullam congue nulla at ex luctus tempor.');
INSERT INTO type_test07 VALUES('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque rhoncus, lorem tincidunt luctus egestas, risus arcu cursus risus, nec vulputate sapien magna id risus. Aliquam vel scelerisque arcu. Maecenas nec sagittis nibh. Proin venenatis nunc et elit facilisis congue. Duis laoreet dolor eget ex suscipit, et tristique tortor bibendum. Ut elit dolor, faucibus eu dignissim eget, porta quis magna. Proin dignissim metus ut dui posuere, quis euismod odio commodo. Pellentesque quis auctor lectus, non efficitur ligula. Proin quis sapien purus. Duis sed dui lobortis, porta dui non, scelerisque odio. Nullam vitae dui sit amet velit rhoncus rhoncus. Nam sit amet tincidunt leo, in convallis lorem. Nullam congue nulla at ex luctus tempor.');

SELECT * FROM type_test07; --LONG Ÿ���϶��� ��� ǥ�������� clob�� �ϴ� �ڰ� ���� ...���� ��Ÿ����

--CLOB ������ ��ü��ȸ

SELECT DBMS_LOB.SUBSTR(data,length(data),1) FROM type_test07;


CREATE TABLE type_test08(
    data VARCHAR(3)); --> VARCHAR�� ������ ���� ����������� VARCHAR2����ϱ�
    


-- �������
--NOT NULL

CREATE TABLE cons_01(
    data VARCHAR2(10) NOT NULL); --NULL���� ���� ����
     --NULL�� ���� �����߻�
DESC cons_01;
--INSERT INTO cons_01 VALUES(null); --����
-- �������� �ڷ����
SELECT * FROM user_constraints WHERE table_name =upper('cons_01');
--user, all, sys���� ���� -������ �´� �������� ��ȯ
--table_name�� CONS_01�� �ɸ� �������� ��ȯ

--���������� �ο��� �÷� ���� �ڷ����
SELECT * FROM user_cons_columns WHERE table_name = upper('cons_01');
--���̺� ���� �ڷ����
SELECT * FROM tab;
SELECT * FROM tabs;--tab�󼼹���--��������� �ȳ���

-- DB�� ��� ���̺� ���� �ڷ����   
SELECT * FROM all_tables;

--NOT NULL �������ǿ� �̸� �ٿ��� �����ϱ�
CREATE TABLE cons_02( 
    data VARCHAR2(10) CONSTRAINT cons_02_nn NOT NULL);
SELECT * FROM user_constraints WHERE table_name = upper('cons_02');

-- �������� ���� ���̺� ����
CREATE TABLE cons_03(
    data VARCHAR2(10));
--NOT NULL ���������� �÷��� ������Ÿ�Կ� ���յǾ��ִ�
--NOT NULL ���������� �ݿ��� ���� ������Ÿ���� �����ؾ��Ѵ�
ALTER TABLE cons_03 MODIFY data NOT NULL;  
DESC cons_03;

--�������� �߰� -UNIQUE (�� 3����  )
ALTER TABLE cons_03 ADD CONSTRAINT cons_03_uk UNIQUE (data);  --�÷����� 

-- CREATE TABLE �������� �������� �Ŵ� �ΰ��� ���--���̺���
CREATE TABLE cons_04(
    data VARCHAR2(10) CONSTRAINT cons_uk UNIQUE); --data�� �տ� ���� �������Ƿ� �������
   
CREATE TABLE cons_05(
    data VARCHAR2(10),
    CONSTRAINT cons05_uk UNIQUE(data));  --CONSTRAINT���� ����ؼ� �־��ټ��մ�

--CHECK

CREATE TABLE cons_06(
    data NUMBER CHECK(data>=1 AND data<=100));  --WHERE���� �� �� �մ� ���� ��� ��밡��

INSERT INTO cons_06 VALUES(100);
--INSERT INTO cons_06 VALUES(200); --�����߻� 1~100���̰� �ƴϴ�
SELECT * FROM user_constraints WHERE table_name =upper('cons_06'); --searck_condition �÷��� ����

SELECT * FROM user_cons_columns WHERE constraint_name = upper('SYS_C007033');


-- cons_07 ���̺� ����
-- �÷�: data NUMBER
-- ALTER TABLE ������ �̿��Ͽ� data�� ������� CHECK �߰��ϱ�
--1000,2000,3000,4000 �� �Է� �����ϵ��� �����
SELECT * FROM cons_07;
CREATE TABLE cons_07(
    data NUMBER);
ALTER TABLE cons_07 ADD CONSTRAINT cons_ck CHECK (data IN(1000,2000,3000,4000));-- check() ��ȣ ������Ѵ�
ALTER TABLE cons_07 MODIFY CONSTRAINT cons_ck2 CHECK(data IN(1000,2000,3000,4000)); --�̰͵� ����
INSERT INTO cons_07 VALUES(1000);
INSERT INTO cons_07 VALUES(2000);
--INSERT INTO cons_07 VALUES(6000); --����


--DEFAULT

CREATE TABLE cons_08(
    data1 NUMBER DEFAULT 10,
    data2 DATE,
    data3 VARCHAR2(10));


-- ���̺� �÷� �� ���� �ڷ���� ����
SELECT * FROM user_constraints WHERE table_name = upper('cons_08'); --���⿡ ���� ����
SELECT * FROM user_tab_columns WHERE table_name = upper('cons_08'); --���⼭ ���� ����

ALTER TABLE cons_08 MODIFY data2 DEFAULT sysdate;

INSERT INTO cons_08 VALUES(null,null,'AA'); --defalut�� �ƴϴ� �׳� null�� ��

INSERT INTO CONS_08(data1) VALUES(666); --�̰� default�� ����Ǽ� ���� ���� ������ default�� ��
SELECT * FROM cons_08;

-- DEFAULT ���ǻ���
--INSERT INTO cons_08 -->���� �߻� �̷��� �ϸ� �ȵ� VALUES()�� �ȵ�, ���� 1���� �־���Ѵ�( �׷��� ��� 3�� ���ÿ� default�� �ȵ�)

--PRIMARY KEY �����ϱ�

--1 ) �÷��� �������� �̸��� ����ϸ� �����ϱ�
CREATE TABLE cons_09(
    no NUMBER CONSTRAINT cons_09_pk PRIMARY KEY,
    data VARCHAR(20) NOT NULL);

--2 ) �÷��� �������� �̸����� �����ϱ�
CREATE TABLE cons_10(
    no NUMBER PRIMARY KEY, --�̸����� �������� �߰�
    data VARCHAR(20) NOT NULL);

--3 ) �÷� ���� ���Ŀ� CONSTRAINT Ű����� �����ϱ�
CREATE TABLE cons_11(
    no NUMBER,
    data VARCHAR(20) NOT NULL,
    CONSTRAINT cons_11_pk PRIMARY KEY(no)
    );
    
--4 ) ���̺� ���� ���� ALTER TABLE �����ϱ�
CREATE TABLE cons_12 (
    NO NUMBER ,
    DATA VARCHAR2(20) NOT NULL );
ALTER TABLE cons_12 ADD CONSTRAINT cons_12_pk PRIMARY KEY(no); --alter�� ���ֱ�

    
--����Ű, ����Ű (�ϳ��� Ű�� �⺻Ű�� �Ǳ����鶧 (ex)�ŷ���¥+�ŷ�����)
CREATE TABLE cons_13(
    trade_date DATE,
    trade_no NUMBER);

ALTER TABLE cons_13 ADD CONSTRAINT cons_13_pk PRIMARY KEY(trade_date, trade_no); --�Բ� ����
ALTER TABLE cons_13 DROP CONSTRAINT cons_13_pk; --�������� ���� 

--�Բ����� �̰͵� ����
CREATE TABLE cons_13(
    trade_date DATE,
    trade_no NUMBER,
    CONSTRAINT cons_13_pk PRIMARY KEY(trade_date, trade_no));

--FOREIGN KEY
SELECT * FROM user_constraints WHERE table_name = upper('cons_12');

CREATE TABLE cons_14(
    num NUMBER,
    data VARCHAR2(50),
    CONSTRAINT cons_14_fk  --�ڱ� ���̺��� fk
        FOREIGN KEY (num) REFERENCES cons_12(no) --�������̺��� pk
        --ON DELETE SET NULL); -pk�� �����Ǹ� fk�� null�̵�
        ON DELETE CASCADE); --pk�� �����Ǹ� fk�� ������
SELECT * FROM cons_14;

-- ���� �غ��� 
CREATE TABLE cons_15(
    num NUMBER,
    data VARCHAR2(50));
    
ALTER TABLE cons_15 ADD CONSTRAINT cons_15_fk FOREIGN KEY(num) REFERENCES cons_12(no);
    
UPDATE emp SET deptno =null; --dept�� emp�� ���������̹Ƿ� dept�� �����Ϸ��� �����ϰ� �ִ� �ֵ��� null�� �ٲ��ְų� �����ؾ� ���������ϴ�
rollback;

CREATE TABLE emp_test AS SELECT rownum no, E.* FROM emp E; --> ��ȣ�� �Ű��ش� ->  rownum

    
    
    
    
    
    
    
    
    
    
    
    





















