-- Query 1
SELECT * FROM customers;
SELECT customerNumber, customerName, country
FROM customers
WHERE (country = "USA") AND (creditLimit > 50 AND creditLimit < 100000 ) OR
(country != "USA" and creditLimit BETWEEN 100000 AND 200000) ORDER BY creditLimit DESC 


-- Query 2
SELECT * FROM products;
SELECT productCode, productName, quantityInStock, buyPrice
FROM products
WHERE (quantityInStock BETWEEN 1000 AND 2000) AND (buyPrice >150 OR buyPrice < 50) AND (productLine NOT LIKE "%Vintage%")


-- Query 3
SELECT productCode, productName, MSRP
FROM products
WHERE buyPrice > 50 AND productLine LIKE "%Classic%"


-- Query 4
SELECT * FROM orders;
SELECT orderNumber, orderDate, STATUS, customerNumber
FROM orders
WHERE (orderNumber > 10250) AND 
(status NOT IN ("Shipped","Cancelled")) AND 
orderDate BETWEEN "2004-01-01"  AND "2005-12-31"

-- Query 5
SELECT orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach, (priceEach * quantityOrdered * (5/100)) AS "discountTotalPrice"
FROM orderdetails
WHERE (quantityOrdered > 50 AND priceEach > 100) AND (productCode NOT LIKE "S18%") ORDER BY discountTotalPrice DESC 
