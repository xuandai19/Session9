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
