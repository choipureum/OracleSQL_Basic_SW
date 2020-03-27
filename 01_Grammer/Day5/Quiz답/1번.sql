--1. 성별이 남자인 오씨성을 가진 환자 조회
SELECT * FROM PATIENT
WHERE substr(PAT_NAME, 0, 1) = '오'
    AND PAT_GENDER='M';


--2. 성별이 남자인 오씨성을 가진 환자중 1979년생이 아닌 조회
SELECT * FROM PATIENT
WHERE PAT_GENDER = 'M'
    AND substr(PAT_NAME, 0, 1) = '오'
    AND substr(PAT_BIRTH, 0, 4) != 1979;


--3. 생년월일이 1980년생 부터 1989년생 까지 환자 중 여자만 조회
SELECT * FROM PATIENT
WHERE PAT_GENDER = 'F'
    AND PAT_BIRTH BETWEEN 19800101 AND 19891231;


--4. 환자이름이 4자이며 '오성'으로 끝나는 환자 중 생년월일이 2004년생 남자 환자만 조회
SELECT * FROM PATIENT
WHERE SUBSTR(PAT_NAME, -2, 2) = '오성'
AND SUBSTR(PAT_BIRTH, 0, 4) = 2004
AND PAT_GENDER='M'
AND LENGTH(PAT_NAME) = 4;


--5. 2000년생 여자 중 이름 뒤 두글자가 '환자'로 끝나지 않는 환자조회
SELECT * FROM PATIENT
WHERE SUBSTR(PAT_NAME, -2, 2) != '환자'
AND SUBSTR(PAT_BIRTH, 0, 4) = 2000
AND PAT_GENDER='F';


--6. 환자이름이 4자인사람 중에 휴대폰 번호가 등록되어있지 않은 환자조회
SELECT * FROM PATIENT
WHERE pat_tel IS NULL
    AND length(PAT_NAME) = 4;
