-- MYSQL 버전 조회
SELECT VERSION();

-- 날짜 시간 조회
SELECT 
	CURRENT_DATE(),
    CURRENT_TIME(),
    CURRENT_TIMESTAMP(),
    NOW();

-- 현재 접속한 사용자 조회
SELECT USER();

-- 데이터베이스 목록 조회
SHOW DATABASES;

-- 직업 데이터베이스 선택
USE univdb;

-- 현재 작업 데이터베이스 조회
SELECT DATABASE();

-- 테이블 목록 조회
SHOW TABLES;

-- 테이블 구조 정보 조회
DESC 학생;
SELECT * FROM 학생;
SELECT * FROM 학생;