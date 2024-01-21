SELECT product_id, SUM(unit_price * quantity) AS total_revenue
FROM customer_dataset
GROUP BY product_id
ORDER BY total_revenue DESC;