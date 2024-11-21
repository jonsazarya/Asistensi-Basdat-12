USE classicmodels;

#nomor1
SELECT customers.customerName, 
       CONCAT(employees.firstName, ' ', employees.lastName) AS salesRep, 
       (customers.creditLimit - SUM(payments.amount)) AS remainingCredit
FROM customers
JOIN employees 
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN payments 
USING (customerNumber)
GROUP BY customers.customerName
HAVING remainingCredit >= 0
ORDER BY customers.customerName;

#nomor 2
SELECT p.productName AS "Nama Produk",
		 GROUP_CONCAT(c.customerName ORDER BY c.customerName SEPARATOR ';') AS "Nama Customer",
		 COUNT(DISTINCT c.customerNumber) AS "Jumlah Customer",
		 SUM(od.quantityOrdered) AS "Total Quantitas"
FROM products AS p
JOIN orderdetails AS od
USING (productCode)
JOIN orders AS o
USING (orderNumber)
JOIN customers AS c
USING(customerNumber)
GROUP BY p.productName
ORDER BY p.productName;


#nomor 3
SELECT CONCAT(e.firstName, ' ', e.lastName) AS employeeName, 
		 COUNT(c.customerName) AS totalCustomers
FROM employees AS e
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY employeeName
ORDER BY totalCustomers DESC;

#nomor 4 belum jadiii(row = )
SELECT CONCAT(e.firstName, ' ', e.lastName) AS "Nama Karyawan",
		 p.productName  AS "Nama Produk",
		 SUM(od.quantityOrdered) AS "Jumlah Pesanan"
FROM products AS p
JOIN orderdetails AS od
USING (productCode)
JOIN orders AS o
USING (orderNumber)
JOIN customers AS c
USING (customerNumber)
RIGHT JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS ofs
USING (officeCode)
WHERE ofs.country = 'Australia'
GROUP BY e.employeeNumber, p.productName
ORDER BY `Jumlah Pesanan` DESC;

#nomor 5
SELECT c.customerName AS "Nama Pelanggan",
		 GROUP_CONCAT(DISTINCT p.productName ORDER BY p.productName SEPARATOR ';') AS "Nama Produk",
		 COUNT(pd.productLine) AS "Banyak Jenis Produk"
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
JOIN productLines AS pd
USING (productLine)
WHERE o.shippeddate IS NULL 
GROUP BY c.customerName;