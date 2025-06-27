-- 1. 데이터베이스 만들기

-- CREATE DATABASE humanda_db;
CREATE DATABASE IF NOT EXISTS humanda_db;

-- 2. 데이터베이스 제거

-- DROP DATABASE humanda_db;
-- DROP DATABASE IF EXISTS humanda_db;

-- 3. 사용자 만들기 - mysql database의 user table에 저장

CREATE USER humanda_user@127.0.0.1 IDENTIFIED BY 'humanda';
-- CREATE USER humanda_user@localhost IDENTIFIED BY 'humanda';
CREATE USER humanda_user@"%" IDENTIFIED BY 'humanda';

-- 4. 사용자 확인

SELECT user, host FROM mysql.user; -- mysql.user : mysql database의 user table

USE mysql; -- 관리를 위한 데이터베이스
SHOW TABLES;
SELECT user, host FROM user;

USE humanda_db;

DROP TABLE IF EXISTS test_table;

CREATE TABLE IF NOT EXISTS test_table
(	pm_key      INT            NOT NULL,
	nn_name     VARCHAR(10)    NOT NULL,
    n_etc       VARCHAR(100)   NULL,
	PRIMARY KEY (pm_key)		        );
DESC test_table;

INSERT INTO		test_table (pm_key, nn_name, n_etc)
	 VALUES 	(1, 'kgm', '2006-10-20');
INSERT INTO		test_table (pm_key, nn_name, n_etc)
     VALUES     (2, 'gentian', '2022-05-16');
     
SELECT * FROM test_table;


GRANT ALL PRIVILEGES ON human_db.* TO humanda_user@127.0.0.1;
GRANT ALL PRIVILEGES ON human_db.* TO humanda_user@'%';









