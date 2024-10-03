USE classicmodels;

#nomor1
SELECT customerNumber, customerName,country
FROM customers
WHERE (country = 'USA' AND creditLimit >50000 AND creditLimit < 100000)
	OR (country != 'USA' AND creditLimit >= 100000 AND creditLimit <= 200000)
	ORDER BY creditlimit DESC;

#nomor2
SELECT productCode, productName,quantityInStock,buyPrice
FROM products
WHERE (quantityInStock >= 1000 AND quantityInStock <= 2000) 
	AND (buyPrice < 50 OR  buyPrice > 150) AND (productLine != 'vintage');

#nomor3
SELECT productCode, productName, MSRP
FROM products
WHERE (productLine LIKE '%Classic%') AND (buyPrice > 50);

#nomor4
SELECT orderNumber, orderDate, status, customerNumber
FROM orders
WHERE (orderNumber > 10250) 
	AND status NOT IN  ('shipped','Cancelled') 
	AND orderdate BETWEEN '2004-01-01' AND '2005-12-31';

#nomor5
SELECT * FROM orderdetails

SELECT orderNumber, orderLineNumber, 
	productCode,quantityOrdered, priceEach,(quantityOrdered * priceEach * 0.95) AS discountedTotalPrice
	FROM orderdetails
	WHERE (quantityordered > 50 AND priceEach > 100)
	AND productCode NOT LIKE 'S18%'
	ORDER BY discountedTotalPrice DESC;

