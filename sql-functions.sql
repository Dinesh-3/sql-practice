
-- CAST MYSQL Function for casting Type CAST("2017-08-29" AS DATE)

USE tutor_app;

UPDATE student
	SET first_name = 'DInesh',
		  updated_at = CAST(NOW() AS DATETIME)
	WHERE id = 1;