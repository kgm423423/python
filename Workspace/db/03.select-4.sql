-- 작업데이터베이스 변경
USE univdb;

SELECT * FROM 학생;
SELECT * FROM 수강;

SELECT * FROM 학생
CROSS JOIN 수강;

SELECT * 
FROM 학생, 수강
WHERE 학생.학번 = 수강.학번;


-- 2 학번, 학생이름, 수강과목번호 조회
SELECT 학생.*, 수강.*
FROM 학생, 수강
WHERE 학생.학번 = 수강.학번 AND 수강.과목번호 = 'c002';

SELECT 학생.*, 수강.*, 과목.*
FROM 학생, 수강, 과목
WHERE 학생.학번 = 수강.학번 AND 수강.과목번호 = 과목.과목번호;

SELECT 학생.*, 수강.*, 과목.*
FROM 학생
INNER JOIN 수강 ON 학생.학번 = 수강.학번
INNER JOIN 과목 ON 수강.과목번호 = 과목.과목번호;


-- 4. 수강 이력이 없는 학생을 포함해서 모든 학생의 수강 정보를 조회
SELECT 학생.*, 수강.*, 과목.*
FROM 학생
LEFT OUTER JOIN 수강 ON 학생.학번 = 수강.학번
LEFT OUTER JOIN 과목 ON 수강.과목번호 = 과목.과목번호;


SELECT * FROM 수강;