USE sql_store;
DROP VIEW IF EXISTS get_order_items;
CREATE VIEW get_order_items AS 
	SELECT *, quantity * unit_price AS total_price FROM order_items;