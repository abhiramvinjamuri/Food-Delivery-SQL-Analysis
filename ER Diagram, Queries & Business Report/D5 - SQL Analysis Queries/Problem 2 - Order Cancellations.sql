-- Problem 2 - Order Cancellations
-- Cancellation rates have climbed over the past six months, creating revenue leakage and wasted operational resources.
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

-- Q1 Which restaurants receive the highest volume of cancellations?
SELECT 
r.restaurant_id, 
r.restaurant_name, 
COUNT(*) AS cancelled_orders
FROM  restaurants r
JOIN orders o
ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Cancelled'
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY cancelled_orders DESC;
-- Insight:
-- Classic Point and Royal Corner recorded the highest number of cancelled orders.

-- =============================================================================================================================================================

-- Q2 Which cities have the highest cancellation rates by percentage?
WITH city_orders AS (
SELECT 
r.city,
COUNT(*) AS total_orders
FROM restaurants r
JOIN orders o
ON o.restaurant_id = r.restaurant_id
GROUP BY r.city
),
city_cancellations AS (
SELECT 
r.city, 
COUNT(*) AS cancelled_orders
FROM restaurants r
JOIN orders o
ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Cancelled'
GROUP BY r.city
)
SELECT
co.city,
cc.cancelled_orders,
co.total_orders,
ROUND(cc.cancelled_orders * 100.0 / co.total_orders, 2) AS cancellation_rate
FROM city_orders co
JOIN city_cancellations cc
ON co.city = cc.city
ORDER BY cancellation_rate DESC;
-- Insights:
-- Ahmedabad has the highest cancellation rate at 13.49%.
-- Pune has the lowest cancellation rate at 10.85%.
-- Cancellation rates are ranging between 10% and 14%.

-- =============================================================================================================================================================

-- Q3 Is there a correlation between delivery delays and cancellations?
WITH delivery_stats AS (
SELECT 
restaurant_id,
AVG(TIMESTAMPDIFF(MINUTE,order_time,delivered_time)) AS avg_delivery_time
FROM orders
WHERE status = 'Delivered'
GROUP BY restaurant_id
),

cancellation_stats AS (SELECT restaurant_id, COUNT(*) AS cancellation_count 
FROM orders 
WHERE status = 'Cancelled' 
GROUP BY restaurant_id
)
SELECT r.restaurant_id, r.restaurant_name, ds.avg_delivery_time, cs.cancellation_count
FROM delivery_stats ds
JOIN cancellation_stats cs
ON ds.restaurant_id = cs.restaurant_id
JOIN restaurants r
ON ds.restaurant_id = r.restaurant_id
ORDER BY cs.cancellation_count DESC, ds.avg_delivery_time DESC;
-- Insights:
-- Some restaurants with higher delivery times also show higher cancellation counts.
-- But not all highly cancelled restaurants have unusually long delivery times.
-- Delivery delays appear to be one factor behind cancellations, but not the only cause.

-- =============================================================================================================================================================

-- Q4 On which days and at which times do cancellations peak?
SELECT DAYNAME(order_time) AS day_name, COUNT(*) AS cancellations
FROM orders
WHERE status = 'Cancelled'
GROUP BY day_name
ORDER BY cancellations DESC;
-- Insights:
-- Monday and Saturday recorded the highest number of cancellations.
-- Cancellation volumes remain relatively consistent throughout the week.

-- =============================================================================================================================================================






-- Alternative analysis for question number 3 
WITH restaurant_orders AS (SELECT
restaurant_id,
COUNT(*) AS total_orders,
SUM(status = 'Cancelled') AS cancelled_orders,
ROUND(SUM(status = 'Cancelled') * 100.0 / COUNT(*),2) AS cancellation_rate
FROM orders
GROUP BY restaurant_id
),
delivery_stats AS (SELECT 
restaurant_id,
AVG(TIMESTAMPDIFF(MINUTE, order_time, delivered_time)) AS avg_delivery_time
FROM orders
WHERE status = 'Delivered'
GROUP BY restaurant_id
)
SELECT
r.restaurant_id,
r.restaurant_name,
ds.avg_delivery_time,
ro.cancellation_rate
FROM restaurant_orders ro
JOIN delivery_stats ds
ON ro.restaurant_id = ds.restaurant_id
JOIN restaurants r
ON ro.restaurant_id = r.restaurant_id
ORDER BY cancellation_rate DESC;
-- =============================================================================================================================================================