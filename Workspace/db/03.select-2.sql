-- madang_db로 작업 데이터베이스 변경
USE madang_db;

-- madang_db의 테이블 목록 보기
SHOW TABLES;

-- madang_db의 각 테이블의 정보 보기
DESC book;
DESC customer;
DESC orders;

-- 1. 모든 도서의 이름과 가격을 검색하시오
SELECT bookname, price
FROM book;

-- 2. 모든 도서의 도서번호,  도서이름, 출판사, 가격을 검색하시오
SELECT bookid, bookname, publisher, price
FROM book;

SELECT *
FROM book;

-- 3. 도서 테이블에 있는 모든 출판사를 검색하시오 ( 중복 데이터 제거 )
SELECT DISTINCT publisher
FROM book;

-- 4. 가격이 20,000원 미만인 도서를 검색하시오
SELECT *
FROM book
WHERE price < 20000;

-- 5. 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오
SELECT *
FROM book
WHERE price >= 10000 AND price <= 20000;

SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;

-- 6. 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색하시오
SELECT *
FROM book
WHERE publisher = '굿스포츠' OR publisher = '대한미디어';

SELECT *
FROM book
WHERE publisher IN ('굿스포츠', '대한미디어');

-- 7. ‘축구의 역사’를 출간한 출판사를 검색하시오.
SELECT publisher
FROM book
WHERE bookname = '축구의 역사';

-- 8. 도서이름에 ‘축구’가 포함된 출판사를 검색하시오

-- 9. 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오

-- 10. 도서를 이름순으로 검색하시오

-- 11. 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.

-- 12. 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 검색한다.
-- madang_db로 작업 데이터베이스 변경
USE madang_db;

-- madang_db의 테이블 목록 보기
SHOW TABLES;

-- madang_db의 각 테이블의 정보 보기
DESC book;
DESC customer;
DESC orders;

-- 1. 모든 도서의 이름과 가격을 검색하시오
SELECT bookname, price
FROM book;

-- 2. 모든 도서의 도서번호,  도서이름, 출판사, 가격을 검색하시오
SELECT bookid, bookname, publisher, price
FROM book;

SELECT *
FROM book;

-- 3. 도서 테이블에 있는 모든 출판사를 검색하시오 ( 중복 데이터 제거 )
SELECT DISTINCT publisher
FROM book;

-- 4. 가격이 20,000원 미만인 도서를 검색하시오
SELECT *
FROM book
WHERE price < 20000;

-- 5. 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오
SELECT *
FROM book
WHERE price >= 10000 AND price <= 20000;

SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;

-- 6. 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색하시오
SELECT *
FROM book
WHERE publisher = '굿스포츠' OR publisher = '대한미디어';

SELECT *
FROM book
WHERE publisher IN ('굿스포츠', '대한미디어');

-- 7. ‘축구의 역사’를 출간한 출판사를 검색하시오.
SELECT publisher
FROM book
WHERE bookname = '축구의 역사';

-- 8. 도서이름에 ‘축구’가 포함된 출판사를 검색하시오
SELECT *
FROM book
WHERE bookname LIKE '%축구%';

-- 9. 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오
SELECT *
FROM book
WHERE bookname LIKE '%축구%' AND price >= 20000;

-- 10. 도서를 이름순으로 검색하시오
SELECT *
FROM book
ORDER BY bookname ASC;

-- 11. 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT *
FROM book
ORDER BY price, bookname;

-- 12. 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 검색한다.
SELECT *
FROM book
ORDER BY price DESC, publisher ASC;
-- 1. 작업 데이터베이스 변경
USE univdb;

-- 2. 전체 학생 정보 조회 - 1
SELECT 학번,이름,주소,학년,나이,성별,휴대폰번호,소속학과 
FROM 학생;

-- 3. 전체 학생 정보 조회 - 2
SELECT * -- * : 모든 컬럼
FROM 학생;

-- 4. 전체 학생의 이름과 주소 조회
SELECT 이름, 주소
FROM 학생;

-- 5. 전체 학생의 소속학과 조회
SELECT 소속학과
FROM 학생;

SELECT DISTINCT 소속학과 -- DISTINCT : 중복 제거
FROM 학생;

