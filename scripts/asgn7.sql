/*
Create Database Trigger for the following:
1. Use Score table for the trigger.
2. Create a database trigger for Insert, Update and Delete operations on Score table.
3. The trigger should create new records when above operations are made in Score_Audit table.
4. Please add the following additional columns to the Score_Audit table.

Operation Varchar(50)
Create_Date Date
History_Date Date
USer varchar(100)

5. Operation column should have Insert, Update & Delete operations.
6. Create_Date and History_Date should store the timestamp
7. User column should store the current user who is performing the actions on the Score table.
*/

DELIMITER //

use studentdb //

CREATE TABLE Score_Audit (
	Operation Varchar(50),
	Create_Date Date,
	History_Date Date,
	User varchar(100)
) //

-- insert
CREATE TRIGGER score_insert_trigger
AFTER INSERT ON SCORE
FOR EACH ROW
BEGIN
    INSERT INTO Score_Audit (Operation, Create_Date, History_Date, User)
    VALUES ('INSERT', CURDATE(), CURDATE(), CURRENT_USER());
END //

-- update
CREATE TRIGGER score_update_trigger
AFTER UPDATE ON SCORE
FOR EACH ROW
BEGIN
    INSERT INTO Score_Audit (Operation, Create_Date, History_Date, User)
    VALUES ('UPDATE', CURDATE(), CURDATE(), CURRENT_USER());
END //

-- delete
CREATE TRIGGER score_delete_trigger
AFTER DELETE ON SCORE
FOR EACH ROW
BEGIN
    INSERT INTO Score_Audit (Operation, Create_Date, History_Date, User)
    VALUES ('DELETE', CURDATE(), CURDATE(), CURRENT_USER());
END //
DELIMITER ;


/*
8. After creating the trigger, please test the trigger by Inserting, updating and deleting rows from Score table.
9. Take a screenshot of the testing done .
10. Include the trigger and screenshots as part of your submission.


mysql> INSERT INTO SCORE VALUES ('12345666', '1', '12');
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM Score_Audit;
+-----------+-------------+--------------+----------------+
| Operation | Create_Date | History_Date | User           |
+-----------+-------------+--------------+----------------+
| INSERT    | 2023-06-05  | 2023-06-05   | root@localhost |
+-----------+-------------+--------------+----------------+
1 row in set (0.00 sec)

mysql>
*/

