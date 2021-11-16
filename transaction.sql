-- Transaction is a group of SQL statement that represents single of work
-- All statement need to successful or failed together with rollback mechanism
-- ACID Properties
-- Atomity, Consistency, Isolation, Durability

-- Concurrency Issues
-- Lost Update, Dirty Reads -> We can able to uncommitted data, Repedable Reads, Phantom reads

USE sql_store;

START TRANSACTION; -- start a new transaction

INSERT INTO `orders` VALUES (DEFAULT,6,'2019-01-30',1,"New Order",NULL,NULL);

-- ROLLBACK -- Rollback the transaction on failer

INSERT INTO `order_items` VALUES (DEFAULT,4,4,3.74);

COMMIT; -- Commit the transaction


-- ISOLATION LEVELS

SHOW VARIABLES LIKE 'transaction_isolation';

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; -- Set isolation level for next transaction

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE; -- Set isolation level for current session connection 

SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE; -- Set isolation level for all or global session connection 


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; -- Dirty Read able to see data's that not uncommited 


-- EXPERIMENT READ UNCOMMITTED;
-- Session 1
USE sql_store;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT points FROM customers WHERE customer_id = 1;

-- Session 2

USE sql_store;

START TRANSACTION;

UPDATE customers SET points = 20 WHERE customer_id = 1; -- Stop on this line and run Session 1

COMMIT;

-- EXPERIMENT READ COMMITTED;
-- Session 1
USE sql_store;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT points FROM customers WHERE customer_id = 1; -- Step 2, Step 5

-- Session 2

USE sql_store;

START TRANSACTION;

UPDATE customers SET points = 20 WHERE customer_id = 1; -- Step 1

COMMIT; -- Step 3, Step 4

-- EXPERIMENT REPEATABLE READ;
-- Session 1
USE sql_store;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

SELECT points FROM customers WHERE customer_id = 1; -- Step 1
SELECT points FROM customers WHERE customer_id = 1; -- Step 3

-- Session 2

USE sql_store;

START TRANSACTION;

UPDATE customers SET points = 20 WHERE customer_id = 1; 

COMMIT; -- Step 2

-- EXPERIMENT SERIALIZABLE;
-- Session 1
USE sql_store;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

START TRANSACTION; -- Step 1
SELECT * FROM customers WHERE state = 'VA'; -- Step 4
COMMIT;

-- Session 2

USE sql_store;

START TRANSACTION; -- Step 2

UPDATE customers SET state = 'VA' WHERE customer_id = 3; -- Step 3

COMMIT; -- Step 5

-- EXPERIMENT DEAD LOCK;
-- Session 1
USE sql_store;

START TRANSACTION; -- Step 1
UPDATE customers SET state = 'VA' WHERE customer_id = 1; -- Step 2
UPDATE orders SET status = 1 WHERE order_id = 1;
COMMIT;

-- Session 2

USE sql_store;

START TRANSACTION; -- Step 3
UPDATE orders SET status = 1 WHERE order_id = 1; -- Step 4
UPDATE customers SET state = 'VA' WHERE customer_id = 1; -- Step 5
COMMIT;
