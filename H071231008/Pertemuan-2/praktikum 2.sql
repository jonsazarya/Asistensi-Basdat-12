SELECT productCode AS "kode produk", productName AS "nama produk", quantityInStock AS "stok"
FROM products WHERE quantityInStock > 5000 AND quantityInStock <6001;

SELECT orderNumber AS "Nomor Pesanan",orderDate AS "tanggal pesanan", STATUS,customerNumber AS "nomor pelanggan"
FROM orders WHERE STATUS != "shipped";

SELECT employeeNumber AS "nomor karyawan",firstName, lastName, email, jobtitle AS "jabatan" FROM employees WHERE jobtitle = "Sales Rep" LIMIT 10;

SELECT productCode AS "kode produk",productName AS "nama produk",productLine AS "lini produk",buyPrice AS "harga beli"
 FROM products ORDER BY buyPrice DESC LIMIT 5,10;
 
SELECT DISTINCT country, city FROM customers ORDER BY country ASC, city ASC;

SELECT DISTINCT country, city FROM customers ORDER BY country ASC, city DESC;

SELECT * FROM employees WHERE firstName = "gerard";
SELECT customerName AS "nama kustomer", city AS "Kota",country AS "negara", salesRepEmployeeNumber AS "ada"
FROM customers WHERE salesRepEmployeeNumber = 1370;