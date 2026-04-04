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