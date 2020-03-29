SELECT R.lv, NVL(E.cnt,0) 
    FROM
        (SELECT TO_CHAR(DATETIME,'HH24') as HOUR ,COUNT(*) cnt 
            FROM ANIMAL_OUTS GROUP BY TO_CHAR(DATETIME,'HH24')
                ORDER BY HOUR)E, 
        (SELECT (LEVEL-1)lv FROM dual CONNECT BY LEVEL <=24)R
WHERE R.lv = E.HOUR(+) ORDER BY R.lv
