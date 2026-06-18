USE smart_analysis;

-- =====================================================================
-- Data Cleaning and Validation
-- Checked for null values, duplicate records, invalid ratings,
-- foreign key mismatches, city name consistency, invalid dates,
-- negative amounts, and text formatting issues.
-- =====================================================================

-- Preview Data

SELECT * FROM customers;
SELECT * FROM restaurants;
SELECT * FROM delivery_partners;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM ratings;
SELECT * FROM customer_behavior;

-- =====================================================================
-- Checking for Null Values
-- =====================================================================

SELECT *
FROM customers
WHERE customer_name IS NULL OR city IS NULL OR signup_date IS NULL;

SELECT *
FROM restaurants
WHERE restaurant_name IS NULL OR city IS NULL;

SELECT *
FROM orders
WHERE order_time IS NULL;

SELECT status, COUNT(*)
FROM orders
WHERE delivered_time IS NULL
GROUP BY status;

-- =====================================================================
-- Checking for Duplicate Records
-- =====================================================================

SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT payment_id, COUNT(*)
FROM payments
GROUP BY payment_id
HAVING COUNT(*) > 1;

-- =====================================================================
-- Checking Rating Ranges
-- =====================================================================

SELECT *
FROM restaurants
WHERE rating < 1 OR rating > 5;

SELECT *
FROM ratings
WHERE customer_rating < 1 OR customer_rating > 5;

-- =====================================================================
-- Checking City Name Consistency
-- =====================================================================

SELECT DISTINCT city
FROM customers
ORDER BY city;

SELECT DISTINCT city
FROM restaurants
ORDER BY city;

-- =====================================================================
-- Standardizing Text Values
-- =====================================================================

UPDATE customers
SET city = UPPER(TRIM(city));

UPDATE restaurants
SET city = UPPER(TRIM(city));

UPDATE payments
SET payment_mode = UPPER(TRIM(payment_mode));

-- =====================================================================
-- Foreign Key Integrity Checks
-- =====================================================================

SELECT * FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT * FROM orders o
LEFT JOIN restaurants r
ON o.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL;

SELECT * FROM orders o
LEFT JOIN delivery_partners d
ON o.partner_id = d.partner_id
WHERE d.partner_id IS NULL;

-- =====================================================================
-- Checking Invalid Delivery Times
-- =====================================================================

SELECT * FROM orders
WHERE delivered_time < order_time;

-- =====================================================================
-- Checking Negative Amounts
-- =====================================================================

SELECT *
FROM orders
WHERE order_amount < 0 OR delivery_fee < 0;

SELECT * FROM payments
WHERE amount < 0;

-- =====================================================================
-- Final Validation Counts
-- =====================================================================

SELECT COUNT(*) AS customers_count FROM customers;

SELECT COUNT(*) AS restaurants_count FROM restaurants;

SELECT COUNT(*) AS delivery_partners_count FROM delivery_partners;

SELECT COUNT(*) AS orders_count FROM orders;

SELECT COUNT(*) AS payments_count FROM payments;

SELECT COUNT(*) AS ratings_count FROM ratings;

SELECT COUNT(*) AS customer_behavior_count FROM customer_behavior;

-- =====================================================================
-- Cleaning Summary
-- =====================================================================
-- No duplicate records found.
-- No invalid ratings found.
-- No foreign key mismatches found.
-- No negative amounts found.
-- No invalid timestamps found.
-- City and payment mode values were standardized.
-- Dataset was validated and ready for analysis.
