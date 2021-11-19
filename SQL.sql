SHOW VARIABLES;
LAST_INSERT_ID();

-- SQL Else If Example
-- To fix Error Code: 1418. This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA 
-- in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)

SET GLOBAL log_bin_trust_function_creators = 1; 

DELIMITER //

CREATE FUNCTION VerboseCompare (n INT, m INT)
  RETURNS VARCHAR(50)

  BEGIN
    DECLARE s VARCHAR(50);

    IF n = m THEN SET s = 'equals';
    ELSE
      IF n > m THEN SET s = 'greater';
      ELSE SET s = 'less';
      END IF;

      SET s = CONCAT('is ', s, ' than');
    END IF;

    SET s = CONCAT(n, ' ', s, ' ', m, '.');

    RETURN s;
  END //

DELIMITER ;

SELECT VerboseCompare(5,4);

-- CREATE AND EXECUTE DYNAMIC QUERY
USE sql_store;

DELIMITER $$
DECLARE
@first_name NVARCHAR(128),
@sql_statement NVARCHAR(MAX);
SET @table_nam = N'customers';
SET @first_name = N'Ines';
SET @sql_statement = N'SELECT * FROM ' + @table_nam + ' WHERE first_name LIKE %' + @first_name + '%';
EXEC sp_executesql @sql_statement;
DELIMITER $$
