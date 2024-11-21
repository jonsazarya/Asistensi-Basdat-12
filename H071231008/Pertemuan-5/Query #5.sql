SELECT DISTINCT
    c.customerName AS 'namaKustomer',
    p.productName AS 'namaProduk',
    pl.textDescription
	FROM customers AS c
	JOIN orders AS o
	ON c.customerNumber = o.customerNumber
	JOIN orderdetails AS od
	ON o.orderNumber = od.orderNumber
	JOIN products AS p
	ON od.productCode = p.productCode
	JOIN productlines AS pl
	ON p.productLine = pl.productLine
	WHERE p.productName LIKE "%Titanic%"
	ORDER BY p.productName ASC;
	
	SELECT
    c.customerName,
    p.productName,
    o.status,
    o.shippedDate
	FROM customers AS c
	JOIN orders AS o
	ON c.customerNumber = o.customerNumber
	JOIN orderdetails AS od
	ON o.orderNumber = od.orderNumber
	JOIN products AS p
	ON od.productCode = p.productCode
	WHERE p.productName LIKE "%Ferrari%" AND
	o.status = "Shipped" AND o.shippedDate BETWEEN  "2003-10-1" AND "2004-9-30"
	ORDER BY shippedDate DESC 
	 
	 SELECT * FROM orders
	
	

SELECT
    s.firstName AS 'Supervisor',
    k.firstName AS 'Karyawan'
	FROM employees AS s
	JOIN employees AS k
	ON s.employeeNumber =k.reportsTo
	WHERE s.firstName = "Gerard"
	
SELECT
    c.customerName,
    p.paymentDate,
    e.firstName AS 'employeeName',
    p.amount
   FROM customers AS c
   JOIN payments AS p
   ON c.customerNumber = p.customerNumber
   JOIN employees AS e
   ON c.salesRepEmployeeNumber = e.employeeNumber
   WHERE p.paymentDate LIKE "%-11-%"
   ORDER BY p.amount desc
   
   SELECT
    c.customerName,
    p.paymentDate,
    e.firstName AS 'employeeName',
    p.amount
   FROM customers AS c
   JOIN payments AS p
   ON c.customerNumber = p.customerNumber
   JOIN employees AS e
   ON c.salesRepEmployeeNumber = e.employeeNumber
   WHERE c.customerName = "Corporate Gift Ideas Co."
   LIMIT 1
   
      SELECT
    c.customerName,
    p.productName
FROM customers AS c
	JOIN orders AS o
	ON c.customerNumber = o.customerNumber
	JOIN orderdetails AS od
	ON o.orderNumber = od.orderNumber
	JOIN products AS p
	ON od.productCode = p.productCode
   WHERE c.customerName = "Corporate Gift Ideas Co."