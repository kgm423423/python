-- 1. 작업 데이터베이스 선택 (madang_db)
USE madang_db;

-- 2. 가장 비싼 도서의 이름, 가격 조회
SELECT bookname, price FROM book ORDER BY price DESC LIMIT 1;
-- 3. 도서 구매 실적이 있는 고객 조회
SELECT c.name AS '고객', COUNT(c.name) AS '구매 횟수'
FROM customer c
INNER JOIN orders o ON c.custid = o.custid
GROUP BY c.name;
-- 4. 대한미디어에서 출간한 도서를 구매한 고객 정보 조회
SELECT c.*
FROM customer c
INNER JOIN orders o ON c.custid = o.custid
INNER JOIN book b ON o.bookid = b.bookid
WHERE b.publisher = '대한미디어';
                                    
-- 5. 고객별 판매액 조회 (고객 이름도 같이 조회)
SELECT c.name AS '고객', SUM(o.saleprice) AS '판매액'
FROM customer c
INNER JOIN orders o ON c.custid = o.custid
GROUP BY c.name;

-- 6. 출판사별로 출간한 도서의 평균가격보다 비싼 도서 조회
SELECT * FROM book
WHERE price > ( SELECT AVG(b.price)
FROM orders o
INNER JOIN book b ON o.bookid = b.bookid
WHERE book.publisher = b.publisher
GROUP BY b.publisher );


