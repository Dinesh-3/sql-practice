
-- CAST MYSQL Function for casting Type CAST("2017-08-29" AS DATE)

USE sql_store;

-- Two ways to declare variable
SET @first_name = "Dinesh"
SELECT @last_name := "I"
SELECT @first_name, @last_name -- To display

-- IF(condition, value_when_true, value_when_false)
SELECT *, IF(shipped_date, shipped_date, "Not Assigned") FROM orders; 
select COALESCE(null, "Dinesh"); -- returns first non null value

-- DATE FUNCTIONS ---

SELECT now(), curdate(), curtime()

-- '2021', '11', '15', '15', '5', '23', 'Monday', 'November'
SELECT year(now()), month(now()), day(now()), hour(now()), minute(now()), second(now()), dayname(now()), monthname(now());

UPDATE student
	SET first_name = 'Dinesh',
		  updated_at = CAST(NOW() AS DATETIME) -- DATE, TIME, YEAR, TIMESTAMP
	WHERE id = 1;

SELECT current_date;

SELECT extract(day from now()),extract(month from date'2017-1-1'),extract(year from date'2017-1-1');


SELECT date_format(now(), "%D %d - %M %m - %Y");
SELECT time_format(now(), "%H:%i %p");

SELECT date_add(now(), interval 1 day) -- return tomorrow date with exact time
SELECT date_add(now(), interval -1 day)
SELECT date_add(now(), interval 1 year)
SELECT date_sub(now(), interval 1 year)
SELECT datediff('2020-01-02 12:00', '2020-01-01 18:00')

SELECT time_to_sec("0:02") -- 120 seconds

--- STRING FUNCTIONS ---

SELECT length("Dinesh"); -- Return Length of the string

SELECT ltrim("           Dinesh      ") -- Remove emtpy space from left side
SELECT rtrim("           Dinesh      ") -- Remove emtpy space from right side
SELECT trim("           Dinesh      ") -- Remove emtpy space from both side

SELECT concat(' Hello, ', 'my name is ', @first_name , " ", @last_name);

SELECT upper("dinesh i");
SELECT lower("dinesh i");
SELECT initcap("dinesh i");

SELECT replace("dinesh", "nes", "&&&") -- di&&&h
SELECT STUFF("dinesh", 1, 2, "@") -- Not support in Mysql equalent INSERT
SELECT INSERT("dinesh", 1, 2, "@") -- @nesh , 1 to 2 inclusive

SELECT left("dinesh", 3) -- din
SELECT right("dinesh", 3) -- esh
SELECT substring("dinesh", 2) -- inesh
SELECT substring("dinesh", 2, 3) -- ine substring(word, startPosition, howMuchCharactor)

SELECT locate("n", "dinesh") -- 3 not case sensitive, locate("f") return 0 if not found

--- NUMBERIC OPERATIONS ---

SELECT round(5.4),round(5.5),round(5.6);
SELECT round(5.7367, 2) -- 5.74 return number with 2 decimal points with rounding
SELECT truncate(5.7367, 2); -- 5.73 return number with 2 decimal points without rounding numeber
SELECT ceil(5.4),ceil(5.5),ceil(6);
SELECT floor(5.4),floor(5.5),floor(5.7),floor(6);

SELECT abs(-22),abs(22);
SELECT rand(); -- To generate Random number
SELECT rand() * 10;

-- sign takes a number as its argument and returns -1 if the number is negative, 
-- 0 if the number is 0, and 1 if the number is positive.
SELECT sign(-5),sign(0),sign(5);

SELECT mod(5, 2); -- Returns Modulo of number or remainder of number mod(number,divisor)

select greatest(1,2,3,5,6); -- MAX value
select least(1,2,3,5,6); -- MIN value

-- CONDITIONAL FUNCTIONS
select if(Id is null, 0, id) as Id; -- equalent to select id = id == null ? 0 : id;

USE sql_store;
SELECT IFNULL(`phone`, 'N/A') FROM `customers`
