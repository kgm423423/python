-- madang_db로 작업 데이터베이스 변경
USE madang_db;

SELECT * FROM book;
SELECT * FROM customer;

-- (1) 도서번호가 1인 도서의 이름 ( book )
SELECT bookname 
FROM book
WHERE bookid = 1;

-- (2) 가격이 20,000원 이상인 도서의 이름 ( book )
SELECT bookname 
FROM book
WHERE price >= 20000;

SELECT * FROM orders;
-- (3) 박지성 고객의 총 구매액(박지성 고객의 고객번호는 1번으로 놓고 작성) ( orders )
SELECT SUM(o.saleprice) AS '총 구매액'
FROM orders o
INNER JOIN customer c ON o.custid = c.custid
WHERE c.name = '박지성';

-- (4) 박지성 고객이 구매한 도서의 수(박지성 고객의 고객번호는 1번으로 놓고 작성) ( orders )
SELECT COUNT(*) AS '구매 도서 수'
FROM orders o
INNER JOIN customer c ON o.custid = c.custid
WHERE c.name = '박지성';

-- (5) 도서의 총 개수 ( book )
SELECT COUNT(bookid) AS '도서의 총 개수'
FROM book;

-- (6) 도서를 출고하는 출판사의 총 개수 ( book )
SELECT COUNT(publisher) AS '출판사 총 개수'
FROM book;

-- (7) 모든 고객의 이름, 주소 ( customer )
SELECT name, address
FROM customer;

-- (8) 2014년 7월 4일 ~ 7월 7일 사이에 주문 받은 도서의 주문번호 ( orders )
SELECT bookid 
FROM orders
WHERE orderdate BETWEEN '2014-07-04' AND '2014-07-07';

-- (9) 2014년 7월 4일~7월 7일 사이에 주문 받은 도서를 제외한 도서의 주문번호 ( orders )
SELECT bookid 
FROM orders
WHERE NOT orderdate BETWEEN '2014-07-04' AND '2014-07-07';

-- (10) 성이 ‘김’ 씨인 고객의 이름과 주소 ( customer )
SELECT name, address 
FROM customer
Where name LIKE '김%';

-- (11) 성이 ‘김’ 씨이고 이름이 ‘아’로 끝나는 고객의 이름과 주소 ( customer )
SELECT name, address 
FROM customer
Where name LIKE '김%아';