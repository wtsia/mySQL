/*
1. Write an SQL query to show the following columns by joining STUDENT, GRADE_EVENT, and SCORE tables.

The output of the query should display the following columns with the format shown below group by student_id.
STUDENT_ID | EVENT_ID | CATEGORY | SUM(SCORE) | AVG(SCORE) | MIN(SCORE) | MAX(SCORE)
*/
use STUDENTDB;


/*
2. Develop a database function that takes "student_id" as an input parameter. The function should return the SUM of score for the given studentId.
*/
 
/*
3. Develop a database function that takes category as an input parameter. The function should return how many categories are present. 
*/
 
/*
4.  Use studentDB database and use GRADE_EVENT table to create a database trigger.
Create an Audit table for GRADE_EVENT table and include the following additional columns.
Add HISTORY_DATE (Timestamp), USER(VARCHAR), Operation(Varchar)
Create AFter Insert trigger on GRADE_EVENT table.
Verify the changes for Insert, Update and Delete operations on this table.
Take a screenshot of the output of the Audit table after verifying the trigger changes.
Include the source code of trigger  & screenshot of the output audit as part of assignment submission.
*/

/*
5. Develop a database function that takes eventId and student_id as an input parameter. For the given eventId and student_id, find out of score.
*/