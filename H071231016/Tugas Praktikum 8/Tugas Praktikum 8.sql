USE classicmodels;

#Nomor 1
(SELECT p.productName, SUM(od.priceEach * od.quantityOrdered) AS TotalRevenue, 'Pendapatan Tinggi' AS Pendapatan  
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders os
USING(orderNumber)
WHERE MONTH(orderdate) = 9 
GROUP BY productName
ORDER BY `TotalRevenue` DESC 
LIMIT 5)
UNION
(SELECT p.productName, SUM(od.priceEach * od.quantityOrdered) AS TotalRevenue, 'Pendapatan Pendek (Kayak Kamu)' AS Pendapatan
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders os
USING(orderNumber)
WHERE MONTH(orderdate) = 9
GROUP BY productName
ORDER BY `TotalRevenue` ASC 
LIMIT 5)

#Nomor 2
SELECT productName 
FROM products

EXCEPT 

SELECT productName
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o
USING(orderNumber)
WHERE customerNumber IN (SELECT customerNumber
									FROM orders 
									GROUP BY customerNumber
									HAVING COUNT(orderNumber) > 10)
AND customerNumber IN (SELECT DISTINCT customerNumber
							FROM products p
							JOIN orderdetails od
							USING(productCode)
							WHERE priceEach > (SELECT AVG(priceEach) FROM orderdetails))
#Nomor 3
SELECT customerName FROM customers
JOIN payments
GROUP BY customerName
HAVING SUM(amount) > (SELECT 2*AVG(amount) 
							 FROM payments)

INTERSECT 

SELECT customerName
FROM payments
JOIN customers USING(customerNumber)
JOIN orders USING(customerNumber)
JOIN orderdetails USING(orderNumber)
JOIN products USING(productCode)
WHERE productLine IN ('Plane','Trains')
GROUP BY customerName
HAVING SUM(buyPrice) > 20000;
-- 
SELECT customerName
FROM customers
JOIN payments
USING(customerNumber)
GROUP BY customerNumber
HAVING SUM(amount) > 2 * (
    SELECT AVG(totalAmount)
    FROM (
        SELECT DISTINCT SUM(amount) AS totalAmount
        FROM payments
        GROUP BY customerNumber
    ) AS hasil
)
INTERSECT
SELECT c.customerName
FROM customers AS c
JOIN orders AS o
USING(customerNumber)
JOIN orderdetails AS od 
USING(orderNumber)
JOIN products AS p 
USING(productCode)
WHERE p.productLine IN ('Planes', 'Trains')
GROUP BY c.customerNumber
HAVING SUM(priceEach * quantityOrdered) > 20000;

#Nomor 4
SELECT o.orderDate AS Tanggal, c.customerNumber AS CustomerNumber,
		 'Membayar Pesanan dan Mememsan Barang' AS riwayat
FROM orders o
JOIN customers c 
USING(customerNumber)
JOIN payments p
ON o.orderDate = p.paymentDate
WHERE o.orderDate LIKE '2003-09%'

UNION

SELECT orderDate, customerNumber, 'Memesan Barang'
FROM orders o
WHERE o.orderDate LIKE '2003-09%' AND 
		o.orderDate NOT IN(SELECT p1.paymentDate
								 FROM payments p1)
								 
UNION 

SELECT p.paymentDate, customerNumber,'Membayar Pesanan'
FROM payments p
WHERE p.paymentDate LIKE '2003-09%' AND
		p.paymentDate NOT IN(
		  SELECT o1.orderDate 
		  FROM orders o1)
ORDER BY `Tanggal`;

#Nomor 5
SELECT DISTINCT  p.productCode
FROM products AS p
JOIN orderdetails AS od
USING(productCode)
WHERE priceEach > (
   SELECT AVG(priceEach) FROM orderdetails 
   JOIN orders 
	USING(orderNumber)
   WHERE orderDate BETWEEN '2001-01-01' AND '2004-03-31')
	AND quantityOrdered > 48
	AND LEFT(productVendor, 1) IN ('A', 'I', 'U','E','O')

EXCEPT   

SELECT DISTINCT p.productCode
FROM products AS p
JOIN orderdetails AS od
USING(productCode)
JOIN orders AS o
USING(orderNumber)
JOIN customers AS c
USING(customerNumber)
WHERE c.country IN ('Japan', 'Germany', 'Italy') AND c.country IS NOT NULL; 


