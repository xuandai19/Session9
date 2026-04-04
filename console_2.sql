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

CREATE INDEX idx_product_category ON products(category_id);

CLUSTER products USING idx_product_category;

CREATE INDEX idx_prodcut_price ON products(price);

SELECT * FROM Products WHERE category_id = 101 ORDER BY price;




CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    amount INT
);

INSERT INTO sales (customer_id, product_id, sale_date, amount)
VALUES (1, 101, '2026-01-10', 5000),
    (2, 102, '2026-01-11', 150),
    (1, 103, '2026-01-12', 2500),
    (3, 101, '2026-01-13', 1000),
    (2, 105, '2026-01-14', 300),
    (1, 102, '2026-01-15', 1200);

CREATE OR REPLACE VIEW v_customersales AS
SELECT customer_id, sum(amount) total_amount
FROM sales
GROUP BY customer_id;

SELECT * FROM v_customersales
WHERE total_amount > 1000;

UPDATE v_customersales
SET total_amount = 2000
WHERE customer_id = 1;



CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT,
    sale_date DATE,
    amount INT
);

INSERT INTO sales (customer_id, sale_date, amount)
VALUES (1, '2026-01-10', 5000),
       (2, '2026-01-11', 150),
       (1, '2026-01-12', 2500),
       (3, '2026-01-13', 1000),
       (2, '2026-01-14', 300),
       (1, '2026-01-15', 1200);

CREATE OR REPLACE PROCEDURE calculate_total_sales (
    IN start_date DATE,
    IN end_date DATE,
    OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT sum(amount) INTO total
    FROM sales
    WHERE sale_date BETWEEN start_date AND end_date;

    RAISE NOTICE 'Tong doanh thu tu % den % la: %', start_date, end_date, total;
end;
$$;

DO $$
    DECLARE kq NUMERIC;
BEGIN
    CALL calculate_total_sales('2026-01-11', '2026-01-14', kq);
end;
$$;



CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category_id INT,
    price DECIMAL(10, 2)
);

INSERT INTO products (category_id, name, price)
VALUES (101, 'Laptop DELL', 50.50),
       (102, 'Laptop MSI', 10.30),
       (101, 'Laptop LENOVO', 35.00),
       (102, 'Laptop MACBOOK',23.40);

CREATE OR REPLACE PROCEDURE update_product_price (
    IN p_category_id INT,
    IN p_increase_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    r_product RECORD;
    v_new_price DECIMAL(10, 2);
BEGIN
    FOR r_product IN
        SELECT product_id, price
        FROM products
        WHERE category_id = p_category_id
        LOOP
            v_new_price := r_product.price * (1 + p_increase_percent / 100);

            UPDATE products
            SET price = v_new_price
            WHERE product_id = r_product.product_id;

            RAISE NOTICE 'San pham ID % da tang gia tu % len %', r_product.product_id, r_product.price, v_new_price;
        END LOOP;
end;
$$;

SELECT * FROM products WHERE category_id = 101;

CALL update_product_price(101, 10);

SELECT * FROM products WHERE category_id = 101;
