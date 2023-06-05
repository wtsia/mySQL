use studentdb;
/*
1. Write a SELECT statement to show student_id and scores (count) of scores does each student has. Sort the results in descending order. Also, rename the column from count to show scores_count.

EX:
student_id	scores_count
1	5
2	4
*/
SELECT STUDENT_ID, COUNT(*) AS scores_count
FROM SCORE
GROUP BY STUDENT_ID
ORDER BY scores_count DESC;

/*
2. Write a select to show all the student_id and count of scores that these students has. Show the results only for student_id of "4" .

EX:
student_id	scores_count
13	4
27	4
*/
SELECT STUDENT_ID, COUNT(*) AS scores_count
FROM SCORE
GROUP BY STUDENT_ID
HAVING scores_count = 4;

/*
3. Write a select to show all the student_id and count of scores that these students has. Show the results only for student_id of "5" .

Please see the expected output below. I am not showing entire output, this is just an example.

student_id	scores_count
1	5
2	5
4	5
*/
SELECT STUDENT_ID, COUNT(*) AS scores_count
FROM SCORE
GROUP BY STUDENT_ID
HAVING COUNT(*) = 5;

/*
4. Write a select to show all the student_id and count of scores that these students has. Show the results only for student_id of "6" .

student_id	scores_count
3	6
5	6
6	6
*/
SELECT STUDENT_ID, COUNT(*) AS scores_count
FROM SCORE
GROUP BY STUDENT_ID
HAVING COUNT(*) = 6;


/*
5. Write a select to show all the student_id and count of scores that these students has. Show the results only for student_id of "5" .

student_id	scores_count
1	5
2	5
4	5
*/
SELECT STUDENT_ID, COUNT(*) AS scores_count
FROM SCORE
GROUP BY STUDENT_ID
HAVING COUNT(*) = 5;

/*
6. Write a select query to show the student_id and maximum score that the student_id has received.
*/
SELECT STUDENT_ID, MAX(SCORE) AS max_score
FROM SCORE
GROUP BY STUDENT_ID;

/*
7. Write a select query to show the student_id and minimum score that the student_id has received.
*/
SELECT STUDENT_ID, MIN(SCORE) AS max_score
FROM SCORE
GROUP BY STUDENT_ID;

/*
8. Write a Sub Query using IN clause to show all the all the events that are present in the grade_event table are also present in the Score table.
*/
SELECT EVENT_ID
FROM GRADE_EVENT
WHERE EVENT_ID IN (SELECT DISTINCT EVENT_ID FROM SCORE);

/*
9. Write a Sub Query using EXISTS clause to show all the all the events that are present in the grade_event table are also present in the Score table.
*/
SELECT EVENT_ID
FROM GRADE_EVENT ge
WHERE EXISTS (
    SELECT 1
    FROM SCORE sc
    WHERE sc.EVENT_ID = ge.EVENT_ID
);


/*
10. Create a backup table for student table as student_backup. Insert a new student into the student_backup table. Write a sub query to find out all the students that are not present  in the score table. Write this subquery using both NOT IN and NOT EXISTS clause.
*/

-- Create backup table STUDENT_BACKUP
CREATE TABLE STUDENT_BACKUP LIKE STUDENT;

-- Insert new student into student_backup
INSERT INTO STUDENT_BACKUP SELECT * FROM STUDENT WHERE STUDENT_ID = 'NEW_STUDENT_ID';

SELECT * FROM STUDENT
WHERE STUDENT_ID NOT IN (SELECT DISTINCT STUDENT_ID FROM SCORE);
