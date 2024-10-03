#1
SELECT 
	productcode AS "Kode Produk",
	productname, quantityinstock
	FROM products
	WHERE quantityinstock >= 5000 AND quantityinstock <= 6000;
	
#2
SELECT 
	ordernumber, orderdate, STATUS, customernumber
	FROM orders
	WHERE STATUS != 'shipped'
	ORDER BY customernumber;

#3
SELECT 
	employeeNumber, firstname,lastname,email,jobtitle
	FROM employees
	ORDER BY firstname ASC
	LIMIT 10;

#4	
SELECT 
	productcode, productname, productline, buyprice
	FROM products
	ORDER BY buyprice DESC  
	LIMIT 5,10 ;

#	
SELECT DISTINCT country, city FROM customers
ORDER BY country, city;

#6
SELECT customername, city, country, salesrepemployeenumber
FROM customers
WHERE salesrepemployeenumber = 1370;

SELECT * FROM employees
WHERE firstname = 'gerard';	
	