-- 6. 2학년 이상, 컴퓨터 학과 학생의 이름, 학년, 소속학과 휴대폰번호 조회
SELECT 이름, 학년, 소속학과, 휴대폰번호
FROM 학생
WHERE 학년 >= 2 AND 소속학과 = '컴퓨터'; -- SQL에서 일치 비교는 = 연산자 사용

-- 7. 1,2,3학년 이거나 컴퓨터 학과가 아닌 학생의 이름, 학년, 소속학과 휴대폰번호 조회
SELECT 이름, 학년, 소속학과, 휴대폰번호
FROM 학생
-- WHERE 학년 < 4 OR 소속학과 != '컴퓨터';
-- WHERE 학년 < 4 OR 소속학과 <> '컴퓨터'; -- <>는 !=와 같은 역할
-- WHERE 학년 < 4 OR NOT (소속학과 = '컴퓨터');
-- WHERE (학년 >= 1 AND 학년 <= 3) OR NOT (소속학과 = '컴퓨터');
-- WHERE (학년 BETWEEN 1 AND 3) OR NOT (소속학과 = '컴퓨터');
WHERE 학년 IN (1, 2, 3) OR NOT (소속학과 = '컴퓨터');

-- 8. 컴퓨터 학과 또는 정보통신 학과 학생의 이름, 학년, 소속학과를 학년 순으로 조회
SELECT 이름, 학년, 소속학과
FROM 학생
WHERE 소속학과 IN ('컴퓨터', '정보통신')
ORDER BY 학년 ASC; -- ASC는 오름차순 정렬 (생략 가능), 내림차순은 DESC

-- 9. 전체 학생의 모든 정보를 학년(오름차순), 이름(내림차순) 순으로 조회
SELECT *
FROM 학생
ORDER BY 학년 ASC, 이름 DESC;

-- 10. '이'씨 성을 가진 학생의 학번과 이름 조회
SELECT 학번, 이름
FROM 학생
WHERE 이름 LIKE '이%';

-- 11. 주소지가 '서울'인 학생의 이름, 주소, 학년을 학년이 높은 순으로 조회
SELECT 이름, 주소, 학년
FROM 학생
WHERE 주소 LIKE '%서울%';

-- 12. 휴대폰번호가 등록되지 않은 학생 조회
SELECT * 
FROM 학생
-- WHERE 휴대폰번호 = NULL; -- NULL은 =연산자로 비교할 수 없음
WHERE 휴대폰번호 IS NULL;

-- 13. 전체 학생 수 조회
SELECT COUNT(학번) AS 학번_기준_학생수
FROM 학생;

SELECT COUNT(나이) 나이_기준_학생수 -- NULL은 COUNT 계산에서 제외
FROM 학생;

SELECT COUNT(*) 학생수
FROM 학생;

SELECT COUNT(주소) 거주지역_갯수, COUNT(DISTINCT 주소) 거주직역_갯수2
FROM 학생;

-- 14. 남학생의 평균 나이 조회
SELECT AVG(나이) 남학생평균나이, MIN(나이) 남학생최저연령, MAX(나이) 남학생최고연령
FROM 학생
WHERE 성별 = '남';

-- 15. 성별 평균연령, 최고연령, 최저연령 조회
SELECT AVG(나이) 평균연령, MIN(나이) 최저연령, MAX(나이) 최고연령
FROM 학생
GROUP BY 성별;



--








-- 1. 작업 데이터베이스 변경
USE univdb;

-- 2. 전체 학생 정보 조회 - 1
SELECT 학번,이름,주소,학년,나이,성별,휴대폰번호,소속학과 
FROM 학생;

-- 3. 전체 학생 정보 조회 - 2
SELECT * -- * : 모든 컬럼
FROM 학생;

-- 4. 전체 학생의 이름과 주소 조회
SELECT 이름, 주소
FROM 학생;

-- 5. 전체 학생의 소속학과 조회
SELECT 소속학과
FROM 학생;

SELECT DISTINCT 소속학과 -- DISTINCT : 중복 제거
FROM 학생;

