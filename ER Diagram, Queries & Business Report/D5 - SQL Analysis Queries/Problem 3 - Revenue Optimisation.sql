-- Problem 3 - Revenue Optimisation
-- Revenue growth is inconsistent across cities, restaurants, and time periods. Management wants to identify and replicate success patterns
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

-- Q1 Which restaurants generate the highest total revenue?
WITH restaurant_revenue AS (
SELECT 
restaurant_id, 
SUM(order_amount + delivery_fee) AS total_revenue
FROM orders
WHERE status = 'Delivered'
GROUP BY restaurant_id
)
SELECT r.restaurant_id, r.restaurant_name, rr.total_revenue
FROM restaurants r
JOIN restaurant_revenue rr
ON rr.restaurant_id = r.restaurant_id
ORDER BY rr.total_revenue DESC;
-- Insights:
-- Taste Kitchen, Star Junction, and Golden Express are top 3 restaurants in terms of revenue 

-- =============================================================================================================================================================

-- Q2 Which cities contribute the most to overall company revenue?
WITH city_revenue AS (
SELECT 
r.city,
SUM(o.order_amount + o.delivery_fee) AS total_revenue
FROM  restaurants r
JOIN orders o
ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.city
)
SELECT * FROM city_revenue
ORDER BY total_revenue DESC;
-- Insights:
-- Chennai and Mumbai have the highest overall revenue.
-- Ahmedabad and Bangalore generated the lowest revenue.
-- Revenue is concentrated in a few major cities, creating opportunities for focused marketing.

-- =============================================================================================================================================================

-- Q3 Which payment methods are most popular and most valuable?
WITH payment_stats AS ( 
SELECT 
payment_mode, 
COUNT(*) AS transaction_count, 
SUM(amount) AS total_revenue
FROM payments
GROUP BY payment_mode
)
SELECT * FROM payment_stats
ORDER BY total_revenue DESC;
-- Insights:
-- UPI is the most popular payment method and also generates the highest revenue.
-- Cash on Delivery has the lowest transaction count and revenue contribution.
-- Customers appear to prefer digital payment methods over case payemnt method

-- =============================================================================================================================================================

-- Q4 What are the monthly revenue trends over the past year?
WITH monthly_revenue AS (
SELECT
DATE_FORMAT(order_time,'%Y-%m') AS month,
SUM(order_amount + delivery_fee) AS revenue
FROM orders
WHERE status = 'Delivered'
GROUP BY month
)
SELECT month, revenue,
LAG(revenue) OVER (ORDER BY month) AS prev_month,
revenue - LAG(revenue) OVER (ORDER BY month) AS revenue_change,
ROUND(((revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue) OVER (ORDER BY month)) * 100,2) AS growth_percentage
FROM monthly_revenue;
-- Insights:
-- Monthly revenue fluctuates throughout the two year period.
-- Strong growth was observed in March 2023 and October 2024.
-- Revenue declines were noticeable in February 2023, February 2024, and August 2024.

-- =============================================================================================================================================================