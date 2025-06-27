-- madang_db로 작업 데이터베이스 변경
USE madang_db;

-- 1. 고객별 (고객이름 같이 조회) 구매액 합계 ( customer, orders )
SELECT c.name AS '고객이름', SUM(o.saleprice) AS '구매액 합계'
FROM customer c
INNER JOIN orders o
WHERE c.custid = o.custid
GROUP BY c.custid;

SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM book;

-- 2. 고객아이디, 고객이름, 도서명, 주문 정보 ( customer, book, orders )
SELECT c.custid AS '고객아이디', c.name AS '고객이름', b.*
FROM customer c
INNER JOIN orders o
INNER JOIN book b
WHERE c.custid = o.custid AND o.bookid = b.bookid;

-- 3.  박지성 고객이 구매한 도서의 출판사 수 ( customer, orders, book )
SELECT COUNT(b.publisher)
FROM customer c
INNER JOIN orders o
INNER JOIN book b
WHERE c.custid = o.custid AND o.bookid = b.bookid AND c.name = '박지성';

-- 4.  박지성 고객이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이 ( customer, orders, book )

SELECT b.bookname AS '이름', o.saleprice AS '가격', (b.price - o.saleprice) AS 할인
FROM customer c
INNER JOIN orders o
INNER JOIN book b
WHERE c.custid = o.custid AND o.bookid = b.bookid AND c.name = '박지성';

-- 5. 고객의 이름과 고객이 구매한 도서 목록 ( customer, orders, book )
SELECT c.name AS '이름', b.bookname AS '구매한 도서 목록'
FROM customer c
INNER JOIN orders o
INNER JOIN book b
WHERE c.custid = o.custid AND o.bookid = b.bookid
ORDER BY c.name;