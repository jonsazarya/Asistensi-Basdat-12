USE dbsepakbola;

START TRANSACTION 
SET autocommit  = OFF 

INSERT INTO club(id, nama_klub, kota_asal)
VALUE (1,"Persija","Jakarta"), 
		(2, "Arema FC", "Malang"),
		(3, "Persebaya", "Surabaya"),
		(4, "PSM Makassar", "Makassar"),
		(5, "Bali United", "Bali")

ROLLBACK 
SELECT * FROM club;

INSERT INTO players(id, nama_pemain,posisi,id_club)
VALUE (1, "Evan Dimas", "Midfielder", 1),
		(2, "Riko Simanjuntak", "Forward", 1),
		(3, "Hanif Sjahbandi", "Defender",2),
		(4, "Makan Konate", "Midfielder",2),
		(5, "David da Silva", "Forward", 3),
		(6, "Irfan Jaya", "Forward", 4),
		(7, "Rizky Pellu", "Mildfielder", 4),
		(8, "Ilija Spasojevic", "Forward", 5),
		(9, "Andhika Wijaya", "Defender", 5)
		
ROLLBACK 
SELECT * FROM players;

INSERT INTO matches(id, id_klub_tuan_rumah, 
						  id_klub_tamu,
						  skor_tuan_rumah, skor_tamu, tanggal_pertandingan)
VALUES (1, 1, 2, 2, 1, "2024-09-10"),
		 (2, 3, 4, 1, 1, "2024-09-12"),
		 (3, 5, 1, 0, 3, "2024-09-15"),
		 (4, 2, 5, 1, 2, "2024-09-20"),
		 (5, 4, 3, 2, 0, "2024-09-25")
ROLLBACK 
SELECT * FROM matches;

COMMIT;
-- menampilkan hasil pertandingan bagi tuan rumah
SELECT c.nama_klub, m.skor_tuan_rumah AS 'Tuan Rumah', m.skor_tamu, m.tanggal_pertandingan,
case 
when  m.skor_tuan_rumah > m.skor_tamu   then 'Menang'
when  m.skor_tuan_rumah = m.skor_tamu then 'Seri'
when  m.skor_tuan_rumah < m.skor_tamu then 'Kalah'
ELSE 'Tidak Resmi'
END AS 'Hasil Pertandingan Bagi Tuan Rumah'
FROM club c
JOIN matches m ON m.id_klub_tuan_rumah = c.id

