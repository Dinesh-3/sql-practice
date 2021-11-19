-- Updating a record
USE sql_hr;

UPDATE  employees
	SET first_name = 'South'
	WHERE employee_id = 67009;

-- SubQuery In Update Statement
USE sql_invoicing;

UPDATE invoices
SET 
  payment_total = invoice_total * 0.5,
  payment_date = due_date
WHERE client_id IN (
  SELECT client_id
    FROM clients
    WHERE state IN ('CA', 'NY')
)

-- Update Comment to Gold Customer where customer have more than 3000 points
USE sql_store;
UPDATE orders
	SET comments = 'Gold Customer'
WHERE customer_id IN (
  SELECT customer_id FROM customers
  WHERE points > 3000
);

-- MERGE With previous table
USE sql_store;
UPDATE products
SET quantity_in_stock = quantity_in_stock + 5
WHERE product_id = 1;
