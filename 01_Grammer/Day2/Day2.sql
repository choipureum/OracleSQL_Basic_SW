-- 데이터 연결 연산자  || 
SELECT ename || job AS EMPLOYEE FROM emp; --두개의 데이터를 합쳐서 보여준다
SELECT ename || ' is ' ||job AS EMPLOYEE FROM emp; -- 알아보기가 힘드므로 중간에 이어주는 말을 추가해본다
SELECT ename || '''s job is' ||job AS EMPLOYEE FROM emp; --'을 '자체의 문자로 사용하고 싶다면 ''두번 입력해주면된다

--SQL Functions
SELECT ename, length(ename) len FROM emp; --Single Row --/함수를 호출한 내용이 바로 이름이 컬럼명에 반영되는데 as로 바꿔주는게 좋다
SELECT count(*) FROM emp; --Group 함수 --/전체행을 세주는 함수 count()

--원래 이런 기능 제공X 그냥 emp의 행만큼 3출력
SELECT 1+2 FROM emp;

--dual은 오라클에서 제공하는 기본클래스 -> 연산등의 결과를 확인할 수 있다(test용)
SELECT 1 FROM dual;
SELECT  1+2 FROM dual;
SELECT 1+2,6*5,5-7 FROM dual; --각각의 새로운 컬럼으로 3줄만든다
SELECT 1+2 FIRST,6*5 SECOND,5-7 THIRD FROM dual;  --as 이름 설정

--숫자함수 abs() --절대값
SELECT ABS(-15) absolute FROM dual;
SELECT ABS(-543.124) FROM dual; --정수든 실수든 상관없다(오라클은 구분 X)
SELECT abs(sal) FROM emp; --emp에서 급여를 절대값으로 변화해서 보여준다


---숫자함수 QUIZ---

--반올림 (ROUND)

-- 12.523 -> 소수점이하 반올림
SELECT round(12.523) FROM dual; 

-- -12.723 -> 소수점이하 반올림
SELECT round(12.723) FROM dual; 

-- 12.567 -> 소수점 3째자리에서 반올림
SELECT round(12.567,2) FROM dual; 

-- 12345 -> 1의 자리에서 반올림
SELECT round(12345,-1) FROM dual; 

-- 56789 -> 10의 자리에서 반올림
SELECT round(56789,-2) FROM dual; 

--버림 TRUNC -- truncate(잘라내다)
-- 12.456 -> 소수점이하 버림
SELECT FLOOR(12.456) FROM dual; 
SELECT TRUNC(12.456) FROM dual;

-- 12.456 -> 소수점 3째자리에서 버림
SELECT FLOOR(12.456*100)/100  FROM dual; 
SELECT TRUNC(12.456,2) FROM dual;

-- 12345 -> 1의자리에서 버림
SELECT FLOOR(12345/10)*10 FROM dual; 
SELECT TRUNC(12345,-1) FROM dual;

-- 56789 -> 10의자리에서 버림
SELECT FLOOR(56789/100)*100 FROM dual; 
SELECT TRUNC(56789,-2) FROM dual;

--나머지 MOD()
-- 13을 8로 나눈 나머지
SELECT MOD(13,8) FROM dual; 

--올림 CEIL()
-- 12.345 올림 -> 13
SELECT CEIL(12.345) FROM dual; 

-- -12.567 올림 -> -12
SELECT CEIL(-12.567) FROM dual;

--내림 FLOOR()
-- 12.567 내림 -> 12
SELECT FLOOR(12.567)FROM dual;

-- 12.123 내림 -> 12
SELECT FLOOR(12.123)FROM dual;

-- -12.567 내림 -> -13
SELECT FLOOR(-12.567)FROM dual;

-- -12.123 내림 -> -13
SELECT FLOOR(-12.123)FROM dual;

--제곱 POWER()
-- 3의 4제곱 -> 81
SELECT POWER(3,4) FROM DUAL;

-- 3의 -1 제곱 -> 0.33333333333
SELECT POWER(3,-1) FROM DUAL;

--제곱근 SQRT()
-- 9의 제곱근 -> 3
SELECT SQRT(9) FROM dual;

-- 11의 제곱근 -> 3.3166...
SELECT SQRT(11) FROM dual;


-------------------------------

--문자 함수--

--  length() --단순 길이를 출력

SELECT length('Apple') AS len1 FROM dual;
SELECT length('Apple') len1, length('안녕') len2, length('Hello 오라클')len3 FROM dual;

-- lengthb() --byte값으로 출력
SELECT 
    lengthb('Apple') len1, 
    lengthb('안녕') len2, 
    lengthb('Hello 오라클')len3 
FROM dual;

--캐릭터셋(인코딩) 확인 --저장되있는 테이블(nls)
SELECT * FROM nls_database_parameters WHERE parameter='NLS_CHARACTERSET';

-- 문자 함수 QUIZ --
-- 문자 함수 문제

-- 'hELlo' 모두 대문자로 변환 -> HELLO
SELECT UPPER('hELlo') FROM dual;

-- 'hELlo' 모두 소문자로 변환 -> hello
SELECT LOWER('hELlo') FROM dual;

-- 'hELlo' 이니셜(첫글자) 대문자 -> Hello
SELECT INITCAP('hELlo') FROM dual;

-- 'Alice Bob'의 문자열 길이 -> 9
SELECT length('Alice Bob') FROM dual;

-- '안녕하세요'의 문자열 길이 -> 5
SELECT lengthb('안녕하세요') FROM dual;

-- 'Alice Bob' 문자열 바이트 수 -> 9
SELECT lengthb('Alice Bob') FROM dual;

-- 'ACE 안녕하세요'문자열 바이트 수 -> 19
SELECT lengthb('ACE 안녕하세요') FROM dual;

-- (오라클은 한글 인코딩을 UTF-8을 기본으로 하며
--  UTF-8은 한글 한글자에 3바이트가 필요하다)

-- SQL에서는 첫번째가 1이다 
-- 'ABCDEFGHI'에서 'D' 의 위치 -> 4
SELECT INSTR('ABCDEFGHI','D') FROM dual;

-- 'ABCDEFGHI'에서 'DEF'문자열의 위치 ->4
SELECT INSTR('ABCDEFGHI','DEF') FROM dual;

-- 'ABCDEFGHI'에서 'DF'문자열의 위치 -> 0 --없으면 0
SELECT INSTR('ABCDEFGHI','DF') FROM dual;

-- '안녕하세요'에서 '하'문자열의 위치 -> 3
SELECT INSTR('안녕하세요','하') FROM dual;

 -- '안녕하세요'에서 '하' 문자열까지 바이트
SELECT INSTRB('안녕하세요','하') FROM dual;

-- 'ABCABCDDD'에서 'C'문자열의 위치 -> 3
SELECT INSTR('ABCABCDDD','C') FROM dual;

--'Oracle SQL Developer'에서 5번째 인덱스 이후의 문자열로 자르기
SELECT SUBSTR('Oracle SQL Developer',5) FROM dual;

--'Oracle SQL Developer'에서 5번째 인덱스부터 5글자로 자르기
SELECT SUBSTR('Oracle SQL Developer',6,5) FROM dual; --5번째 이후

--'오라클 SQL'에서 2번째 인덱스부터 5글자로 자르기
SELECT SUBSTR('오라클 SQL',3,5) FROM dual;
SELECT SUBSTRB('오라클 SQL',3,5) FROM dual; --3번째부터 잘라서 5바이트 가져와라
--'안녕하세요오라클'에서 3번째 부터 자르기
SELECT SUBSTR('안녕하세요오라클',3) FROM dual;


--패딩 Padding --
-- 문자를 표현하기 위해서 공간을 확보하고
--문자를 채워넣고

--LEFT PADDING : lpad()
SELECT lpad('SQL',10) FROM dual; --10개의 공간을 만든뒤 오른쪽으로 SQL출력
SELECT lpad(ename,10) FROM emp;  -- 10칸을 확보하고 오른쪽으로 값 출력
-- 글자수보다 공백이 작다면 글자수 만큼만 표현해준다

--RIGHT PADDING : rpad()
SELECT rpad('SQL',10) FROM dual; --오른쪽에 10개의 공간을 만든뒤 SQL출력

SELECT rpad('SQL',10,'*') FROM dual; --공백대신 *이 들어감


--TRIM()
 -- 데이터 양끝단에 있는 공백제거
SELECT '   SQL   ', ltrim('   SQL   '), rtrim('   SQL   '), trim('   SQL   ') FROM dual; --왼쪽공백제거 오른쪽 공백제거 등--
SELECT ltrim(rtrim('   SQL   ')) FROM dual; -- = trim()



--날짜함수, DATETIME--
 --sysdate 
 
SELECT sysdate FROM dual; --오늘날짜 출력 20/3/24 :년원일

--날짜시간 타입->문자 타입(서식지정)
SELECT to_char(sysdate,'YYYY/MM/DD HH24:MI:SS') now FROM dual; 

--MONTHS_BETWEEN : 개월 수 차이
SELECT months_between('20-01-01','20-02-01') A FROM dual; --왼쪽-오른쪽 (1=1개월)
SELECT months_between('20-01-01','20-02-01') A,round(months_between('20-01-01','20-02-15'),2) B FROM dual; --round로 반올림

--next_day : 지정된 요일이 다가오는 날짜 구하기
SELECT next_day(sysdate,'금') FROM dual;


--trunc 함수 (버리기)--trunc는 매개변수로 숫자or날짜가능 ** 중요(시간을00시로 버린다)
--trunc(datetime)
SELECT sysdate,to_char(sysdate,'YYYY/MM/DD HH24:MI:SS'),to_char(trunc(sysdate),'YYYY/MM/DD HH24:MI:SS') FROM dual;
--20/03/24	2020/03/24 19:43:17	2020/03/24 00:00:00

--보이는 결과는 같지만 시간이 포함되어 서로 다른 값을 가진다
SELECT sysdate,trunc(sysdate) FROM dual;



-- 변환함수 --
--2개 방법
--to_char(number)
--to_char(number,fmt) : 서식문자를 이용한 변환 --서식지정

SELECT 12345 "0" from dual; --숫자타입
SELECT to_char(12345) "1" from dual; --문자타입
SELECT to_char(12345) "0", length(to_char(12345)) "1" from dual; --길이도 반환
SELECT length(12345) from dual; --문자로 안바꿔도 5가나온다(필요없다) --원래 숫자만 들어갈 수 있지만 자동형변환된다

    --서식지정
    SELECT  to_char(12345,'99999') as ff FROM dual; --#이 나오면 입력값보다 작은값이어서 표시가 되지않는다는 오류
    SELECT  trim(to_char(12345,'999999999')) as ff FROM dual; --9는 숫자가 들어갈수있는 1자리 라는뜻이다(없으면 공백)
    SELECT to_char(12345,'000000000000') FROM dual; -- 0으로 전체 표현한 뒤 숫자를 채움
    SELECT to_char(12345,'999000000000') FROM dual;


    SELECT to_char(12345.6789)"1", to_char(12345.6789,'99999.9') "2" ,
         to_char(12345.6789,'9999999.99')"3",
         to_char(12345.6789,'9,999,999.99')"4", -->알아서 ,(comma)도 붙음
         to_char(12345.6789,'9,999,999.999999') "5" -->소수점 아래 형식은 0으로 알아서 채워서 반환
    FROM dual; --12345.6789 | 12345.7 --> 편하게 서식대로나온다
    
    SELECT 
        to_char(12345) "1",
        to_char(12345,'$9999999') "2", --> $를 앞에 붙여주면 $가 생긴다
        to_char(12345,'L9999999') "3", --> L을 붙이면 ￦이 생긴다.(Locale의 약자)--언어와 환경에 대한 맞는 값이 반환
        trim(to_char(12345,'L9999999')) "4"
    FROM dual;

    
--to_char(datetime)
SELECT 
 --   sysdate,
--    to_char(sysdate,'SCC'), --21 --세기출력
--    to_char(to_date('369/1/7'),'SCC'), --날짜로 변환해서 넣으면 인식은 됨
--    to_char(sysdate,'YEAR'),--TWENTY TWENTY
--    to_char(sysdate,'Year'), --Twenty Twenty
--    to_char(sysdate,'YYYY'), --2020
--    to_char(sysdate,'YY'), --20
--    to_char(sysdate,'YYY'), --020
--    to_char(sysdate,'Y') --0
--    to_char(sysdate,'YYYYY') --20200 --0이 하나 더 붙었음 (추가적인 연도 X)그냥  YYYY Y랑 같다
--    to_char(sysdate,'MM'), --03
--    to_char(sysdate,'MONTH'), --3월
--    to_char(sysdate,'MON') --3월 (약어지만 한글이라 똑같다)
--    to_char(sysdate,'Q'), --1(분기를 나타냄)
--    to_char(sysdate,'DD'), --24 (한달단위 일수)
--    to_char(sysdate,'D'), --3(일주일 단위 일수)
--    to_char(sysdate,'DDD'), --084(일년단위 일수)
--    to_char(sysdate,'DAY'), --화요일
--    to_char(sysdate,'DY') --화
--    to_char(sysdate, 'HH'), --09
      to_char(sysdate, 'HH12'), --09(시)
      to_char(sysdate, 'HH24'), --21(시)
      to_char(sysdate, 'MI'), --36(분)
      to_char(sysdate, 'SS'), -- 25(초)     
      to_char(sysdate, 'AM'), -- 오후
      to_char(sysdate, 'PM'), --오후
--    to_char(sysdate,'FF') --sysdate는 밀리초가 저장되어있지 않기때문에 에러가 발생한다
      to_char(systimestamp,'FF') --483000(밀리초)        
FROM dual;

SELECT systimestamp, sysdate FROM dual;--20/03/24 21:43:34.399000000 +09:00(timestamp) --타임존이 들어간다
                                     --20/03/24(sysdate)
--많이 쓰는형태   

SELECT 
    to_char(sysdate,'YYYY/MM/DD DAY HH24:MI:SS')
FROM dual;

--Q응용
SELECT * FROM emp WHERE to_char(hiredate,'Q')=3; --3분기 반환





