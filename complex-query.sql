
-- nested sub query example  

-- Find third max amount in payments table
USE sql_invoicing;

SELECT MAX(amount) FROM payments
WHERE amount < (
	SELECT MAX(amount) FROM payments
		WHERE amount NOT IN(
			SELECT MAX(amount) FROM payments
		)
)
;

SELECT * FROM payments -- same result as above
ORDER BY amount DESC
LIMIT 2,1; -- index start from 0, to 2 then select 1 record

-- select invoice larger than all invoices of client 3
USE sql_invoicing;
SELECT * FROM invoices
WHERE invoice_total > ALL (
SELECT MAX(invoice_total) FROM invoices
WHERE client_id = 3
);

-- Above question using ALL keyword
-- If sub query returns more than one result comparison not work so we need to add ALL or ANY
SELECT * FROM invoices
WHERE invoice_total > ALL ( -- It's look like ALL (1761, 232) Also we have ANY
  SELECT invoice_total FROM invoices -- if we add more than one column in SELECT, it will throw -> Operand should contain 1 column(s)
  WHERE client_id = 3
);

-- Select All clients who's having atleast given invoices
USE sql_invoicing;
SELECT * FROM clients
WHERE client_id IN ( -- IN or = ANY (Both same)
	SELECT client_id FROM invoices
    GROUP BY client_id
    HAVING COUNT(*) >= 2
);

-- Get employees who's salary is above the average in their office
-- Correlated sub queries will execute every record in parent (carefull leads to performance issue)

USE sql_hr;
SELECT * FROM employees e
WHERE salary > (
	SELECT avg(salary) 
    FROM employees
    WHERE office_id = e.office_id
);

-- Employees who's salary creator than average salary
USE sql_hr;
SELECT * FROM employees
WHERE salary > (
	SELECT avg(salary)
    -- as salary -- optional
    FROM employees
);

-- Get never ordered product
USE sql_store;

SELECT * FROM products
WHERE product_id NOT IN(
SELECT DISTINCT product_id -- To get distinct product id
    FROM order_items
);

SELECT * FROM products -- Approach 2
LEFT JOIN order_items USING(product_id)
WHERE order_id IS NULL
-- END

-- select invoices that are larger than 
-- that client's average invoice total using correlated subquery
USE sql_invoicing;

SELECT * FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
	FROM invoices
    WHERE client_id = i.client_id
)


-- get clients who's have an invoice
USE sql_invoicing;
SELECT * FROM clients c
WHERE client_id IN ( -- efficient
	SELECT DISTINCT client_id FROM invoices
);

USE sql_invoicing;
SELECT * FROM clients c
WHERE client_id IN ( -- less efficient
	SELECT DISTINCT client_id FROM invoices
    WHERE c.client_id = client_id
);

USE sql_invoicing;
SELECT * FROM clients c
WHERE EXISTS ( -- more efficient than above it doesn't return actual result it return boolean
	SELECT client_id FROM invoices -- * also works
    WHERE c.client_id = client_id
);

-- END --
-- Get All unOrdered Products
USE sql_store;

SELECT * FROM products p
WHERE NOT EXISTS(
	SELECT DISTINCT product_id -- To get distinct product id
	FROM order_items
    WHERE p.product_id = product_id
);

-- SELECT * FROM products -- Approach two Not works
-- WHERE EXISTS(
-- 	SELECT * FROM orders
--     JOIN order_items USING(order_id)

-- )

-- END --

-- Get invoice total difference from average invoice total 
USE sql_invoicing;

SELECT invoice_id, 
  invoice_total, 
  (
    SELECT AVG(invoice_total) FROM invoices
  ) AS average_total,
  invoice_total - ( SELECT average_total ) AS difference -- For Alias names, SELECT need to be added

FROM invoices;

-- END --

USE sql_invoicing;

-- get user total spend on invoice (sum of invoice for each user) 
-- with difference between sum of invoice and invoices total average

-- approach 1 using join
SELECT  c.name,
		c.client_id,
    SUM(invoice_total),
    (SELECT AVG(invoice_total) FROM invoices) AS average,
    SUM(invoice_total) - (SELECT average) AS difference
	
FROM invoices
RIGHT JOIN clients c 
	USING(client_id)
GROUP BY client_id;

-- approach 2 using subquery
USE sql_invoicing;

SELECT c.client_id,
		c.name,
    (SELECT SUM(invoice_total) FROM invoices i WHERE c.client_id = client_id) AS invoice_total,
    (SELECT AVG(invoice_total) FROM invoices) AS average,
    (SELECT invoice_total - average) AS difference

FROM clients c;

-- END --
-- sub query in FROM clause

USE sql_invoicing;

SELECT * 

FROM (
	SELECT c.client_id,
		c.name,
        (SELECT SUM(invoice_total) FROM invoices i WHERE c.client_id = client_id) AS invoice_total,
        (SELECT AVG(invoice_total) FROM invoices) AS average,
        (SELECT invoice_total - average) AS difference
	FROM clients c
) AS sales_summary

WHERE invoice_total IS NOT NULL
;

USE sql_invoicing;

SELECT SUM(total_sales) FROM (
SELECT  
  SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients c USING (client_id)
GROUP BY state
) AS sales

-- calculating total with rollup
SELECT  
  state,
  SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients c USING (client_id)
GROUP BY state WITH ROLLUP;

-- END --
