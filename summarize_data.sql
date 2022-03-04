
USE sql_invoicing;

SELECT 
	AVG(invoice_total) AS average_sale,
  MAX(invoice_total) AS max_invoice_sale,
  MIN(invoice_total) AS min_invoice_sale,
  SUM(invoice_total * 1) AS invoice_total,
  COUNT(*) AS total_invoices,
  COUNT(DISTINCT client_id) AS total_invoice_clients,
  VARIANCE(invoice_total) AS variance
FROM invoices
;

-- END --

-- Second Max
USE sql_hr;

-- SELECT * FROM employees
-- ORDER BY salary DESC
-- LIMIT 4,2;

SELECT max(salary) from employees
where salary NOT IN (
SELECT max(salary) from employees
);

-- END --
-- OPERATORS UNION, INTERSECT, MINUS (take left side rows minused from right side query)

USE sql_invoicing;

SELECT 
	'first half of 2019' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices

WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'

UNION

SELECT 
	'second half of 2019' AS date_range, -- AS date_range optinal, Both query must have same length of column
	SUM(invoice_total) AS total_sales,
  SUM(payment_total) AS total_payments,
  SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices

WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'

UNION

SELECT 
	'total' AS date_range,
	SUM(invoice_total) AS total_sales,
  SUM(payment_total) AS total_payments,
  SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices

WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31'

-- END --
-- payment method and date combination
USE sql_invoicing;

SELECT 
	date,
	pm.name AS payment_method,
	SUM(amount) AS total_payments
FROM payments p

JOIN payment_methods pm ON p.payment_method = pm.payment_method_id

GROUP BY date, payment_method
-- END --

USE sql_invoicing;

SELECT  
	client_id,
  SUM(invoice_total) AS total
FROM invoices
-- WHERE is used before groubing
GROUP BY client_id

HAVING total > 500 -- having is used filtering after grouped value, we can add one or more condition
-- column we are using HAVING must be added select clause
-- END --

-- Get customers located in VA state who have spent more than 100
USE sql_store;

SELECT
	c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o USING(customer_id)
JOIN order_items oi USING(order_id)
WHERE state = 'VA'

GROUP BY
	c.customer_id,
    c.first_name,
    c.last_name
HAVING total_sales > 100
-- SHOW WARNINGS;

-- END --

-- ROLE UP only in mysql 

USE sql_invoicing;

SELECT  
	client_id,
  state,
  city,
  SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients c USING (client_id)
GROUP BY state, city WITH ROLLUP

-- END --

USE sql_invoicing;

SELECT 
	pm.name AS payment_method,
  SUM(amount) AS total
FROM payments p
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method
GROUP BY pm.name WITH ROLLUP -- we can't use alias while using ROLLUP

-- END --
