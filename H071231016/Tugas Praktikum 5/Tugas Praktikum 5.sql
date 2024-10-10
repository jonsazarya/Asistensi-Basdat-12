USE classicmodels;

-- Nomor 1
SELECT DISTINCT customers.customerName AS namaKustomer, products.productName AS namaProduk, products.productDescription AS textDescription
FROM customers
JOIN orders
ON orders.customerNumber = customers.customerNumber
JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN products
ON orderdetails.productCode = products.productCode
WHERE products.productName LIKE '%Titanic%' 

-- Nomor2
SELECT customers.customerName, products.productName, orders.`status`, orders.shippedDate
FROM customers
JOIN orders 
ON customers.customerNumber = orders.customerNumber
JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN products
ON orderdetails.productCode = products.productCode
WHERE products.productName LIKE '%Ferrari%' 
	AND `status` = 'Shipped'
	AND shippedDate >= '2003-10-01' AND shippedDate < '2004-10-01'
ORDER BY shippedDate DESC;

-- Nomor 3
SELECT e.firstName AS Supervisor, e1.firstName AS Karyawan
FROM employees AS e
JOIN employees AS e1
ON e.employeeNumber = e1.reportsTo
WHERE e.firstName LIKE '%Gerard%'
ORDER BY e1.firstName ASC;

-- Nomor 4a
SELECT c.customerName, p.paymentDate, e.firstName AS employeeName, p.amount
FROM customers AS c
JOIN payments AS p
ON c.customerNumber = p.customerNumber
JOIN  employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE paymentDate LIKE "%-11-%";

-- Nomor 4b
SELECT c.customerName, p.paymentDate, e.firstName AS employeeName, p.amount
FROM customers AS c
JOIN payments AS p
ON c.customerNumber = p.customerNumber
JOIN  employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE paymentDate LIKE "%-11-%"
ORDER BY p.amount DESC
LIMIT 1;

-- Nomor 4c
SELECT c.customerName, p.productName
FROM customers AS c
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN payments AS pay
ON c.customerNumber = pay.customerNumber
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
JOIN products AS p
ON od.productCode = p.productCode
WHERE (c.customerName LIKE 'Corporate Gift%') AND (pay.paymentDate LIKE '%-11-%');