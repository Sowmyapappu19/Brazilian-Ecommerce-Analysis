-- Which product categories are the most popular (by order count) --
SELECT p.product_category_name AS category,
       COUNT(DISTINCT oi.order_id) AS order_count
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p ON oi.product_id = p.product_id
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY order_count DESC;

-- Which categories generate the highest total revenue --
SELECT p.product_category_name AS category,
       ROUND(SUM(py.payment_value), 2) AS total_revenue
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p ON oi.product_id = p.product_id
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
JOIN olist_order_payments_dataset py ON oi.order_id = py.order_id
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 5;

-- What is the average price and freight value per category --
SELECT p.product_category_name AS category,
       ROUND(AVG(oi.price), 2) AS avg_price,
       ROUND(AVG(oi.freight_value), 2) AS avg_freight_value
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
JOIN olist_products_dataset p ON oi.product_id = p.product_id
GROUP BY category
ORDER BY avg_price, avg_freight_value DESC;

-- How many unique product categories are there --
SELECT COUNT(DISTINCT product_id) AS unique_products 
FROM olist_products_dataset;

-- What are the Top 10 best-selling products --
SELECT  COUNT(DISTINCT oi.order_id) AS order_count,
        p.product_id,
        p.product_category_name AS category
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p ON oi.product_id = p.product_id
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
WHERE order_status = 'delivered'
GROUP BY p.product_id , category
ORDER BY order_count DESC
LIMIT 10;

-- Which product categories are most popular in each state --
SELECT COUNT(DISTINCT oi.order_id) AS order_count,
	   c.customer_state,
       p.product_category_name AS category
FROM olist_customers_dataset c
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_products_dataset p ON oi.product_id = p.product_id
GROUP BY c.customer_state, category
ORDER BY order_count DESC;

-- Which products have the widest price range (max – min price) --
SELECT p.product_id,
       p.product_category_name AS category,
       (MAX(oi.price) - MIN(oi.price)) AS price_range
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
JOIN olist_products_dataset p ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_id, category
ORDER BY price_range DESC
LIMIT 20;


       