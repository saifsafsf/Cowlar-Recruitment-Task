SELECT product_id, 
       SUM(unit_price * quantity) AS total_revenue  -- revenue per product
FROM customer_dataset
GROUP BY product_id
ORDER BY total_revenue DESC;