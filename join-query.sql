-- Multiple Join Query
-- Default INNER JOIN
USE sql_store;
  SELECT * FROM order_items oi
JOIN orders o
ON o.order_id = oi.order_id
JOIN customers c
USING(customer_id)
WHERE oi.product_id = product_id;