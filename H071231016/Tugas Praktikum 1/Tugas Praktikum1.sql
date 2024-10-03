DROP DATABASE Library;
USE Library;

#NO 1
CREATE TABLE authors(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR (100) NOT NULL 		
);

CREATE TABLE books(
	id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR (100) NOT NULL,
	isbn CHAR (13),
	author_id INT,
	FOREIGN KEY (author_id) REFERENCES authors(id)
);

#NO 2
ALTER TABLE authors
ADD nationality VARCHAR (50);

#N0 3
ALTER TABLE books
MODIFY isbn CHAR (13) UNIQUE;

#NO 4
DESCRIBE books;
DESCRIBE authors;

#NO 5
CREATE  TABLE members(
	id INT PRIMARY KEY AUTO_INCREMENT ,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (100) UNIQUE,
	phone_number CHAR (10),
	join_date DATE,
	membership_type VARCHAR(50)
);

CREATE TABLE borrowing(
	id INT PRIMARY KEY AUTO_INCREMENT ,
	member_id INT NOT NULL,
	book_id INT NOT NULL,
	borrow_date DATE NOT NULL,
	RETURN_date DATE,
	FOREIGN KEY (member_id) REFERENCES members (id),
	FOREIGN KEY (book_id) REFERENCES books (id)
);


ALTER TABLE books
MODIFY title VARCHAR (150),
ADD UNIQUE (isbn), 
ADD published_year YEAR NOT NULL,
ADD genre VARCHAR (50) NOT NULL,
ADD copies_available INT NOT NULL;

DESCRIBE members;
DESCRIBE borrowing;