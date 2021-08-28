USE `sql_store`;
DROP procedure IF EXISTS `get_customers`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_customers`()
BEGIN
	SELECT * FROM customers;
END
DELIMITER ;

-- PASSING PARAMETERS

USE `sql_store`;
DROP procedure IF EXISTS `get_customers_by_name`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_customers_by_name`(name VARCHAR(50))
BEGIN
	SELECT * FROM customers
		WHERE first_name REGEXP(name) OR last_name REGEXP(name);
END
DELIMITER ;