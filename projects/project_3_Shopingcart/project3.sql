CREATE TABLE products (
id bigserial PRIMARY KEY,
name varchar (30) NOT NULL,
price money NOT NULL
);

INSERT INTO products (name, price )
VALUES
('coke' ,10),
('chips', 5);

SELECT * FROM products;

CREATE TABLE users (
id bigserial PRIMARY KEY,
name varchar(30) NOT NULL
);

INSERT INTO users (name)
VALUES
('Arnold'),
('Sheryl');

SELECT *from users;

CREATE OR REPLACE FUNCTION addproduct(prod_id bigint)
RETURNS void AS $$
BEGIN
IF EXISTS (SELECT * FROM cart WHERE product_id =prod_id)
THEN
UPDATE cart SET qty = qty + 1 WHERE product_id = prod_id;
ELSE
INSERT INTO cart(product_id,qty)VALUES (prod_id,1);
END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION addproduct(prod_id bigint)
RETURNS void AS $$
BEGIN
IF EXISTS (SELECT * FROM cart WHERE product_id =prod_id)
THEN
UPDATE cart SET qty = qty - 1 WHERE product_id = prod_id;
ELSE
INSERT INTO cart(product_id,qty)VALUES (prod_id,1);
END IF;
END;
$$ LANGUAGE plpgsql;


---add coke
SELECT addproduct(1);
---add coke
SELECT addproduct(1);
---add chips
SELECT addproduct(2);



CREATE TABLE cart (
product_id bigint PRIMARY KEY,
qty bigint
);

SELECT * FROM cart;

CREATE TABLE order_header (
order_id bigserial PRIMARY KEY,
user_id bigint REFERENCES users(id)ON DELETE CASCADE,
order_date timestamp NOT NULL
);

INSERT INTO order_header (user_id,order_date)
VALUES
(1,'15 apr 15h30');

SELECT *FROM order_header; 

CREATE TABLE order_details(
order_header bigint REFERENCES order_header(order_id)ON DELETE CASCADE,
prod_id bigint REFERENCES products(id),
qty bigint NOT NULL
);



INSERT INTO order_details (order_header,prod_id,qty)
VALUES
(1, 1, 2),
(1, 2, 1),
(1, 3, 1),
(1, 4, 2);
SELECT * FROM order_details;

DELETE FROM cart;

INSERT INTO products (name,price)
VALUES
('sugar', 45.99),
('clover milk',89.99),
('luckstar pilchards',11.99),
('koo baked beans',13);

---add sugar
SELECT addproduct(3)
SELECT * FROM cart;
--add milk
SELECT addproduct(4)
SELECT * FROM cart;
---add luckystar
SELECT addproduct(5)
SELECT * FROM cart;
---add koo beans
SELECT addproduct(6)
SELECT * FROM cart;


DELETE FROM cart WHERE product_id =4;
SELECT * FROM cart;

DELETE FROM cart WHERE product_id =1;
SELECT * FROM cart;

DELETE FROM cart WHERE product_id =4;
SELECT * FROM cart;

SELECT * FROM order_header

SELECT users.name,oh.order_date, prod.name, prod.price, od.qty
FROM order_header oh
INNER JOIN order_details od
ON oh.order_id = od.order_header
INNER JOIN users
ON users.id = oh.user_id
INNER JOIN products prod
ON prod.id =od.prod_id
WHERE order_id = 1;

DROP TABLE users;
DROP TABLE order_details;
DROP TABLE order_header;
DROP TABLE products;
DROP TABLE cart;

