SELECT customer_id, 
       SUM(quantity * unit_price) AS total_purchases  -- purchases per product
FROM customer_dataset
GROUP BY customer_id
ORDER BY total_purchases DESC
LIMIT 5;