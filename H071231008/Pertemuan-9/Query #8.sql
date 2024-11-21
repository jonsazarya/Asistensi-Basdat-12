	  
	CREATE DATABASE teambola;
	USE teambola;
	
	CREATE TABLE club (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(50) NOT NULL
	);
		CREATE INDEX index_kota ON club(kota_asal);
		
	CREATE TABLE player (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_pemain VARCHAR(50) NOT NULL,
	posisi VARCHAR(50) NOT NULL,
	id_klub INT,
	FOREIGN KEY (id_klub) REFERENCES club(id)
	);
	CREATE INDEX index_posisi ON player(posisi);
	
	CREATE TABLE pertandigan (
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_tuanrumah INT,
	id_tamu INT,
	tanggal_pertandingan date NOT NULL,
	position VARCHAR(50) NOT NULL,
	skor_tuanrumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0,
	FOREIGN KEY (id_tamu) REFERENCES club(id),
	FOREIGN KEY (id_tuanrumah) REFERENCES club(id)
	);
	
	
	
	SELECT customerName,
	 country,
	  SUM(amount) AS "totalPayments",
	  COUNT(orderNumber) AS "orderCount",
	  max(paymentDate) AS "lastPaymentDate",
	  CASE
	  	when SUM(amount) > 100000 then "VIP"
	  	when SUM(amount) BETWEEN 5000 AND 99999 then "VIP"
	  	when SUM(amount) < 5000 then "VIP"
	  	ELSE "NEW"
	  end AS "STATUS"
	  FROM customers
	  left JOIN payments
	  USING (customerNumber)
	  left JOIN orders
	  USING (customerNumber)
	  GROUP BY customerName
	  
	  SELECT customerNumber,
	  customerName,
	  SUM(quantityOrdered) AS "total_quantity",
	  CASE 
	  	when SUM(quantityOrdered) > 
		  (SELECT avg(quantityOrdered) FROM orderdetails)
		  then "Diatas Rata Rata"
	  	ELSE "Di bawah rata rata"
		END AS "kat_pem"
		FROM customers
		JOIN orders
		USING (customerNumber)
		JOIN orderdetails
		USING (orderNumber)
		GROUP BY customerName
		ORDER BY SUM(quantityOrdered) desc

SET AUTOCOMMIT = OFF ;
START TRANSACTION;



INSERT INTO club (nama_klub,kota_asal)
VALUES
("Persija", "Jakarta"),
("Arema FC", "Malang"),
("Persebaya", "Surabaya"),
("PSM Makassar", "Makassar"),
("Bali United", "Bali");


INSERT INTO player (nama_pemain, posisi, id_klub)
VALUES ("Evan Dimas", "Midfielder", (SELECT id FROM club WHERE nama_klub = "Persija"));

INSERT INTO player (nama_pemain, posisi, id_klub)
VALUES ("Riko Simanjuntak", "Forward", (SELECT id FROM club WHERE nama_klub = "Persija"));

INSERT INTO player (nama_pemain, posisi, id_klub)
VALUES ("Hanif Sjahbandi", "Defender", (SELECT id FROM club WHERE nama_klub = "Arema FC"));

INSERT INTO player (nama_pemain, posisi, id_klub)
VALUES ("Makan Konate", "Midfielder", (SELECT id FROM club WHERE nama_klub = "Arema FC"));

INSERT INTO player (nama_pemain, posisi, id_klub)
VALUES ("David da Silva", "Forward", (SELECT id FROM club WHERE nama_klub = "Persebaya"));

INSERT INTO player (nama_pemain, posisi, id_klub)
VALUES ("Irfan Jaya", "Forward", (SELECT id FROM club WHERE nama_klub = "PSM Makassar"));

INSERT INTO player (nama_pemain, posisi, id_klub)
VALUES ("Rizky Pellu", "Midfielder", (SELECT id FROM club WHERE nama_klub = "PSM Makassar"));

INSERT INTO player (nama_pemain, posisi, id_klub)
VALUES ("Ilija Spasojevic", "Forward", (SELECT id FROM club WHERE nama_klub = "Bali United"));

INSERT INTO player (nama_pemain, posisi, id_klub)
VALUES ("Andhika Wijaya", "Defender", (SELECT id FROM club WHERE nama_klub = "Bali United"));


	CREATE TABLE pertandigan (
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_tuanrumah INT,
	id_tamu INT,
	tanggal_pertandingan date NOT NULL,
	position VARCHAR(50) NOT NULL,
	skor_tuanrumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0,
	FOREIGN KEY (id_tamu) REFERENCES club(id),
	FOREIGN KEY (id_tuanrumah) REFERENCES club(id)
	);
INSERT INTO pertandigan (tanggal_pertandingan,id_tuanrumah,skor_tuanrumah,id_tamu,skor_tamu)
VALUES ("2024-09-10", 1, 2, 2, 1),
("2024-09-12", 3, 1, 4, 1),
("2024-09-15", 5, 0, 1, 3),
("2024-09-20", 2, 1, 5, 2),
("2024-09-25", 4, 2, 3, 0)

COMMIT

	