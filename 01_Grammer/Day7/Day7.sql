--DATE
CREATE TABLE type_test05(
    data DATE);
    
INSERT INTO type_test05 VALUES(sysdate); --오늘날짜
INSERT INTO type_test05 VALUES('2020/11/21'); --문자열로 넣기(자동형변환)
INSERT INTO type_test05 VALUES(systimestamp); --밀리초까지
--연도를 음수로 사용할때는 단독으로 사용불가
INSERT INTO type_test05 VALUES('-2020/11/21'); --음수? -- 음수는 안된다
INSERT INTO type_test05 VALUES(to_date('-2020/11/21','syyyy/mm/dd')); --기원전 표현(yyyy앞에 s를 붙여준다)

SELECT to_char(data,'syyyy/mm/dd hh24:MI:SS') FROM type_test05;

--YeaR 의 y와 r
INSERT INTO type_test05 VALUES (to_date('12/7/9','yy/mm/dd')); --2012
INSERT INTO type_test05 VALUES (to_date('12/7/9','rr/mm/dd')); --2012
--yy : 현재년도+94
INSERT INTO type_test05 VALUES (to_date('94/7/9','yy/mm/dd')); --2094
--rr : 현재년도와 입력한 년도에 따라 달라진다
INSERT INTO type_test05 VALUES (to_date('94/7/9','rr/mm/dd')); --1994 --이전세기

--LONG 
--제약이 있는 크기만 커진  VARCHAR2
CREATE TABLE type_test06(
    data1 LONG);
    
SELECT * FROM type_test06;

INSERT INTO type_test06 VALUES('안녕하세요'); 

--CLOB

CREATE TABLE type_test07(
    data CLOB);
INSERT INTO type_test07 VALUES('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque rhoncus, lorem tincidunt luctus egestas, risus arcu cursus risus, nec vulputate sapien magna id risus. Aliquam vel scelerisque arcu. Maecenas nec sagittis nibh. Proin venenatis nunc et elit facilisis congue. Duis laoreet dolor eget ex suscipit, et tristique tortor bibendum. Ut elit dolor, faucibus eu dignissim eget, porta quis magna. Proin dignissim metus ut dui posuere, quis euismod odio commodo. Pellentesque quis auctor lectus, non efficitur ligula. Proin quis sapien purus. Duis sed dui lobortis, porta dui non, scelerisque odio. Nullam vitae dui sit amet velit rhoncus rhoncus. Nam sit amet tincidunt leo, in convallis lorem. Nullam congue nulla at ex luctus tempor.');
INSERT INTO type_test07 VALUES('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque rhoncus, lorem tincidunt luctus egestas, risus arcu cursus risus, nec vulputate sapien magna id risus. Aliquam vel scelerisque arcu. Maecenas nec sagittis nibh. Proin venenatis nunc et elit facilisis congue. Duis laoreet dolor eget ex suscipit, et tristique tortor bibendum. Ut elit dolor, faucibus eu dignissim eget, porta quis magna. Proin dignissim metus ut dui posuere, quis euismod odio commodo. Pellentesque quis auctor lectus, non efficitur ligula. Proin quis sapien purus. Duis sed dui lobortis, porta dui non, scelerisque odio. Nullam vitae dui sit amet velit rhoncus rhoncus. Nam sit amet tincidunt leo, in convallis lorem. Nullam congue nulla at ex luctus tempor.');

SELECT * FROM type_test07; --LONG 타입일때는 모두 표시했지만 clob로 하니 뒤가 생략 ...으로 나타낸다

--CLOB 데이터 전체조회

SELECT DBMS_LOB.SUBSTR(data,length(data),1) FROM type_test07;


CREATE TABLE type_test08(
    data VARCHAR(3)); --> VARCHAR은 없어질 예정 사용하지말고 VARCHAR2사용하기
    


-- 제약사항
--NOT NULL

CREATE TABLE cons_01(
    data VARCHAR2(10) NOT NULL); --NULL값을 받지 않음
     --NULL이 들어가면 에러발생
DESC cons_01;
--INSERT INTO cons_01 VALUES(null); --에러
-- 제약조건 자료사전
SELECT * FROM user_constraints WHERE table_name =upper('cons_01');
--user, all, sys등이 존재 -각각에 맞는 제약조건 반환
--table_name이 CONS_01에 걸린 제약조건 반환

--제약조건이 부여된 컬럼 정보 자료사전
SELECT * FROM user_cons_columns WHERE table_name = upper('cons_01');
--테이블 정보 자료사전
SELECT * FROM tab;
SELECT * FROM tabs;--tab상세버전--제약사항은 안나옴

-- DB의 모든 테이블 정보 자료사전   
SELECT * FROM all_tables;

--NOT NULL 제약조건에 이름 붙여서 설정하기
CREATE TABLE cons_02( 
    data VARCHAR2(10) CONSTRAINT cons_02_nn NOT NULL);
SELECT * FROM user_constraints WHERE table_name = upper('cons_02');

-- 제약조건 없이 테이블 생성
CREATE TABLE cons_03(
    data VARCHAR2(10));
--NOT NULL 제약조건은 컬럼의 데이터타입에 결합되어있다
--NOT NULL 제약조건을 반영할 때는 데이터타입을 변경해야한다
ALTER TABLE cons_03 MODIFY data NOT NULL;  
DESC cons_03;

--제약조건 추가 -UNIQUE (총 3가지  )
ALTER TABLE cons_03 ADD CONSTRAINT cons_03_uk UNIQUE (data);  --컬럼레벨 

-- CREATE TABLE 구문에서 제약조건 거는 두가지 방법--테이블레벨
CREATE TABLE cons_04(
    data VARCHAR2(10) CONSTRAINT cons_uk UNIQUE); --data가 앞에 정의 되있으므로 안적어도됨
   
