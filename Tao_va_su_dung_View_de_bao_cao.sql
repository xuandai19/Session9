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
