-- What is the average review score for each product category --
SELECT p.product_category_name AS product_name,
       ROUND(AVG(r.review_score), 2) AS avg_review_score,
       COUNT(*) AS total_reviews
FROM olist_order_reviews_dataset r
JOIN olist_orders_dataset o   ON r.order_id = o.order_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_products_dataset p ON oi.product_id = p.product_id
GROUP BY product_name
ORDER BY avg_review_score DESC;

-- Do late deliveries lead to lower ratings --
SELECT 
    CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Late Delivery'
        ELSE 'On-Time Delivery'
    END AS delivery_status,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(*) AS total_reviews
FROM olist_order_reviews_dataset r
JOIN olist_orders_dataset o ON r.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY delivery_status;

-- What is the average review score across all orders --
SELECT ROUND(AVG(review_score), 2) AS avg_review_score
FROM olist_order_reviews_dataset;

-- How many 5-star & 1-star reviews are there? --
SELECT review_score,
       COUNT(*) AS review_count
FROM olist_order_reviews_dataset
WHERE review_score IN (1, 5)
GROUP BY review_score;

-- Which product categories receive the highest average review scores --
SELECT p.product_category_name,
       ROUND(AVG(r.review_score), 2) AS avg_review_score,
       COUNT(*) AS total_reviews
FROM olist_order_reviews_dataset r
JOIN olist_orders_dataset o   ON r.order_id = o.order_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_products_dataset p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY avg_review_score DESC
LIMIT 10;



