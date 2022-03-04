-- VIEW is a virtual table based on the result-set of an SQL statement

USE sql_store;
DROP VIEW IF EXISTS get_order_items;
CREATE VIEW get_order_items AS 
	SELECT *, quantity * unit_price AS total_price FROM order_items;