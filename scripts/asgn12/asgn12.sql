DELIMITER $$
DROP PROCEDURE IF EXISTS get_max_score$$
DROP PROCEDURE IF EXISTS get_avg_score$$
DROP PROCEDURE IF EXISTS get_avg_score$$
DROP PROCEDURE IF EXISTS get_student_category$$


CREATE PROCEDURE get_max_score(IN student_id INT, OUT max_score INT)
BEGIN
    SELECT MAX(SCORE) INTO max_score FROM score WHERE STUDENT_ID = student_id;
END$$

CREATE PROCEDURE get_avg_score(IN student_id INT, OUT avg_score FLOAT)
BEGIN
    SELECT AVG(SCORE) INTO avg_score FROM score WHERE STUDENT_ID = student_id;
END$$

CREATE PROCEDURE get_sum_score(IN student_id INT, OUT sum_score INT)
BEGIN
    SELECT SUM(SCORE) INTO sum_score FROM score WHERE STUDENT_ID = student_id;
END$$

CREATE PROCEDURE get_student_category(IN student_id INT, OUT student_category enum('T','Q'))
BEGIN
    SELECT MAX(EVENT_ID) INTO @max_event_id FROM score WHERE STUDENT_ID = student_id;
    SELECT CATEGORY INTO student_category FROM grade_event WHERE EVENT_ID = @max_event_id;
END$$
DELIMITER ;

/*
****FUNCTION****
CALL get_max_score(1, @max_score);
SELECT @max_score;
****TEST****
SELECT MAX(SCORE) FROM score WHERE STUDENT_ID = 1;

****FUNCTION****
CALL get_avg_score(1, @avg_score);
SELECT @avg_score;
****TEST****
SELECT AVG(SCORE) FROM score WHERE STUDENT_ID = 1;

****FUNCTION****
CALL get_sum_score(1, @sum_score);
SELECT @sum_score;
****TEST****
SELECT SUM(SCORE) FROM score WHERE STUDENT_ID = 1;

****FUNCTION****
CALL get_student_category(1, @student_category);
SELECT @student_category;
*/
