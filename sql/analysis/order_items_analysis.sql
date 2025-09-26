-- What are the unique order items in the dataset --
SELECT DISTINCT 
        p.product_category_name AS product_name,
		oi.product_id
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p ON oi.product_id = p.product_id
ORDER BY product_name;

-- Which item/product is most popular and ordered most frequently -- 
SELECT p.product_category_name AS product_name,
       oi.product_id, 
       COUNT(oi.order_id) AS order_count
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p ON oi.product_id = p.product_id
GROUP BY oi.product_id
ORDER BY order_count DESC
LIMIT 1;

-- Which product has the highest average review score -- 
SELECT ROUND(AVG(r.review_score), 2) AS avg_review_score,
       oi.product_id,
       p.product_category_name AS product_name
FROM olist_order_reviews_dataset r
JOIN olist_order_items_dataset oi ON r.order_id = oi.order_id
JOIN olist_products_dataset p ON oi.product_id = p.product_id
GROUP BY  oi.product_id , product_name
ORDER BY avg_review_score DESC;

-- Which products are ordered most frequently in each state --
SELECT c.customer_state,
       oi.product_id,
       COUNT(o.order_id) AS order_count
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
GROUP BY c.customer_state, oi.product_id
ORDER BY order_count DESC;

--  What is the trend of items sold per month/year --
SELECT YEAR(o.order_purchase_timestamp) AS year,
       MONTH(o.order_purchase_timestamp) AS month,
       COUNT(oi.order_item_id) AS items_sold
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
GROUP BY year, month
ORDER BY items_sold DESC;