-- 6. 2학년 이상, 컴퓨터 학과 학생의 이름, 학년, 소속학과 휴대폰번호 조회
SELECT 이름, 학년, 소속학과, 휴대폰번호
FROM 학생
WHERE 학년 >= 2 AND 소속학과 = '컴퓨터'; -- SQL에서 일치 비교는 = 연산자 사용

-- 7. 1,2,3학년 이거나 컴퓨터 학과가 아닌 학생의 이름, 학년, 소속학과 휴대폰번호 조회
SELECT 이름, 학년, 소속학과, 휴대폰번호
FROM 학생
-- WHERE 학년 < 4 OR 소속학과 != '컴퓨터';
-- WHERE 학년 < 4 OR 소속학과 <> '컴퓨터'; -- <>는 !=와 같은 역할
-- WHERE 학년 < 4 OR NOT (소속학과 = '컴퓨터');
-- WHERE (학년 >= 1 AND 학년 <= 3) OR NOT (소속학과 = '컴퓨터');
-- WHERE (학년 BETWEEN 1 AND 3) OR NOT (소속학과 = '컴퓨터');
WHERE 학년 IN (1, 2, 3) OR NOT (소속학과 = '컴퓨터');

-- 8. 컴퓨터 학과 또는 정보통신 학과 학생의 이름, 학년, 소속학과를 학년 순으로 조회
SELECT 이름, 학년, 소속학과
FROM 학생
WHERE 소속학과 IN ('컴퓨터', '정보통신')
ORDER BY 학년 ASC; -- ASC는 오름차순 정렬 (생략 가능), 내림차순은 DESC

-- 9. 전체 학생의 모든 정보를 학년(오름차순), 이름(내림차순) 순으로 조회
SELECT *
FROM 학생
ORDER BY 학년 ASC, 이름 DESC;

-- 10. '이'씨 성을 가진 학생의 학번과 이름 조회
SELECT 학번, 이름
FROM 학생
WHERE 이름 LIKE '이%';

-- 11. 주소지가 '서울'인 학생의 이름, 주소, 학년을 학년이 높은 순으로 조회
SELECT 이름, 주소, 학년
FROM 학생
WHERE 주소 LIKE '%서울%';

-- 12. 휴대폰번호가 등록되지 않은 학생 조회
SELECT * 
FROM 학생
-- WHERE 휴대폰번호 = NULL; -- NULL은 =연산자로 비교할 수 없음
WHERE 휴대폰번호 IS NULL;

-- 13. 전체 학생 수 조회
SELECT COUNT(학번) AS 학번_기준_학생수
FROM 학생;

SELECT COUNT(나이) 나이_기준_학생수 -- NULL은 COUNT 계산에서 제외
FROM 학생;

SELECT COUNT(*) 학생수
FROM 학생;

SELECT COUNT(주소) 거주지역_갯수, COUNT(DISTINCT 주소) 거주직역_갯수2
FROM 학생;

-- 14. 남학생의 평균 나이 조회
SELECT AVG(나이) 남학생평균나이, MIN(나이) 남학생최저연령, MAX(나이) 남학생최고연령
FROM 학생
WHERE 성별 = '남';

-- 15. 성별 평균연령, 최고연령, 최저연령 조회
SELECT AVG(나이) 평균연령, MIN(나이) 최저연령, MAX(나이) 최고연령
FROM 학생
GROUP BY 성별;

SELECT 성별, AVG(나이) 평균연령, MIN(나이) 최저연령, MAX(나이) 최고연령
FROM 학생
GROUP BY 성별;

-- SELECT 이름, 성별, AVG(나이) 평균연령 -- 오류 : GROUP BY에 명시된 컬럼만 조회 가능
-- FROM 학생
-- GROUP BY 성별;

-- 16. 20대 학생만을 대상으로 연령별 학생수 조회
SELECT 나이, COUNT(*) 학생수
FROM 학생
WHERE 나이 BETWEEN 20 AND 29
GROUP BY 나이;


