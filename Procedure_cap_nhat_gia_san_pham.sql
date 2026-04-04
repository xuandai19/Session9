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
