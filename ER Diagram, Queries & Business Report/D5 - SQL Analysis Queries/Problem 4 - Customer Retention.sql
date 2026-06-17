-- Problem 4 - Customer Retention
-- Acquiring a new customer costs five times more than retaining an existing one. Identifying and re-engaging at-risk customers is a strategic priority
-- =============================================================================================================================================================
USE smart_analysis;
SELECT * FROM customers;
SELECT * FROM delivery_partners;
SELECT * FROM restaurants;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM ratings;
SELECT * FROM customer_behavior;
-- =============================================================================================================================================================

-- Q1 Who are the top 10 most valuable customers by lifetime spending?
SELECT 
c.customer_id, 
c.customer_name, 
cb.total_spending,
DENSE_RANK() OVER(ORDER BY total_spending desc) as rank_custoner
FROM customers c
JOIN customer_behavior cb
ON c.customer_id = cb.customer_id
ORDER BY cb.total_spending DESC
LIMIT 10;
-- Insight:
-- Kiran Shah is the highest spending customer in the dataset.

-- =============================================================================================================================================================

-- Q2. Which customers order most frequently, and what is their average order value?
SELECT 
c.customer_id, 
c.customer_name, 
cb.total_orders,
cb.avg_order_value
FROM customers c
JOIN customer_behavior cb
ON cb.customer_id = c.customer_id
ORDER BY cb.total_orders DESC;
-- Insights:
-- A few customers place significantly more orders than others.
-- These customers contribute regular business to the platform.
-- Retaining frequent customers can help maintain stable revenue.

-- =============================================================================================================================================================

-- Q3 Which customers have gone inactive in the last 90 days?
SELECT 
c.customer_id, 
c.customer_name, 
cb.last_order_days
FROM customers c
JOIN customer_behavior cb
ON cb.customer_id = c.customer_id
WHERE cb.last_order_days > 90
ORDER BY cb.last_order_days DESC;
-- Insights:
-- 350 customers have not placed an order for at least 90 days.
-- These customers may no longer be actively using the platform.
-- Marketing could help bring some of these customers back.

-- =============================================================================================================================================================

-- Q4. What behavioural patterns signal that a customer is about to churn?
SELECT
customer_id,
total_orders,
total_spending,
avg_order_value,
last_order_days,
CASE
	WHEN last_order_days > 90 THEN 'Inactive'
	WHEN last_order_days BETWEEN 60 AND 90 THEN 'At Risk'
	ELSE 'Active'
	END AS customer_status
FROM customer_behavior
ORDER BY last_order_days DESC;
SELECT
customer_status,
customer_count,
ROUND(customer_count * 100.0 /SUM(customer_count) OVER(),2) AS percentage
FROM (
SELECT
CASE
	WHEN last_order_days > 90 THEN 'Inactive'
	WHEN last_order_days BETWEEN 60 AND 90 THEN 'At Risk'
	ELSE 'Active'
	END AS customer_status,
COUNT(*) AS customer_count
FROM customer_behavior
GROUP BY customer_status
) x;
-- Insights:
-- Customers were grouped into Active, At Risk, and Inactive categories based on their recent activity.
-- 490 customers (35%) are Active, 160 customers (16%) are At Risk, and 350 customers (35%) are Inactive.
-- The At Risk and Inactive groups should be prioritised for retention.

-- =============================================================================================================================================================