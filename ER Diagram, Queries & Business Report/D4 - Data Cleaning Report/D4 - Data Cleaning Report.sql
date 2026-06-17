USE smart_analysis;
SELECT * FROM customers;
SELECT  *FROM restaurants;
SELECT * FROM delivery_partners;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM ratings;
SELECT * FROM customer_behavior;

-- Checking for any null values 

SELECT * FROM customers
WHERE customer_name IS NULL OR city IS NULL OR signup_date IS NULL;

SELECT * FROM restaurants
WHERE restaurant_name IS NULL OR city IS NULL;

SELECT * FROM orders
WHERE order_time IS NULL;

SELECT status, COUNT(*)
FROM orders
WHERE delivered_time IS NULL
GROUP BY status;

-- Checking for duplicates 

SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT payment_id, COUNT(*)
FROM payments
GROUP BY payment_id
HAVING COUNT(*) > 1;

SELECT *
FROM restaurants
WHERE rating < 1 OR rating > 5;

SELECT *
FROM ratings
WHERE customer_rating < 1 OR customer_rating > 5;

-- Checking City Name Consistency
SELECT DISTINCT city
FROM customers
ORDER BY city;

SELECT DISTINCT city
FROM restaurants
ORDER BY city;

-- Check Foreign Key Integrity
SELECT *
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT *
FROM orders o
LEFT JOIN restaurants r
ON o.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL;

SELECT *
FROM orders o
LEFT JOIN delivery_partners d
ON o.partner_id = d.partner_id
WHERE d.partner_id IS NULL;

SELECT *
FROM orders o
LEFT JOIN delivery_partners d
ON o.partner_id = d.partner_id
WHERE d.partner_id IS NULL;  -- All should return 0 rows.

-- Remove leading/trailing spaces
UPDATE customers
SET city = TRIM(city);
UPDATE restaurants
SET city = TRIM(city);


