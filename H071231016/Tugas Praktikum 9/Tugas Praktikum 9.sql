-- Athifah Nur Rahman MD.
-- H071231016
-- nomor 1
CREATE DATABASE dbsepakbola

USE dbsepakbola

CREATE TABLE club(
		id INT PRIMARY KEY AUTO_INCREMENT, 
		nama_klub VARCHAR(50) NOT NULL, 
		kota_asal VARCHAR(20) NOT NULL 
);

CREATE TABLE players(
		id INT PRIMARY KEY AUTO_INCREMENT,
		nama_pemain VARCHAR(50) NOT NULL,
		posisi VARCHAR(20) NOT NULL,
		id_club INT,
		FOREIGN KEY (id_club) REFERENCES club(id)		 
);

CREATE TABLE matches(
		id INT PRIMARY KEY AUTO_INCREMENT,
		id_klub_tuan_rumah INT,
		FOREIGN KEY (id_klub_tuan_rumah) REFERENCES club(id)
		id_klub_tamu INT,
		FOREIGN KEY (id_klub_tamu) REFERENCES club(id), 
		skor_tuan_rumah INT DEFAULT 0,
		skor_tamu INT DEFAULT 0
);
-- create index
CREATE INDEX index_posisi ON players(posisi);
CREATE INDEX index_kota_asal ON club(kota_asal);

-- ---- -- ---- -- nomor 2 dan 3

USE classicmodels;
-- nomor 2
SELECT customerName, country, 
		 SUM(p.amount)AS TotalPayment, 
		 COUNT(o.orderNumber) AS orderCount,
		 MAX(p.paymentDate) AS LastPaymentDate,
Case 
when SUM(p.amount) > 100000 then 'VIP'
when SUM(p.amount) BETWEEN 5000 AND 100000 then 'Loyal'
when SUM(p.amount) < 5000 then 'New'
ELSE 'New' 
END AS 'Status'
FROM customers c 
left JOIN payments p USING(customerNumber)
left JOIN orders o USING(customerNumber)
GROUP BY customerName


-- nomor 3
SELECT c.customerNumber, c.customerName, COUNT(orderNumber), 
		 SUM(od.quantityOrdered) AS total_quantity,
case 
	when SUM(quantityOrdered) > (SELECT AVG(total_hasil)
										  FROM (SELECT SUM(quantityOrdered) AS total_hasil
										  FROM orderdetails GROUP BY orderNumber) AS total)
	then 'di atas rata-rata'
ELSE 'di bawah rata-rata'
END AS kategori_pembelian
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
GROUP BY c.customerNumber
ORDER BY `total_quantity` DESC 

SELECT c.customerNumber, COUNT(od.quantityOrdered)
FROM customers c
JOIN orders USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
GROUP BY customerNumber












