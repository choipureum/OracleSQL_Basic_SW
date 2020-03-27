--1. 2013년 1월 25일 내원한 환자중 다음의 정보조회
-- 진료과명, 진료의사명, 접수시간, 환자번호, 환자이름, 생년월일, 성별
--(진료과, 진료의, 접수시간으로 내림차순 정렬)
SELECT M.dep_name, D.doc_name, T.trt_receipt, P.pat_code, P.pat_name, P.pat_birth, P.pat_gender
FROM PATIENT P, TREAT T, DOCTOR D, DEPARTMENT M
WHERE T.pat_code = P.pat_code
    AND T.doc_code = d.doc_code
    AND D.dep_code = M.dep_code
    AND T.trt_year = '2013'
    AND T.trt_date = '0125'
ORDER BY M.dep_name, D.doc_name, T.trt_receipt;


-- 3. ANSI 코드로
SELECT M.dep_name, D.doc_name, T.trt_receipt, P.pat_code, P.pat_name, P.pat_birth, P.pat_gender
FROM PATIENT P
INNER JOIN TREAT T
    ON T.pat_code = P.pat_code
INNER JOIN DOCTOR D
    ON T.doc_code = d.doc_code
INNER JOIN DEPARTMENT M
    ON D.dep_code = M.dep_code
WHERE T.trt_year = '2013'
    AND T.trt_date = '0125'
ORDER BY M.dep_name, D.doc_name, T.trt_receipt;




--2. 2013년 12월 25일 내원한 환자의 다음 정보조회
--내원일자, 환자번호, 환자이름, 생년월일, 성별
--*단 2014년 이후로 입원했던적이 있다면 입원일자, 입원시간도 출력
-- OUTER JOIN (+)

-- 잘못된 경우 : 진료 날짜가 제대로 적용되지 않음
SELECT
    T.trt_year --진료년도
    , T.trt_date --진료일자
    , T.trt_time --진료일자
    , T.pat_code --환자번호
    , P.pat_name --환자이름
    , P.pat_birth --생년월일
    , P.pat_gender --성별
    , I.inp_year --입원년도
    , I.inp_date --입원일자
    , I.inp_time --입원시간
FROM PATIENT P, TREAT T, INPATIENT I
WHERE 1=1
    AND P.pat_code = T.pat_code
    AND T.pat_code = I.pat_code(+)
    AND T.trt_year = '2013'
    AND T.trt_date = '1225'
    AND I.inp_year >= '2014';


-- 정답
SELECT
--    T.trt_year --진료년도
    T.trt_date --진료일자
--    , T.trt_time --진료시간
    , T.pat_code --환자번호
    , P.pat_name --환자이름
    , P.pat_birth --생년월일
    , P.pat_gender --성별
    , I.inp_year --입원년도
    , I.inp_date --입원일자
    , I.inp_time --입원시간
FROM PATIENT P, TREAT T, (
    SELECT * FROM INPATIENT
    WHERE inp_year >= 2014
) I
WHERE 1=1
    AND P.pat_code = T.pat_code
    AND T.pat_code = I.pat_code(+)
    AND T.trt_year = '2013'
    AND T.trt_date = '1225'
ORDER BY trt_time;



-- 4. ANSI 코드로
SELECT
--    T.trt_year --진료년도
    T.trt_date --진료일자
--    , T.trt_time --진료시간
    , T.pat_code --환자번호
    , P.pat_name --환자이름
    , P.pat_birth --생년월일
    , P.pat_gender --성별
    , I.inp_year --입원년도
    , I.inp_date --입원일자
    , I.inp_time --입원시간
FROM PATIENT P
INNER JOIN TREAT T
    ON P.pat_code = T.pat_code
LEFT OUTER JOIN (
    SELECT * FROM INPATIENT
    WHERE inp_year >= 2014
) I
    ON T.pat_code = I.pat_code
WHERE 1=1
    AND T.trt_year = '2013'
    AND T.trt_date = '1225'
ORDER BY trt_time;
