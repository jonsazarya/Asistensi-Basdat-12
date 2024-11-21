USE classicmodels;

#nomor1
SELECT productCode, 
		 productName, 
		 buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products)

#nomor2
SELECT o.orderNumber, o.orderdate
FROM orders o
JOIN customers c
USING (customerNumber)
JOIN employees e
ON employeeNumber = salesRepEmployeeNumber
WHERE e.officeCode = (SELECT officeCode 
FROM offices 
WHERE city = 'Tokyo')

#nomor3
SELECT c.customerName, 
		 od.orderNumber,
		 o.shippedDate, 
		 o.requiredDate,
		 GROUP_CONCAT(p.productName) AS 'products',
		 SUM(od.quantityOrdered) AS total_quantity_ordered,
		 CONCAT(e.firstName,' ',e.lastName) AS employeeName
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
JOIN employees e
ON employeeNumber = salesRepEmployeeNumber
WHERE o.orderNumber = (SELECT orderNumber #pakai ini krn unik 
FROM orders
WHERE shippedDate > requiredDate)

#nomor4
SELECT p.productName, 
		 p.productLine, 
		 SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od
USING (productCode)
WHERE p.productLine IN (SELECT top.productLine
FROM (SELECT productLine FROM products p1
JOIN orderdetails od1
USING(productCode)
GROUP BY p1.productLine
ORDER BY SUM(od1.quantityOrdered) DESC 
LIMIT 3) AS top)
GROUP BY p.productName ,p.productLine
ORDER BY p.productLine, `total_quantity_ordered` DESC 



SELECT CONCAT(e.lastName, ' ', e.firstName) AS Karyawan,
		 SUM(p.amount) AS Pendapatan
FROM employees e
JOIN customers c
ON employeeNumber = salesRepEmployeeNumber
JOIN payments p
USING(customerNumber) 
WHERE e.employeeNumber IN ((
		 SELECT e1.employeeNumber
		 FROM employees e1  
		 JOIN customers c1
		 ON employeeNumber = salesRepEmployeeNumber
		 JOIN payments p1
		 USING(customerNumber)  
		 GROUP BY employeeNumber
		 ORDER BY SUM(p1.amount) DESC 
		 LIMIT 1),
		 (SELECT e1.employeeNumber
		 FROM employees e1  
		 JOIN customers c1
		 ON employeeNumber = salesRepEmployeeNumber
		 JOIN payments p1
		 USING(customerNumber)  
		 GROUP BY employeeNumber
		 ORDER BY SUM(p1.amount) ASC  
		 LIMIT 1)) 
GROUP BY e.employeeNumber
 

