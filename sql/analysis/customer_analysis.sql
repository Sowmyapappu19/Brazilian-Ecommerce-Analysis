USE ecommereproject;

-- How many unique customers are there in the dataset --
SELECT COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM olist_customers_dataset;

-- Count number of unique customers per state --
SELECT COUNT(DISTINCT customer_unique_id) AS unique_customers , 
       customer_state AS state
FROM olist_customers_dataset 
GROUP BY state
ORDER BY unique_customers DESC;

-- Calculate the average order value(money) per customer --
SELECT c.customer_unique_id, 
       SUM(oi.price) / COUNT(DISTINCT o.order_id) AS avg_order_value
FROM olist_orders_dataset o JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
ORDER BY avg_order_value DESC;

-- How many unique cities contribute to Olist’s customer base --
SELECT COUNT(DISTINCT customer_city) AS unique_cities 
FROM olist_customers_dataset;

-- Which states use credit card payments the most, and how frequently are they used --
SELECT c.customer_state, 
	   p.payment_type, 
       COUNT(*) AS credit_card_usage
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
WHERE p.payment_type = 'credit_card'
GROUP BY c.customer_state, p.payment_type
ORDER BY credit_card_usage DESC;

-- Which states have the highest customer base, and how much revenue do they generate --
SELECT c.customer_state, 
       COUNT(DISTINCT c.customer_unique_id) AS customer_count,
       ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM olist_customers_dataset c
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_revenue DESC;

-- Which states contribute the most revenue in each year --
SELECT c.customer_state, 
       YEAR(o.order_purchase_timestamp) AS year,
       ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM olist_customers_dataset c
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state, YEAR(o.order_purchase_timestamp)
ORDER BY total_revenue DESC;

-- Which customer placed the most orders --
SELECT c.customer_unique_id, COUNT(o.order_id) AS total_orders
FROM olist_customers_dataset c
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_orders DESC
LIMIT 1;
