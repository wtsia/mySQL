/*
Continue with creating database functions.
1. Write a database function that will take a student_id as input and then return the Max(score) for the student.
2. Write a database function that takes student_id as input and then returns the Avg(score) for the student.
3. Write a database function that takes student_id as input and then returns Sum(score) for the student.
4. Write a database function that takes student_id as input then goes and find out the Maximum event_id that this student has. Once we have this event_id found then go and return the Category of this student belong to from grade_event.

Run all these database functions, capture the outputs as screenshot and submit the source code of the functions you have written including the screenshot.
*/
DELIMITER //
CREATE FUNCTION GetMaxScore(student_id INT) RETURNS INT
BEGIN
    DECLARE max_score INT;
    SELECT MAX(SCORE) INTO max_score FROM SCORE WHERE STUDENT_ID = student_id;
    RETURN max_score;
END //

CREATE FUNCTION GetAvgScore(student_id INT) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE avg_score DECIMAL(10,2);
    SELECT AVG(score) INTO avg_score FROM SCORE WHERE STUDENT_ID = student_id;
    RETURN avg_score;
END //

CREATE FUNCTION GetSumOfScore(student_id INT) RETURNS INT
BEGIN
    DECLARE sum_scores INT;
    SELECT SUM(score) INTO sum_scores FROM SCORE WHERE STUDENT_ID = student_id;
    RETURN sum_scores;
END //

CREATE FUNCTION GetMaxEventID(student_id INT) RETURNS VARCHAR(50)
BEGIN
    DECLARE max_event_id INT;
    DECLARE category_out VARCHAR(50);
    SELECT MAX(event_id) INTO max_event_id FROM SCORE WHERE STUDENT_ID = student_id;
    SELECT CATEGORY INTO category_out FROM GRADE_EVENT WHERE EVENT_ID = max_event_id;
    RETURN category_out;
END //
DELIMITER ;

/*
mysql> SELECT GetMaxScore(1);
+----------------+
| GetMaxScore(1) |
+----------------+
|            100 |
+----------------+
1 row in set (0.01 sec)

mysql> SELECT GetAvgScore(1);
+----------------+
| GetAvgScore(1) |
+----------------+
|          36.90 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT GetSumOfScore(1);
+------------------+
| GetSumOfScore(1) |
+------------------+
|             6458 |
+------------------+
1 row in set (0.00 sec)

mysql> SELECT GetMaxEventID(1);
+------------------+
| GetMaxEventID(1) |
+------------------+
| Q                |
+------------------+
1 row in set (0.00 sec)
*/
