-- Which sellers sold the most items --
SELECT s.seller_id,
       COUNT(oi.order_id) AS items_sold
FROM olist_sellers_dataset s
JOIN olist_order_items_dataset oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id
ORDER BY items_sold DESC;

-- How many unique products are sold by each seller --
SELECT s.seller_id,
       COUNT(DISTINCT oi.product_id) AS unique_products_sold
FROM olist_sellers_dataset s
JOIN olist_order_items_dataset oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id
ORDER BY unique_products_sold DESC;

-- List Top 5 sellers with the best average review score --
SELECT s.seller_id,
       ROUND(AVG(r.review_score), 2) AS avg_review_score,
       COUNT(r.review_id) AS total_reviews
FROM olist_sellers_dataset s
JOIN olist_order_items_dataset oi ON s.seller_id = oi.seller_id
JOIN olist_order_reviews_dataset r ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING COUNT(r.review_id) >= 5
ORDER BY avg_review_score DESC
LIMIT 5;

-- How many 1-star and 5-star reviews did each seller receive --
SELECT s.seller_id,
       SUM(CASE WHEN r.review_score = 1 THEN 1 ELSE 0 END) AS one_star_reviews,
       SUM(CASE WHEN r.review_score = 5 THEN 1 ELSE 0 END) AS five_star_reviews
FROM olist_sellers_dataset s
JOIN olist_order_items_dataset oi ON s.seller_id = oi.seller_id
JOIN olist_order_reviews_dataset r ON oi.order_id = r.order_id
GROUP BY s.seller_id
ORDER BY five_star_reviews DESC;

-- Which sellers have the widest geographic reach (number of unique states/cities served) --
SELECT s.seller_id, 
       COUNT(DISTINCT c.customer_state) AS unique_states,
       COUNT(DISTINCT c.customer_city) AS unique_cities
FROM olist_sellers_dataset s 
JOIN olist_order_items_dataset oi ON s.seller_id = oi.seller_id
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
GROUP BY s.seller_id
ORDER BY unique_states DESC, unique_cities DESC
LIMIT 10;