-- 17. 학생 수가 2명 이상인 학년의 학년별 학생 수 조회
SELECT 학년, COUNT(*) 학생수
FROM 학생
-- WHERE COUNT(*) >= 2 -- 오류 : WHERE는 GROUP BY 이전에 실행되지만 집계는 GROUP BY 이후에 실행
GROUP BY 학년
HAVING COUNT(*) >= 2 -- 집계를 조건으로 사용하려면 HAVING 절에 표현
ORDER BY 학년;

-- 18. 전체 학생 조회 ( 여학생 조회 + 남학생 조회 )

SELECT * FROM 학생; -- 전체 학생 조회

SELECT * FROM 학생 WHERE 성별 = '여';  -- 여학생 조회
SELECT * FROM 학생 WHERE 성별 = '남';	-- 남학생 조회

SELECT * FROM 학생 WHERE 성별 = '여'  -- 전체 학생 조회
UNION
SELECT * FROM 학생 WHERE 성별 = '남';

SELECT * FROM 학생 WHERE 성별 = '여'  -- 전체 학생 조회
UNION ALL
SELECT * FROM 학생 WHERE 성별 = '남';

-- 19. 전체 학생 조회 (1 ~ 3학년 조회 + 2 ~ 4학년 조회)

SELECT * FROM 학생 WHERE 학년 BETWEEN 1 AND 3; -- 1 ~ 3학년 조회
SELECT * FROM 학생 WHERE 학년 BETWEEN 2 AND 4; -- 2 ~ 4학년 조회

SELECT * FROM 학생 WHERE 학년 BETWEEN 1 AND 3 -- 전체 학생 조회
UNION -- 중복 자동 제거
SELECT * FROM 학생 WHERE 학년 BETWEEN 2 AND 4;

SELECT * FROM 학생 WHERE 학년 BETWEEN 1 AND 3 -- 전체 학생 조회
UNION ALL -- 중복 포함
SELECT * FROM 학생 WHERE 학년 BETWEEN 2 AND 4;

-- 20. 서로 다른 데이터 병합 (컬럼 갯수와 자료형 일치)
SELECT 이름, 학년 FROM 학생
UNION ALL
SELECT 학번, 나이 FROM 학생;

-- 21. 여학생 또는 A학점 받은 학생 조회
SELECT 학번 FROM 학생 WHERE 성별 = '여'
UNION
SELECT 학번 FROM 수강 WHERE 평가학점 = 'A';




USE madang_db;
SELECT * FROM book;
SELECT * FROM customer;
SELECT * FROM orders;


-- 13. 고객이 주문한 도서의 총 판매액을 구하시오
SELECT SUM(saleprice) AS 총_판매액 FROM orders;  

-- 14. 김연아 고객이 주문한 도서의 총 판매액을 구하시오. ( 2개의 SQL )
SELECT SUM(saleprice) FROM orders 
INNER JOIN customer 
ON customer.custid = orders.custid 
WHERE customer.name = '김연아';

-- 15. 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오
SELECT customer.name AS '고객', SUM(saleprice) AS '총 판매액', AVG(saleprice) AS '평균값', MIN(saleprice) AS '평균값', MAX(saleprice) AS '최고가'
FROM orders
INNER JOIN customer ON customer.custid = orders.custid
GROUP BY customer.custid;
-- 16. 도서 판매 건수를 구하시오.
SELECT COUNT(*) AS '도서 판매 건수' 
FROM orders;

-- 16. 도서별 판매 건수를 구하시오.
SELECT bookid, COUNT(bookid) AS '도서별 판매 건수' 
FROM orders
GROUP BY bookid;

-- 17. 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오
SELECT c.name AS '고객명', COUNT(o.bookid) AS '총 수량', SUM(o.saleprice) AS '총 판매액'
FROM orders o
INNER JOIN customer c ON c.custid = o.custid
GROUP BY c.custid, c.name;


-- 18. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 
--     고객별 주문 도서의 총 수량을 구하시오. 단, 두 권 이상 구매한 고객만 구한다.
SELECT c.name AS '고객명', COUNT(o.bookid) AS '총 수량', SUM(o.saleprice) AS '총 판매액'
FROM orders o
INNER JOIN customer c ON c.custid = o.custid
WHERE o.saleprice >= 8000
GROUP BY c.custid, c.name
HAVING COUNT(o.bookid) >=2;
