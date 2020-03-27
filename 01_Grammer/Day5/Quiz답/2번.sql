--1. 2012년 1월 3일 내원환자 중 
-- 정형외과(코드:05xx)와 성형외과(코드:08xx)와 이비인후과(코드:13xx)
-- 환자조회
SELECT P.* FROM
    TREAT T, DOCTOR D, DEPARTMENT M, PATIENT P
WHERE T.doc_code = D.doc_code
    AND D.dep_code = M.dep_code
    AND T.pat_code = P.pat_code
    AND T.trt_year = '2012'
    AND t.trt_date = '0103'
    AND SUBSTR(D.DEP_CODE, 0, 2) IN (05, 08, 13)
ORDER BY P.PAT_CODE;


--2. 2012년 1월 3일 내원환자 중 내원시간이 09:00 ~ 12:00 이고
-- 진료과가 정형외과(코드:05xx)와 성형외과(코드:08xx)와 이비인후과(코드:13xx)
-- 가 아닌 환자조회
-- NOT IN
SELECT P.* FROM
    TREAT T, DOCTOR D, DEPARTMENT M, PATIENT P
WHERE T.doc_code = D.doc_code
    AND D.dep_code = M.dep_code
    AND T.pat_code = P.pat_code
    AND T.trt_year = '2012'
    AND T.trt_date = '0103'
    AND T.trt_time BETWEEN '0900' AND '1200'
    AND SUBSTR(D.DEP_CODE, 0, 2) NOT IN (05, 08, 13)
ORDER BY P.PAT_CODE;


--3. 2014년 1월 1일 내원환자 중 5명만 출력
-- (진료시간순서 상 마지막 진료환자 5명)
-- ROWNUM
SELECT P.* FROM (
    SELECT ROWNUM rnum, TRT.*
    FROM ( 
        SELECT *
        FROM TREAT
        WHERE trt_year = '2014'
            AND trt_date = '0101'
        ORDER BY trt_time DESC
    ) TRT
) R, PATIENT P
WHERE R.pat_code = P.pat_code
    AND rnum BETWEEN 1 AND 5
ORDER BY P.pat_code;
