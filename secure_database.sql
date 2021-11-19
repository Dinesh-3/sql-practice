CREATE USER dinesh@127.0.0.1 IDENTIFIED BY 'mypassword'
-- CREATE USER dinesh@'%.dinesh.com'
SELECT * FROM mysql.user; -- To list all the user

DROP USER bob@dinesh.com;

-- Update password
SET PASSWORD FOR dinesh = 'newpassword';
SET PASSWORD = 'newpassword'; -- change password for currently loggedin user


CREATE USER spring_boot_app IDENTIFIED BY "springboot"


GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE -- Includes stored procedure
ON sql_store.* -- all tables in sql store 
TO spring_boot_app -- privilege to this user

GRANT ALL 
ON *.* -- database.table
TO dinesh

SHOW GRANTS FOR spring_boot_app

SHOW GRANTS; -- for current user


GRANT CREATE VIEW
ON sql_store.*
TO spring_boot_app;

-- Revoke or remove privileges
REVOKE CREATE VIEW
ON sql_store.*
FROM spring_boot_app;