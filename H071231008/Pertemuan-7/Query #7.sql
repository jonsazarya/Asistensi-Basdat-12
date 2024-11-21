#queri 1
SELECT
	productCode,
 	productName,
 	buyPrice
	  FROM products
	WHERE buyPrice > (select avg(buyprice) FROM products)
	
	
	
#queri 2
SELECT o.orderNumber, o.orderDate
	FROM orders o
	JOIN customers c
	USING (customerNumber)
	WHERE c.salesRepEmployeeNumber IN (
		SELECT 
		e.employeeNumber
		FROM employees e
		JOIN offices o
		USING(officeCode)
		WHERE city = "Tokyo"
		)
	
#queri 3
SELECT 
	c.customerName,
	o.orderNumber, o.shippedDate, o.requiredDate,
	GROUP_CONCAT(p.productName) AS 'products',
	SUM(od.quantityOrdered) AS 'total_quantity_ordered',
	CONCAT(e.firstName, ' ', e.lastName) AS 'employeeName'
FROM customers AS c
JOIN orders AS o
	USING(customerNumber)
JOIN orderdetails AS od
	USING(orderNumber)
JOIN products AS p
	USING(productCode)
JOIN employees AS e
	ON c.salesRepEmployeeNumber = e.employeeNumber
	WHERE o.orderNumber IN (
		SELECT o2.orderNumber
		FROM orders AS o2
		WHERE o2.requiredDate < o2.shippedDate
)

#queri 4
SELECT 
	p.productName,
	p.productLine,
	sum(od.quantityOrdered) AS "Total_Ordered"
	FROM products p
	JOIN orderdetails od
		USING(productCode)
	WHERE p.productLine IN (
		SELECT productLine
			FROM (
				SELECT productLine
				FROM products
				JOIN orderdetails
					USING (productCode)
				GROUP BY productLine
				ORDER BY SUM(quantityOrdered) DESC
				LIMIT 3
			) AS top_product
	)
	GROUP BY p.productName
	ORDER BY p.productLine, Total_Ordered DESC ;
	
	
