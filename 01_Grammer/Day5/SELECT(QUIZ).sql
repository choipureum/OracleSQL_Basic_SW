--문제 1

--1. 성별이 남자인 오씨성을 가진 환자 조회
SELECT PAT_CODE, PAT_NAME  FROM PATIENT WHERE PAT_NAME LIKE '오%';

--2. 성별이 남자인 오씨성을 가진 환자중 1979년생이 아닌 조회
SELECT PAT_CODE,PAT_NAME  FROM PATIENT WHERE PAT_NAME LIKE '오%' AND PAT_GENDER ='M' AND NOT(PAT_BIRTH LIKE '1979%');

--3. 생년월일이 1980년생 부터 1989년생 까지 환자 중 여자만 조회
SELECT PAT_CODE,PAT_NAME FROM PATIENT WHERE PAT_BIRTH LIKE '198%' AND PAT_GENDER ='F'; 

--4. 환자이름이 4자이며 '오성'으로 끝나는 환자 중 생년월일이 2004년생 남자 환자만 조회
SELECT PAT_CODE,PAT_NAME FROM PATIENT WHERE PAT_NAME LIKE '__오성' AND PAT_BIRTH LIKE '2004%';

--5. 2000년생 여자 중 이름 뒤 두글자가 '환자'로 끝나지 않는 환자조회
SELECT PAT_CODE,PAT_NAME FROM PATIENT WHERE PAT_BIRTH LIKE '2000%' AND NOT(PAT_NAME LIKE '%환자') AND PAT_GENDER ='F';

--6. 환자이름이 4자인사람 중에 휴대폰 번호가 등록되어있지 않은 환자조회 
SELECT PAT_CODE,PAT_NAME FROM PATIENT WHERE PAT_NAME LIKE '____' AND PAT_TEL IS NULL;


--문제 2

--1. 2012년 1월 3일 내원환자 중 
-- 정형외과(코드:05xx)와 성형외과(코드:08xx)와 이비인후과(코드:13xx)
-- 환자조회

SELECT PAT_CODE,PAT_NAME FROM PATIENT WHERE PAT_CODE IN(
SELECT  PAT_CODE FROM TREAT T WHERE (TRT_YEAR=2012 AND TRT_DATE=0103) 
    AND DOC_CODE IN (SELECT DOC_CODE FROM DOCTOR WHERE DEP_CODE LIKE '05%' OR DEP_CODE LIKE '08%' OR DEP_CODE LIKE '13%')) ORDER BY PAT_CODE;

--2. 2012년 1월 3일 내원환자 중 내원 진료시간이 09:00 ~ 12:00 이고
-- 진료과가 정형외과(코드:05xx)와 성형외과(코드:08xx)와 이비인후과(코드:13xx)
-- 가 아닌 환자조회

SELECT PAT_CODE,PAT_NAME FROM PATIENT WHERE PAT_CODE IN(
SELECT  PAT_CODE FROM TREAT T WHERE (TRT_YEAR=2012 AND TRT_DATE=0103) 
    AND (TRT_TIME BETWEEN '0900' AND '1200') AND DOC_CODE NOT IN(
    SELECT DOC_CODE FROM DOCTOR WHERE DEP_CODE LIKE '05%' OR DEP_CODE LIKE '08%' OR DEP_CODE LIKE '13%')) ORDER BY PAT_CODE;
    
   

--3. 2014년 1월 1일 내원환자 중 5명만 출력
-- (진료시간순서 상 마지막 진료환자 5명)
SELECT P.PAT_CODE, PAT_NAME FROM PATIENT P,(
    SELECT rownum rank, PAT_CODE FROM (
        SELECT PAT_CODE FROM TREAT T WHERE TRT_YEAR=2014 AND TRT_DATE =0101 ORDER BY TRT_TIME DESC
            )E
        )R
        WHERE P.PAT_CODE=R.PAT_CODE AND rank<=5 ORDER BY P.PAT_CODE;
        

--문제 3
--1. 2013년 1월 25일 내원한 환자중 다음의 정보조회
-- 진료과명, 진료의사명, 접수시간, 환자번호, 환자이름, 생년월일, 성별
--(진료과, 진료의, 접수시간으로 내림차순 정렬)

--조인 순서가 중요하다!!!! 잘못되면 안됨
SELECT dep.dep_name,doc.doc_name, tre.trt_time , pat.pat_name,
        pat.pat_birth,pat.pat_gender
FROM DEPARTMENT dep
INNER JOIN DOCTOR doc ON dep.dep_code=doc.dep_code
INNER JOIN TREAT tre ON tre.doc_code=doc.doc_code
INNER JOIN PATIENT pat ON pat.PAT_code=tre.pat_code
WHERE tre.trt_year=2013 and tre.trt_date=0125
ORDER BY dep.dep_name,doc.doc_name,tre.TRT_time;


--2. 2013년 12월 25일 내원한 환자의 다음 정보조회
--내원일자, 환자번호, 환자이름, 생년월일, 성별
--*단 2014년 이후로 입원했던적이 있다면 입원일자, 입원시간도 출력
--(진료시간 기준 정렬)
-- OUTER JOIN (+)

SELECT tre.TRT_date,pat.pat_code, pat.pat_name,pat.pat_birth,pat.pat_gender,
inp.inp_date,inp.inp_time
FROM TREAT tre
INNER JOIN PATIENT pat ON tre.pat_code=pat.pat_code
LEFT OUTER JOIN INPATIENT inp ON inp.pat_code=pat.pat_code
WHERE tre.trt_year=2013 and tre.trt_date=1225
ORDER BY tre.TRT_time;


--문제 4
--1. 2014년 1월 2일 내원환자 전체 정보조회
--   환자번호, 환자이름, 생년월일, 성별, 진료의사명, 진료과명
-- 스칼라 서브쿼리로 표현
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

    
--2.2014년 1월 2일 내원환자 중 부서테이블을 WHERE 절 SubQuery를 
--사용하여 조회
--   환자번호, 환자이름, 생년월일, 성별, 진료의사명, 진료과명

-- 단 외과계열 환자만조회('02xx')
-- where절 subquery
    
--강사님코드(시간없어서 못품)
SELECT
    T.pat_code
    , ( SELECT pat_name FROM PATIENT P WHERE T.pat_code=P.pat_code ) pat_name
    , ( SELECT pat_birth FROM PATIENT P WHERE T.pat_code=P.pat_code ) pat_birth
    , ( SELECT pat_gender FROM PATIENT P WHERE T.pat_code=P.pat_code ) pat_gender
    , ( SELECT DOC_NAME FROM DOCTOR D WHERE D.doc_code = T.doc_code ) DOC_NAME
    , ( SELECT DEP_NAME FROM DEPARTMENT M, DOCTOR D WHERE D.doc_code = T.doc_code AND M.DEP_CODE=D.DEP_CODE ) DEP_NAME
FROM TREAT T
WHERE 1=1
    AND trt_year='2014'
    AND trt_date='0102'
    AND SUBSTR((
        SELECT M.DEP_code
        FROM DEPARTMENT M, DOCTOR D
        WHERE D.doc_code = T.doc_code
            AND M.DEP_CODE=D.DEP_CODE
    ),0,2) = '02'
ORDER BY PAT_CODE;
                     
        


