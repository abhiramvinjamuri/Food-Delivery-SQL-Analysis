-- Problem 1: Delivery Delays
-- Customer complaints regarding late deliveries have increased significantly, leading to poor ratings and reduced repeat orders.
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

-- Q1 Which restaurants are associated with the longest average delivery times?
SELECT 
r.restaurant_id,
r.restaurant_name, 
AVG(TIMESTAMPDIFF(MINUTE,o.order_time,o.delivered_time)) AS avg_delivery_time
FROM orders o
JOIN restaurants r
ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.restaurant_id,r.restaurant_name
ORDER BY avg_delivery_time DESC;
-- Insights: 
-- Bombay Hub and a few Royal restaurants have the highest average delivery times.
-- These restaurants may need process improvements to reduce delays.

-- =============================================================================================================================================================

-- Q2 Which delivery partners have the highest average time per order?
SELECT 
dp.partner_id, 
dp.partner_name, 
AVG(TIMESTAMPDIFF(MINUTE,o.order_time,o.delivered_time)) AS avg_delivery_time
FROM orders o
JOIN delivery_partners dp
ON o.partner_id = dp.partner_id
WHERE o.status = 'Delivered'
GROUP BY dp.partner_id, dp.partner_name
ORDER BY avg_delivery_time DESC;
-- Insights
-- Delivery performance varies significantly between partners.
-- Some partners consistently take longer to complete deliveries than others.

-- =============================================================================================================================================================

-- Q3 Which cities experience the most delivery delays?
SELECT 
r.city,
AVG(TIMESTAMPDIFF(MINUTE,o.order_time,o.delivered_time)) AS avg_delivery_time
FROM orders o
JOIN restaurants r
ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.city
ORDER BY avg_delivery_time DESC;
-- Insights:
-- Hyderabad recorded the highest average delivery time, while Mumbai had the lowest.
-- City differences are small compared to restaurant and partner differences.

-- =============================================================================================================================================================

-- Q4 Are delivery delays increasing or decreasing over time?
SELECT 
DATE_FORMAT(order_time,'%Y-%m') AS month, 
AVG(TIMESTAMPDIFF(MINUTE,order_time,delivered_time)) AS avg_delivery_time
FROM orders
WHERE status='Delivered'
GROUP BY month
ORDER BY month;
-- Insights:
-- Delivery times remained fairly stable across the two year period.
-- No major long term increase or decrease in delivery delays was observed.

-- =============================================================================================================================================================