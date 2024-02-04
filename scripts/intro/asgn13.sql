
--1. Use Studentdb database and use Student Table.
use studentdb;
--2. Make sure autocommit is turned OFF.
SET autocommit = 0;
--3. Insert a new student into student table.
INSERT INTO STUDENT (NAME, GENDER, STUDENT_ID) VALUES ('NEW NAME','M','1020');
--4. Update name for studentid =5 to a different name of your choice.
UPDATE STUDENT SET NAME = 'New New Name' WHERE student_id = 5;
--5. Create a new table of your choice.
CREATE TABLE NEW_TABLE (
	CREATION_DATE DATE
);
--6. Insert a new student into student table again.
INSERT INTO STUDENT (NAME, GENDER, STUDENT_ID) VALUES ('NEW NEW NEW NAME','M','1021');
--7. Perform a rollback.
ROLLBACK;
--8. Write details about what changes were committed and what changes were rolledback after making the changes.
/*
NEW NAME was kept, which was the first data inserted into STUDENT, as well as the UPDATE query that renamed student_id = 5 to New New Name. The NEW TABLE creation also stayed. However, the most recent INSERT was rolled back. 
*/
SELECT * FROM STUDENT;
SHOW TABLES;
--9. Attach a screenshot with the changes observed.

/*------TERMINAL OUTPUT:------

mysql> SELECT * FROM STUDENT;
+------------------+--------+------------+
| NAME             | GENDER | STUDENT_ID |
+------------------+--------+------------+
| Megan            | F      |          1 |
| Joseph           | M      |          2 |
| Kyle             | M      |          3 |
| Katie            | F      |          4 |
| New New Name     | F      |          5 |
| Nathan           | M      |          6 |
| Liesl            | F      |          7 |
| Ian              | M      |          8 |
| Colin            | M      |          9 |
| Peter            | M      |         10 |
| Michael          | M      |         11 |
| Thomas           | M      |         12 |
| Devri            | F      |         13 |
| Ben              | M      |         14 |
| Aubrey           | F      |         15 |
| Rebecca          | F      |         16 |
| Will             | M      |         17 |
| Max              | M      |         18 |
| Rianne           | F      |         19 |
| Avery            | F      |         20 |
| Lauren           | F      |         21 |
| Becca            | F      |         22 |
| Gregory          | M      |         23 |
| Sarah            | F      |         24 |
| Robbie           | M      |         25 |
| Keaton           | M      |         26 |
| Carter           | M      |         27 |
| Teddy            | M      |         28 |
| Gabrielle        | F      |         29 |
| Grace            | F      |         30 |
| Emily            | F      |         31 |
| NEW NAME         | M      |       1020 |
| NEW NEW NEW NAME | M      |       1021 |
| JOESCHMO         | M      |   12345666 |
+------------------+--------+------------+
34 rows in set (0.00 sec)

mysql> show tables;
+---------------------+
| Tables_in_studentdb |
+---------------------+
| GRADE_EVENT         |
| NEW_TABLE           |
| SCORE               |
| STUDENT             |
| Score_Audit         |
+---------------------+
5 rows in set (0.01 sec)

mysql> ROLLBACK;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * FROM STUDENT;
+--------------+--------+------------+
| NAME         | GENDER | STUDENT_ID |
+--------------+--------+------------+
| Megan        | F      |          1 |
| Joseph       | M      |          2 |
| Kyle         | M      |          3 |
| Katie        | F      |          4 |
| New New Name | F      |          5 |
| Nathan       | M      |          6 |
| Liesl        | F      |          7 |
| Ian          | M      |          8 |
| Colin        | M      |          9 |
| Peter        | M      |         10 |
| Michael      | M      |         11 |
| Thomas       | M      |         12 |
| Devri        | F      |         13 |
| Ben          | M      |         14 |
| Aubrey       | F      |         15 |
| Rebecca      | F      |         16 |
| Will         | M      |         17 |
| Max          | M      |         18 |
| Rianne       | F      |         19 |
| Avery        | F      |         20 |
| Lauren       | F      |         21 |
| Becca        | F      |         22 |
| Gregory      | M      |         23 |
| Sarah        | F      |         24 |
| Robbie       | M      |         25 |
| Keaton       | M      |         26 |
| Carter       | M      |         27 |
| Teddy        | M      |         28 |
| Gabrielle    | F      |         29 |
| Grace        | F      |         30 |
| Emily        | F      |         31 |
| NEW NAME     | M      |       1020 |
| JOESCHMO     | M      |   12345666 |
+--------------+--------+------------+
33 rows in set (0.01 sec)

mysql> show tables;
+---------------------+
| Tables_in_studentdb |
+---------------------+
| GRADE_EVENT         |
| NEW_TABLE           |
| SCORE               |
| STUDENT             |
| Score_Audit         |
+---------------------+
5 rows in set (0.01 sec)

*/






