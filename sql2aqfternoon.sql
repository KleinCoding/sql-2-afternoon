--Practice Joins

--1.

SELECT *
FROM invoice i
    JOIN invoice_line il
    ON i.invoice_id = il.invoice_id
WHERE il.unit_price > .99;

--2. 

SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
    JOIN customer c
    ON i.customer_id = c.customer_id;

--3. 

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
    JOIN employee e
    ON c.support_rep_id = e.employee_id;

--4. 

SELECT al.title, ar.name
FROM album al
    JOIN artist ar
    ON al.artist_id = ar.artist_id;

--5. 

SELECT pt.track_id
FROM playlist_track pt
    JOIN playlist pl
    ON pl.playlist_id = pt.playlist_id
WHERE pl.name = 'Music';

--6. 

SELECT *
from playlist_track;
SELECT t.name
FROM track t
    JOIN playlist_track pt
    ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

--7. 

SELECT t.name, pl.name
FROM track t
    JOIN playlist_track pt
    ON t.track_id = pt.track_id
    JOIN playlist pl
    ON pl.playlist_id = pt.playlist_id;

--8.

SELECT t.name, al.title
FROM track t
    JOIN genre g
    ON t.genre_id = g.genre_id
    JOIN album al
    ON al.album_id = t.album_id
WHERE g.name = 'Alternative & Punk';




--Practice Nested Queries

-- 1.

SELECT *
FROM invoice
WHERE invoice_id IN ( SELECT invoice_id
FROM invoice_line
WHERE unit_price > 0.99 );

-- 2. 

Select*
FROM playlist_track
WHERE playlist_id IN ( SELECT playlist_id
FROM playlist
WHERE name = 'Music');

-- 3. 

SELECT name
FROM track
WHERE track_id IN ( SELECT track_id
FROM playlist_track
WHERE playlist_id = 5 );

-- 4. 

SELECT *
FROM track
WHERE genre_id IN ( SELECT genre_id
FROM genre
WHERE name = 'Comedy' );

-- 5.

SELECT *
FROM track
WHERE album_id IN ( SELECT album_id
FROM album
WHERE title = 'Fireball' );

-- 6. 

SELECT *
FROM track
WHERE album_id IN ( 
  SELECT album_id
FROM album
WHERE artist_id IN ( 
    SELECT artist_id
FROM artist
WHERE name = 'Queen'
  )
);



--Practice Updating Rows

-- 1. 

UPDATE customer
SET fax = null
WHERE fax IS NOT null;

-- 2. 

UPDATE customer
SET company = 'Self'
WHERE company IS null;

-- 3. 

UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julie' AND last_name = 'Barnett';

-- 4. 

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

-- 5. 

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = ( SELECT genre_id
    FROM genre
    WHERE name = 'Metal' )
    AND composer IS null;



--Practice Group By

-- 1. 

SELECT COUNT(*), g.name
FROM track t
    JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;


-- 2. 
SELECT COUNT(*), g.name
FROM track t
    JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;




--Practice Distinct

-- 1. 

SELECT DISTINCT composer
FROM track;

-- 2. 

SELECT DISTINCT billing_postal_code
FROM invoice;

-- 3. 

SELECT DISTINCT company
FROM customer;




--Practice Delete Rows

-- 1. 

DELETE FROM practice_delete
WHERE type = 'bronze';

-- 2. 

DELETE FROM practice_delete
WHERE type = 'silver';

-- 3. 

DELETE FROM practice_delete
WHERE value = 150;


-- cCommerce problems 

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(60),
  email VARCHAR(100)
);

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  price INTEGER
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  product_id INTEGER REFERENCES products(id)
);

INSERT INTO users
(name, email)
VALUES
('Hank', 'beebop@rankhank.net'),
('Julie', 'iamjules@gmail.com'),
('Robbie', 'robbie@robbie.org');

INSERT INTO products
(name, price)
VALUES
('Foot Scrubber', 30),
('Computer', 1000),
('New Car', 23000);

INSERT INTO orders
(product_id)
VALUES
(1),
(2),
(3);

SELECT * FROM orders
WHERE id = 1;



SELECT * FROM orders;

SELECT SUM(p.price) FROM products AS p
INNER JOIN orders AS o
ON p.id = o.product_id
WHERE o.id = 1;

ALTER TABLE orders
ADD user_id INTEGER REFERENCES users(id);

UPDATE orders
SET user_id = 1
WHERE id = 1;


UPDATE orders
SET user_id = 3
WHERE id = 2;


UPDATE orders
SET user_id = 2
WHERE id = 3;


SELECT * FROM orders
NATURAL JOIN users
WHERE users.id = 1;

SELECT users.name, count(id) FROM orders
NATURAL JOIN users
GROUP BY users.id;

SELECT u.name, SUM(p.price) FROM products AS p

INNER JOIN orders AS o
ON o.product_id = p.id
INNER JOIN users AS u
ON u.id = o.user_id
GROUP BY u.id;