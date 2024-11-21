#soal1
SELECT 
	c.customerName,
	CONCAT(e.firstName, " ", e.lastName) AS 'salesRep',
	(c.creditLimit - SUM(p.amount)) AS 'remainingCredit'
FROM customers c
JOIN employees e
	ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p
	USING(customerNumber)
GROUP BY c.customerName
HAVING remainingCredit > 0;

#soal 2
SELECT 
	p.productName,
	GROUP_CONCAT(DISTINCT c.customerName) AS "namaKaryawan",
	COUNT(DISTINCT c.customerNumber) AS "Jumlah Produk",
	SUM(od.quantityOrdered) AS "Total Quantitas"
FROM products p
JOIN orderdetails od
	USING(productCode)
JOIN orders o
	USING(orderNumber)
JOIN customers c
	USING(customerNumber)
GROUP BY p.productName;
	

#soal 3
SELECT 
	CONCAT(e.firstName, " ", e.lastName) AS 'salesRep',
	COUNT(DISTINCT c.customerNumber) AS "totalCustomers" 
FROM employees e
JOIN customers c
	ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY salesRep
ORDER BY totalCustomers DESC

#soal 4
SELECT 
	CONCAT(e.firstName, " ", e.lastName) AS 'Nama Karyawan',
	p.productName AS "Nama Produk",
	SUM(od.quantityOrdered) AS "jumlahPesanan"
FROM products p
JOIN orderdetails od
	USING(productCode)
JOIN orders o
	USING(orderNumber)
JOIN customers c
	USING(customerNumber)
RIGHT JOIN employees e
	ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices ofs
	USING(officeCode)
WHERE ofs.country = "AUSTRALIA"
GROUP BY p.productName,e.employeeNumber 
ORDER BY jumlahPesanan DESC

#soal 5
SELECT 
	c.customerName AS "Nama Pelanggan",
	GROUP_CONCAT(p.productName ORDER BY p.productName) AS "Nama produk",
	COUNT(DISTINCT p.productName)  AS "Banyak Jenis Produk"
FROM customers c
JOIN orders o
	USING(customerNumber)
JOIN orderdetails od
	USING(orderNumber)
JOIN products p
	USING(productCode)
WHERE o.shippedDate IS NULL
GROUP BY c.customerName

