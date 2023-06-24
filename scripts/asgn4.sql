/*
1. Use "studentdb" database to write the following Queries
*/
use studentdb

/*
2. Display the count of all the rows in 3 tables STUDENT, SCORE, GRADE_EVENT
*/
SELECT COUNT(*) FROM STUDENT;
SELECT COUNT(*) FROM grade_event;
SELECT COUNT(*) FROM score;

/*
3. Insert a new student into STUDENT table and get a count from STUDENT table
*/
INSERT INTO STUDENT VALUES ('JOESCHMO', 'M', '12345666');

/*
4. Insert a score for the studentId created in Step(3) and use event_id=10. Were you able to create the score for this student?
If yes, then please attach a screenshot.
If Not, then what steps you will take to create the score successfully.
*/
INSERT INTO score VALUES (12345666, 10, 70); -- FAILED
/*
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`studentdb`.`score`, CONSTRAINT `score_ibfk_1` FOREIGN KEY (`EVENT_ID`) REFERENCES `grade_event` (`EVENT_ID`))

SOLUTION: Insert corresponding reference data to fulfill constaint condition
*/
INSERT INTO grade_event VALUES ('2012-10-02', 'Q', 10);
INSERT INTO score VALUES (12345666, 10, 70);

/*
5. Find out how many groups of Events are present in Score table. Show the count against each event.
*/
SELECT EVENT_ID, COUNT(*) FROM score GROUP BY EVENT_ID;

/*
6. Find out how many groups of students are present in Score table. Show the count against each student
*/
SELECT STUDENT_ID, COUNT(*) FROM score GROUP BY STUDENT_ID;

/*
7. Find out the student who has maximum score and minimum score from the score table. Include the student name in your report.
*/
SELECT 
  STUDENT.NAME, SCORE.SCORE 
  FROM STUDENT INNER JOIN SCORE 
  ON STUDENT.STUDENT_ID = SCORE.STUDENT_ID 
  WHERE SCORE.SCORE = (SELECT MIN(SCORE) FROM SCORE);
/*
+--------+-------+
| NAME   | SCORE |
+--------+-------+
| Joseph |     7 |
+--------+-------+
1 row in set (0.01 sec)
*/
SELECT 
  STUDENT.NAME, SCORE.SCORE 
  FROM STUDENT INNER JOIN SCORE 
  ON STUDENT.STUDENT_ID = SCORE.STUDENT_ID 
  WHERE SCORE.SCORE = (SELECT MAX(SCORE) FROM SCORE);
/*
+-------+-------+
| NAME  | SCORE |
+-------+-------+
| Megan |   100 |
+-------+-------+
1 row in set (0.00 sec)
*/

/*
8. Group the students by their studentid and eventid from score table to show their score and then filter out to show only data for eventid=3
*/
SELECT STUDENT_ID, EVENT_ID, SCORE
FROM SCORE
WHERE EVENT_ID = 3
GROUP BY STUDENT_ID, EVENT_ID;

/*
9. Query the data from event_grade table and sort the data based on category field
*/
SELECT * FROM GRADE_EVENT ORDER BY CATEGORY;

/*
10. Show the results from score table and sort by the the score field.

mysql> SELECT STUDENT_ID, EVENT_ID, SCORE
    -> FROM SCORE
    -> WHERE EVENT_ID = 3
    -> GROUP BY STUDENT_ID, EVENT_ID;
+------------+----------+-------+
| STUDENT_ID | EVENT_ID | SCORE |
+------------+----------+-------+
|          1 |        3 |    88 |
|          2 |        3 |    84 |
|          3 |        3 |    69 |
|          4 |        3 |    71 |
|          5 |        3 |    97 |
|          6 |        3 |    83 |
|          7 |        3 |    88 |
|          8 |        3 |    75 |
|          9 |        3 |    83 |
|         10 |        3 |    72 |
|         11 |        3 |    74 |
|         12 |        3 |    77 |
|         13 |        3 |    67 |
|         14 |        3 |    68 |
|         15 |        3 |    75 |
|         16 |        3 |    60 |
|         17 |        3 |    79 |
|         18 |        3 |    96 |
|         19 |        3 |    79 |
|         20 |        3 |    76 |
|         21 |        3 |    91 |
|         22 |        3 |    81 |
|         23 |        3 |    81 |
|         24 |        3 |    62 |
|         25 |        3 |    79 |
|         26 |        3 |    86 |
|         27 |        3 |    90 |
|         28 |        3 |    68 |
|         29 |        3 |    66 |
|         30 |        3 |    79 |
|         31 |        3 |    81 |
+------------+----------+-------+
31 rows in set (0.00 sec)
*/

