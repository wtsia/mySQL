/*
1. Use studentdb database for this assignment.
2. Create a database function that takes student_id as input and return the maximum score for this student. Use SCORE table for this question.
*/
use studentdb;

DELIMITER //
CREATE FUNCTION GetMaxScore(student_id INT) RETURNS INT
BEGIN
    DECLARE max_score INT;
    SELECT MAX(SCORE) INTO max_score FROM SCORE WHERE STUDENT_ID = student_id;
    RETURN max_score;
END //

/*
3. Create a database function to that takes event_id as input and returns the category. Use GRADE_EVENT table for this question.
*/

-- DROP FUNCTION IF EXISTS GetCategory;
-- DELIMITER //
CREATE FUNCTION GetCategory(event_id_IN INT) RETURNS enum('T', 'Q')
BEGIN
    DECLARE categoryRes enum('T', 'Q');
    SELECT CATEGORY INTO categoryRes FROM GRADE_EVENT WHERE EVENT_ID = event_id_IN;
    RETURN categoryRes;
END //
DELIMITER ;


/*
mysql> SELECT GetMaxScore(1);
+----------------+
| GetMaxScore(1) |
+----------------+
|            100 |
+----------------+
1 row in set (0.02 sec)


mysql> SELECT GetCategory(1);
+----------------+
| GetCategory(1) |
+----------------+
| Q              |
+----------------+
1 row in set (0.00 sec)
*/
