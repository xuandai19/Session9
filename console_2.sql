CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (101, '2023-10-01 10:30:00', 150.50),
    (102, '2023-10-02 14:15:00', 200.00),
    (101, '2023-10-03 09:00:00', 45.00),
    (103, '2023-10-04 16:45:00', 320.75),
    (102, '2023-10-05 11:20:00', 99.99);

EXPLAIN ANALYZE SELECT * FROM orders WHERE customer_id = 101;

CREATE INDEX idx_orders_customer ON orders(customer_id);

EXPLAIN ANALYZE SELECT * FROM orders WHERE customer_id = 101;



CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(100),
    username VARCHAR(100)
);

INSERT INTO Users (email, username)
VALUES ('alex.nguyen@gmail.com', 'alex_n'),
    ('huong.tran@yahoo.com', 'huong_rose'),
    ('example@example.com', 'test_user'),
    ('dev.master@outlook.com', 'code_wizard'),
    ('support@company.vn', 'admin_supp');

CREATE INDEX idx_user_email ON users USING hash (email);

EXPLAIN ANALYZE SELECT * FROM Users WHERE email = 'example@example.com';



CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    category_id INT,
    price DECIMAL(10, 2),
    stock_quantity INT
);

INSERT INTO products (category_id, price, stock_quantity)
VALUES (101, 50.50, 5),
       (102, 10.30, 6),
       (101, 35.00, 3),
       (102, 23.40, 4);

CLUSTER products USING idx_product_category;

CREATE INDEX idx_prodcut_price ON products(price);

SELECT * FROM Products WHERE category_id = 101 ORDER BY price;