CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    amount NUMERIC(10,2),
    order_date DATE DEFAULT NOW()
);

INSERT INTO customers (name, email)
VALUES ('Nguyen Van A', 'a@gmail.com'),
       ('Nguyen Van B', 'b@gmail.com');

CREATE OR REPLACE PROCEDURE add_order (
    p_customer_id INT,
    p_amount NUMERIC(10,2)
)
LANGUAGE plpgsql
AS $$
    DECLARE
        v_exist BOOLEAN;
BEGIN
    SELECT exists(SELECT 1 FROM customers WHERE customer_id = p_customer_id) INTO v_exist;
    IF NOT v_exist THEN
        RAISE EXCEPTION 'Customer not found';
    end if;

    INSERT INTO orders (customer_id, amount)
    VALUES (p_customer_id, p_amount);
end;
$$;

CALL add_order (2, 10000);



