-- Problem 5 - Delivery Partner Performance
-- Delivery partners are the face of the company. Poor partner performance directly damages customer experience and brand reputation.
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

-- Q1 Who are the fastest delivery partners based on average delivery time?
WITH partner_delivery_time AS (
SELECT
partner_id,
AVG(TIMESTAMPDIFF(MINUTE,order_time,delivered_time)) AS avg_delivery_time
FROM orders
WHERE status = 'Delivered'
GROUP BY partner_id
)
SELECT
dp.partner_id,
dp.partner_name,
pdt.avg_delivery_time,
DENSE_RANK() OVER(ORDER BY avg_delivery_time ASC) AS rank_based_on_avg_deli_time
FROM delivery_partners dp
JOIN partner_delivery_time pdt
ON pdt.partner_id = dp.partner_id
ORDER BY avg_delivery_time ASC;


-- =============================================================================================================================================================

-- Q2 Which partners handle the highest volume of successful deliveries?
WITH successful_deliveries AS (
SELECT
partner_id,
COUNT(*) AS total_deliveries
FROM orders
WHERE status = 'Delivered'
GROUP BY partner_id
)
SELECT
dp.partner_id,
dp.partner_name,
sd.total_deliveries,
DENSE_RANK() OVER(ORDER BY total_deliveries DESC) AS rnk
FROM delivery_partners dp
JOIN successful_deliveries sd  
ON sd.partner_id = dp.partner_id
ORDER BY total_deliveries DESC;

-- =============================================================================================================================================================

-- Q3. Which partners are associated with the most cancellations or delays?
WITH partner_cancellations AS (
SELECT
partner_id,
COUNT(*) AS cancellations
FROM orders
WHERE status = 'Cancelled'
GROUP BY partner_id
)
SELECT
dp.partner_id,
dp.partner_name,
pc.cancellations
FROM delivery_partners dp
JOIN partner_cancellations pc 
ON pc.partner_id = dp.partner_id
ORDER BY cancellations DESC;
-- Insight:
-- Sriram Pillai recorded the highest number of cancellations in the dataset.

-- =============================================================================================================================================================

-- Q4. What is the average customer rating received per delivery partner?
WITH partner_ratings AS (
SELECT
o.partner_id,
AVG(r.customer_rating) AS avg_rating
FROM orders o
JOIN ratings r
ON r.order_id = o.order_id
GROUP BY o.partner_id
)
SELECT
dp.partner_id,
dp.partner_name,
ROUND(pr.avg_rating,2) AS avg_rating
FROM delivery_partners dp
JOIN partner_ratings pr 
ON pr.partner_id = dp.partner_id
ORDER BY avg_rating DESC;
-- Insight:
-- Average customer ratings range from approximately 2.4 to 3.5

-- =============================================================================================================================================================


