DELIMITER $$

use studentdb;

/*
1. Write an SQL query to show the following columns by joining STUDENT, GRADE_EVENT, and SCORE tables.

The output of the query should display the following columns with the format shown below group by student_id.
STUDENT_ID | EVENT_ID | CATEGORY | SUM(SCORE) | AVG(SCORE) | MIN(SCORE) | MAX(SCORE)
*/

SELECT
    s.STUDENT_ID,
    sc.EVENT_ID,
    ge.CATEGORY,
    SUM(sc.SCORE) AS `SUM(SCORE)`,
    AVG(sc.SCORE) AS `AVG(SCORE)`,
    MIN(sc.SCORE) AS `MIN(SCORE)`,
    MAX(sc.SCORE) AS `MAX(SCORE)`
FROM
    STUDENT s
JOIN
    SCORE sc ON s.STUDENT_ID = sc.STUDENT_ID
JOIN
    GRADE_EVENT ge ON sc.EVENT_ID = ge.EVENT_ID
GROUP BY
    s.STUDENT_ID, sc.EVENT_ID, ge.CATEGORY;

/*
2. Develop a database function that takes "student_id" as an input parameter. The function should return the SUM of score for the given studentId.

SET GLOBAL log_bin_trust_function_creators = 1;
*/

-- DROP FUNCTION IF EXISTS GetSumScore;
DELIMITER $$
CREATE FUNCTION GetSumScore(STUDENTID INT) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE sumScore DECIMAL(10,2);

    SELECT SUM(SCORE) INTO sumScore
    FROM SCORE
    WHERE STUDENT_ID = STUDENTID;

    RETURN sumScore;
END $$
DELIMITER ;
/*
****CALL FUNCTION****
SELECT GetSumScore(1) AS sumScore;
+----------+
| sumScore |
+----------+
|   240.00 |
+----------+
1 row in set (0.00 sec)


3. Develop a database function that takes category as an input parameter. The function should return how many categories are present. 
*/

-- DROP FUNCTION IF EXISTS CountCategories;
DELIMITER $$
CREATE FUNCTION CountCategories(categories VARCHAR(50)) RETURNS INT
BEGIN
    DECLARE categoryCount INT;

    SELECT COUNT(categories) INTO categoryCount
    FROM GRADE_EVENT
    WHERE CATEGORY = categories;

    RETURN categoryCount;
END $$
DELIMITER ;
/*
****CALL FUNCTION****
SELECT CountCategories('Q') AS CategoryCount;
+---------------+
| CategoryCount |
+---------------+
|             4 |
+---------------+
1 row in set (0.00 sec)


4.  Use studentDB database and use GRADE_EVENT table to create a database trigger.
Create an Audit table for GRADE_EVENT table and include the following additional columns.
Add HISTORY_DATE (Timestamp), USER(VARCHAR), Operation(Varchar)

Create AFter Insert trigger on GRADE_EVENT table.

Verify the changes for Insert, Update and Delete operations on this table.

Take a screenshot of the output of the Audit table after verifying the trigger changes.
Include the source code of trigger  & screenshot of the output audit as part of assignment submission.

DROP TRIGGER IF EXISTS GradeEventAuditInsert;
*/
CREATE TABLE Audit (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    GRADE_EVENT_ID INT,
    HISTORY_DATE TIMESTAMP,
    USER VARCHAR(50),
    Operation VARCHAR(20)
);

DELIMITER $$

CREATE TRIGGER GradeEventAuditInsert
AFTER INSERT ON GRADE_EVENT
FOR EACH ROW
BEGIN
    INSERT INTO Audit (GRADE_EVENT_ID, HISTORY_DATE, USER, Operation)
    VALUES (NEW.EVENT_ID, NOW(), USER(), 'INSERT');
END $$

CREATE TRIGGER GradeEventAuditUpdate
AFTER UPDATE ON GRADE_EVENT
FOR EACH ROW
BEGIN
    INSERT INTO Audit (GRADE_EVENT_ID, HISTORY_DATE, USER, Operation)
    VALUES (NEW.EVENT_ID, NOW(), USER(), 'UPDATE');
END $$

CREATE TRIGGER GradeEventAuditDelete
AFTER DELETE ON GRADE_EVENT
FOR EACH ROW
BEGIN
    INSERT INTO Audit (GRADE_EVENT_ID, HISTORY_DATE, USER, Operation)
    VALUES (OLD.EVENT_ID, NOW(), USER(), 'DELETE');
END $$

DELIMITER ;

INSERT INTO GRADE_EVENT (DATE, CATEGORY, EVENT_ID ) VALUES ('2012-12-12', 'Q', 1337);

UPDATE GRADE_EVENT SET EVENT_ID = 1338 WHERE EVENT_ID = 1337;

DELETE FROM GRADE_EVENT WHERE EVENT_ID = 1338;


/*
5. Develop a database function that takes eventId and student_id as an input parameter. For the given eventId and student_id, find out of score.
*/

DELIMITER $$
CREATE FUNCTION GetScore(eventId INT, studentId INT) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE my_score DECIMAL(10,2);

    SELECT SCORE INTO my_score
    FROM SCORE
    WHERE EVENT_ID = eventId AND STUDENT_ID = studentId;

    RETURN my_score;
END$$
DELIMITER ;

/*
****CALL FUNCTION****
SELECT GetScore(1, 1) AS Score;
+-------+
| Score |
+-------+
| 20.00 |
+-------+
1 row in set (0.00 sec)
*/
