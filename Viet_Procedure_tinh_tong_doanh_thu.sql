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
