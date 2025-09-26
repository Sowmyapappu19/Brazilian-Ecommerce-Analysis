-- What is the average number of installments per payment type --
SELECT p.payment_type,
       ROUND(AVG(p.payment_installments), 2) AS avg_installments,
       COUNT(*) AS payment_count
FROM olist_order_payments_dataset p
GROUP BY p.payment_type
ORDER BY avg_installments DESC;

-- Which payment type generates the highest revenue --
SELECT p.payment_type,
       ROUND(SUM(p.payment_value), 2) AS total_revenue,
       COUNT(*) AS payment_count
FROM olist_order_payments_dataset p
GROUP BY p.payment_type
ORDER BY total_revenue DESC;

-- what is the distribution of payment types used -- 
SELECT payment_type, COUNT(payment_type) As total_payments
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_payments DESC;
                                   
-- which payment method has the highest transaction value --
SELECT payment_type, SUM(payment_value) AS total_transaction
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transaction DESC;

-- what is the average number of payment installments per order --
SELECT  SUM(payment_installments)/ COUNT(DISTINCT order_id) AS average
FROM olist_order_payments_dataset;
