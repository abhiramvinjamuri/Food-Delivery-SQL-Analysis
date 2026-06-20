CREATE DATABASE smart_analysis;
USE smart_analysis;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(20),
    city VARCHAR(50),
    signup_date DATE
);
SELECT * FROM customers; 
SELECT COUNT(*) FROM customers;

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    cuisine_type VARCHAR(50),
    city VARCHAR(50),
    rating DECIMAL(2,1),
    CHECK (rating BETWEEN 1.0 AND 5.0)
);

SELECT * FROM restaurants; 
SELECT COUNT(*) FROM restaurants;

CREATE TABLE delivery_partners (
    partner_id INT PRIMARY KEY,
    partner_name VARCHAR(100) NOT NULL,
    vehicle_type VARCHAR(30),
    joining_date DATE
);

SELECT * FROM delivery_partners; 
SELECT COUNT(*) FROM delivery_partners;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    partner_id INT NOT NULL,
    order_time DATETIME NOT NULL,
    delivered_time DATETIME NULL,
    order_amount DECIMAL(10,2) NOT NULL,
    delivery_fee DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),

    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),

    FOREIGN KEY (partner_id) REFERENCES delivery_partners(partner_id)
);

desc orders;
select * from orders;
SELECT COUNT(*) FROM orders;
SELECT status, COUNT(*)
FROM orders
GROUP BY status;

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_mode VARCHAR(30) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


CREATE TABLE orders_stage (
    order_id VARCHAR(20),
    customer_id VARCHAR(20),
    restaurant_id VARCHAR(20),
    partner_id VARCHAR(20),
    order_time VARCHAR(50),
    delivered_time VARCHAR(50),
    order_amount VARCHAR(20),
    delivery_fee VARCHAR(20),
    status VARCHAR(20)
);
select count(*) from orders_stage;


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    partner_id INT NOT NULL,
    order_time DATETIME NOT NULL,
    delivered_time DATETIME NULL,
    order_amount DECIMAL(10,2) NOT NULL,
    delivery_fee DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL
);


INSERT INTO orders
SELECT
    order_id,
    customer_id,
    restaurant_id,
    partner_id,
    CAST(order_time AS DATETIME),
    CAST(NULLIF(delivered_time,'') AS DATETIME),
    order_amount,
    delivery_fee,
    status
FROM orders_stage;

INSERT INTO orders
(
    order_id,
    customer_id,
    restaurant_id,
    partner_id,
    order_time,
    delivered_time,
    order_amount,
    delivery_fee,
    status
)
SELECT
    order_id,
    customer_id,
    restaurant_id,
    partner_id,
    order_time,
    NULLIF(delivered_time,''),
    order_amount,
    delivery_fee,
    status
FROM orders_stage;
select * from orders;
select * from orders where status = 'Pending';
select count(*) from orders;


CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_mode VARCHAR(30) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

select * from payments;

CREATE TABLE ratings (
    rating_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    customer_rating DECIMAL(2,1),
    feedback TEXT,

    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CHECK (customer_rating BETWEEN 1.0 AND 5.0)
);

CREATE TABLE customer_behavior (
    customer_id INT PRIMARY KEY,
    total_orders INT DEFAULT 0,
    total_spending DECIMAL(12,2) DEFAULT 0,
    avg_order_value DECIMAL(10,2),
    last_order_days INT,
    churn_flag TINYINT,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM restaurants;
SELECT COUNT(*) FROM delivery_partners;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM payments;
SELECT COUNT(*) FROM ratings;
SELECT COUNT(*) FROM customer_behavior;

desc orders;

-- Orders Table Data Cleaning & Import Process
-- During the import of orders.csv, only 8,197 records were initially loaded into the orders table instead of the expected 10,000 records. Investigation showed that all imported records had a status of "Delivered", while records with "Pending" and "Cancelled" status were missing.
-- To identify the issue, the raw CSV file was imported into a staging table (orders_stage) where all columns were stored as VARCHAR data types. Validation confirmed that all 10,000 records were present in the staging table, including orders with blank delivered_time values.
-- The root cause was that the Import Wizard was unable to correctly handle rows containing empty delivery timestamps during datatype conversion. As a result, records with blank delivered_time values were not loaded into the final orders table.
-- To resolve this issue:
-- 	1. A staging table (orders_stage) was created with all columns defined as VARCHAR.
-- 	2. The complete orders.csv file was imported into the staging table.
-- 	3. The orders table was recreated with appropriate data types.
-- 	4. Data was transferred from the staging table to the final table using an INSERT...SELECT statement.
-- 	5. Empty delivery timestamps were converted to NULL using the NULLIF() function.
-- SQL used:
-- INSERT INTO orders
-- (
--     order_id,
--     customer_id,
--     restaurant_id,
--     partner_id,
--     order_time,
--     delivered_time,
--     order_amount,
--     delivery_fee,
--     status
-- )
-- SELECT
--     order_id,
--     customer_id,
--     restaurant_id,
--     partner_id,
--     order_time,
--     NULLIF(delivered_time,''),
--     order_amount,
--     delivery_fee,
--     status
-- FROM orders_stage;
-- Final Validation:
-- 