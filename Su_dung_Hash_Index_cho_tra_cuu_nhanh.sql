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