CREATE TABLE cons_05(
    data VARCHAR2(10),
    CONSTRAINT cons05_uk UNIQUE(data));  --CONSTRAINT절은 계속해서 넣어줄수잇다

--CHECK

CREATE TABLE cons_06(
    data NUMBER CHECK(data>=1 AND data<=100));  --WHERE절에 들어갈 수 잇는 조건 모두 사용가능

INSERT INTO cons_06 VALUES(100);
--INSERT INTO cons_06 VALUES(200); --에러발생 1~100사이가 아니다
SELECT * FROM user_constraints WHERE table_name =upper('cons_06'); --searck_condition 컬럼에 들어간다

SELECT * FROM user_cons_columns WHERE constraint_name = upper('SYS_C007033');


-- cons_07 테이블 생성
-- 컬럼: data NUMBER
-- ALTER TABLE 구문을 이용하여 data에 제약사항 CHECK 추가하기
--1000,2000,3000,4000 만 입력 가능하도록 만들기
SELECT * FROM cons_07;
CREATE TABLE cons_07(
    data NUMBER);
ALTER TABLE cons_07 ADD CONSTRAINT cons_ck CHECK (data IN(1000,2000,3000,4000));-- check() 괄호 해줘야한다
ALTER TABLE cons_07 MODIFY CONSTRAINT cons_ck2 CHECK(data IN(1000,2000,3000,4000)); --이것도 가능
INSERT INTO cons_07 VALUES(1000);
INSERT INTO cons_07 VALUES(2000);
--INSERT INTO cons_07 VALUES(6000); --에러


--DEFAULT

CREATE TABLE cons_08(
    data1 NUMBER DEFAULT 10,
    data2 DATE,
    data3 VARCHAR2(10));


-- 테이블 컬럼 상세 정보 자료사전 보기
SELECT * FROM user_constraints WHERE table_name = upper('cons_08'); --여기에 정보 없음
SELECT * FROM user_tab_columns WHERE table_name = upper('cons_08'); --여기서 볼수 잇음

ALTER TABLE cons_08 MODIFY data2 DEFAULT sysdate;

INSERT INTO cons_08 VALUES(null,null,'AA'); --defalut가 아니다 그냥 null로 들어감

INSERT INTO CONS_08(data1) VALUES(666); --이건 default가 적용되서 넣지 않은 공간에 default가 들어감
SELECT * FROM cons_08;

-- DEFAULT 주의사항
--INSERT INTO cons_08 -->에러 발생 이렇게 하면 안됨 VALUES()도 안됨, 값을 1개라도 넣어야한다( 그래도 모두 3개 동시에 default는 안됨)

--PRIMARY KEY 지정하기

--1 ) 컬럼에 제약조건 이름을 명시하며 지정하기
CREATE TABLE cons_09(
    no NUMBER CONSTRAINT cons_09_pk PRIMARY KEY,
    data VARCHAR(20) NOT NULL);

--2 ) 컬럼에 제약조건 이름없이 지정하기
CREATE TABLE cons_10(
    no NUMBER PRIMARY KEY, --이름없이 제약조건 추가
    data VARCHAR(20) NOT NULL);

--3 ) 컬럼 설정 이후에 CONSTRAINT 키워드로 지정하기
CREATE TABLE cons_11(
    no NUMBER,
    data VARCHAR(20) NOT NULL,
    CONSTRAINT cons_11_pk PRIMARY KEY(no)
    );
    
--4 ) 테이블 생성 이후 ALTER TABLE 지정하기
CREATE TABLE cons_12 (
    NO NUMBER ,
    DATA VARCHAR2(20) NOT NULL );
ALTER TABLE cons_12 ADD CONSTRAINT cons_12_pk PRIMARY KEY(no); --alter로 해주기

    
--복합키, 슈퍼키 (하나의 키가 기본키가 되기힘들때 (ex)거래날짜+거래순서)
CREATE TABLE cons_13(
    trade_date DATE,
    trade_no NUMBER);

ALTER TABLE cons_13 ADD CONSTRAINT cons_13_pk PRIMARY KEY(trade_date, trade_no); --함께 지정
ALTER TABLE cons_13 DROP CONSTRAINT cons_13_pk; --제약조건 제거 

--함께쓰면 이것도 가능
CREATE TABLE cons_13(
    trade_date DATE,
    trade_no NUMBER,
    CONSTRAINT cons_13_pk PRIMARY KEY(trade_date, trade_no));

--FOREIGN KEY
SELECT * FROM user_constraints WHERE table_name = upper('cons_12');

CREATE TABLE cons_14(
    num NUMBER,
    data VARCHAR2(50),
    CONSTRAINT cons_14_fk  --자기 테이블의 fk
        FOREIGN KEY (num) REFERENCES cons_12(no) --참조테이블의 pk
        --ON DELETE SET NULL); -pk가 삭제되면 fk는 null이됨
        ON DELETE CASCADE); --pk가 삭제되면 fk도 삭제됨
SELECT * FROM cons_14;

-- 따로 해보기 
CREATE TABLE cons_15(
    num NUMBER,
    data VARCHAR2(50));
    
ALTER TABLE cons_15 ADD CONSTRAINT cons_15_fk FOREIGN KEY(num) REFERENCES cons_12(no);
    
UPDATE emp SET deptno =null; --dept와 emp는 참조관계이므로 dept를 삭제하려면 참조하고 있는 애들을 null로 바꿔주거나 삭제해야 삭제가능하다
rollback;

CREATE TABLE emp_test AS SELECT rownum no, E.* FROM emp E; --> 번호를 매겨준다 ->  rownum

    
    
    
    
    
    
    
    
    
    
    
    





















