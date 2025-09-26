-- Which states/cities experience the highest delays in deliveries --
SELECT c.customer_state,
       c.customer_city,
       COUNT(*) AS delayed_orders
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date > o.order_estimated_delivery_date
GROUP BY c.customer_state, c.customer_city
ORDER BY delayed_orders DESC;

-- Which delivery carriers (sellers) fulfill the most orders, and what’s their average review score --
SELECT s.seller_id,
       COUNT(DISTINCT o.order_id) AS total_orders,
       ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_order_reviews_dataset r ON o.order_id = r.order_id
JOIN olist_sellers_dataset s ON oi.seller_id = s.seller_id
WHERE o.order_status ='delivered'
GROUP BY s.seller_id
ORDER BY total_orders DESC;

-- Which months/years have the highest number of purchases --
SELECT YEAR(order_purchase_timestamp) AS year,
       MONTH(order_purchase_timestamp) AS month,
       COUNT(order_id) AS purchases
FROM olist_orders_dataset
GROUP BY year, month
ORDER BY purchases DESC;

-- Which order statuses are most common per state --
SELECT c.customer_state,
       o.order_status,
       COUNT(*) AS status_count
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
GROUP BY c.customer_state, o.order_status
ORDER BY status_count DESC;

-- How many orders were placed each month --
SELECT MONTH(order_purchase_timestamp) AS month,
       YEAR(order_purchase_timestamp) AS year,
       COUNT(DISTINCT order_id) AS orders
FROM olist_orders_dataset
GROUP BY month,year 
ORDER BY month,year;

-- How many orders were delayed per year, and is there a trend --
SELECT YEAR (order_purchase_timestamp) AS year,
            COUNT(*) AS delayed_orders
FROM olist_orders_dataset 
WHERE order_status = 'delivered'
  AND order_delivered_customer_date > order_estimated_delivery_date
GROUP BY year
ORDER BY delayed_orders;

-- What is the order distribution across weekdays --
SELECT DAYNAME(order_purchase_timestamp) AS weekday,
       COUNT(order_id) AS order_count
FROM olist_orders_dataset
WHERE order_status = 'delivered'
GROUP BY weekday
ORDER BY order_count DESC;