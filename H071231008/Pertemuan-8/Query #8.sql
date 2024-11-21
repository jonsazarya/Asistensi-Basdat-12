#no1
(SELECT 
		productName,
		SUM(priceEach * quantityOrdered) AS TotalRevenue,
		'Pendapatan Tinggi' AS 'Pendapatan'
FROM products
JOIN orderdetails
USING(productCode)
JOIN orders
USING(orderNumber)
WHERE MONTH(orderDate) = 9
GROUP BY productName
ORDER BY TotalRevenue DESC
LIMIT 5)

UNION

(SELECT 
		productName,
		SUM(priceEach * quantityOrdered) AS TotalRevenue,
		'Pendapatan Pendek (kayak kamu)' AS 'Pendapatan'
FROM products
JOIN orderdetails
USING(productCode)
JOIN orders
USING(orderNumber)
WHERE MONTH(orderDate) = 9
GROUP BY productName
ORDER BY TotalRevenue ASC
LIMIT 5);

#no 2
SELECT productName FROM products
	EXCEPT
		SELECT p.productName
			FROM products p
			JOIN orderdetails od
			USING (productCode)
			JOIN orders o
			USING (orderNumber)
			JOIN customers c
			USING (customerNumber)
		WHERE c.customerNumber IN (
		SELECT 
		customerNumber
			FROM customers
			JOIN orders
			USING (customerNumber)
			JOIN orderdetails
			USING (orderNumber)
			WHERE priceEach > (SELECT AVG(buyPrice) FROM orderdetails)
			GROUP BY customerNumber
			HAVING COUNT(DISTINCT orderNumber) > 10);
		
#no 3
SELECT customerName
FROM customers
    JOIN payments USING (customerNumber)
GROUP BY customerName
HAVING SUM(amount) > 2 * (
    SELECT  AVG(total_amount) 
    FROM (
        SELECT DISTINCT  SUM(amount) AS total_amount 
        FROM payments 
        GROUP BY customerNumber
    ) AS avgtotal
)
	INTERSECT 
SELECT customerName
FROM customers
    JOIN orders USING (customerNumber)
    JOIN orderdetails USING (orderNumber)
    JOIN products USING (productCode)
WHERE productLine IN ('Planes','Trains')
GROUP BY customerName
HAVING SUM(priceEach * quantityOrdered ) > 20000
;

-- Query 4
SELECT 
    o.orderDate AS 'Tanggal',
    c.customerNumber AS 'CustomerNumber',
    'Membayar Pesanan dan Memesan Barang' AS 'riwayat'
FROM orders AS o
JOIN customers AS c 
    USING (customerNumber)
JOIN payments AS p 
    ON o.orderDate = p.paymentDate
    
HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003

UNION

SELECT 
    orderDate, 
    customerNumber,
    'Memesan Barang' 
FROM orders
WHERE MONTH(orderDate) = 09 AND YEAR(orderDate) = 2003

AND orderDate NOT IN (  
	SELECT o.orderDate AS 'Tanggal'
	FROM orders AS o
	JOIN customers AS c 
        USING (customerNumber)
	JOIN payments AS p 
        ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)	

UNION
SELECT 
    paymentDate, 
    customerNumber, 
    'Membayar Pesanan' FROM payments
WHERE MONTH(paymentDate) = 09 AND YEAR(paymentDate) = 2003

AND paymentDate NOT IN (  
	SELECT p.paymentDate AS 'Tanggal'
	FROM orders AS o
	JOIN customers AS c 
        USING (customerNumber)
	JOIN payments p 
        ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)
ORDER BY Tanggal;
 