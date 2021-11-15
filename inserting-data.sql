-- Copying record to other table
CREATE TABLE orders_archived
  AS SELECT * FROM orders;

-- Copies only the columns and contrains not the data
USE sql_store;
CREATE TABLE orders_archived
  LIKE orders;

-- Inserting record using Subquery
INSERT INTO orders_archived
  SELECT * FROM orders
    WHERE order_date < '2019-01-01';

-- Inserting multiple record
INSERT INTO orders_archived
  VALUES
  (1,6,'2019-01-30',1,NULL,NULL,NULL),
  (2,7,'2018-08-02',2,NULL,'2018-08-03',4),
  (3,8,'2017-12-01',1,NULL,NULL,NULL);