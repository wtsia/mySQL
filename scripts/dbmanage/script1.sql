CREATE TABLE Classes (
    class CHAR(20),
    type CHAR(5),
    country CHAR(20),
    numGuns INTEGER,
    bore DECIMAL(3,1),
    displacement INTEGER
);

CREATE TABLE Ships (
    name CHAR(30),
    class CHAR(20),
    launched INTEGER
);

CREATE TABLE Battles (
    name CHAR(30),
    date DATE
);

CREATE TABLE Outcomes (
    ship CHAR(30),
    battle CHAR(30),
    result CHAR(10)
);

-- INSERT
-- Classes table
INSERT INTO Classes VALUES ('Bismarck', 'bb', 'Germany', 8, 15, 42000);
INSERT INTO Classes VALUES ('Iowa', 'bb', 'USA', 9, 16, 46000);
INSERT INTO Classes VALUES ('Kongo', 'bc', 'Japan', 8, 14, 32000);
INSERT INTO Classes VALUES ('North Carolina', 'bb', 'USA', 9, 16, 37000);
INSERT INTO Classes VALUES ('Renown', 'bc', 'Gt. Britain', 6, 15, 32000);
INSERT INTO Classes VALUES ('Revenge', 'bb', 'Gt. Britain', 8, 15, 29000);
INSERT INTO Classes VALUES ('Tennessee', 'bb', 'USA', 12, 14, 32000);
INSERT INTO Classes VALUES ('Yamato', 'bb', 'Japan', 9, 18, 65000);

-- Battles table
INSERT INTO Battles VALUES ('Denmark Strait', '1942-05-24');
INSERT INTO Battles VALUES ('Guadalcanal', '1942-11-15');
INSERT INTO Battles VALUES ('North Cape', '1943-12-26');
INSERT INTO Battles VALUES ('Surigao Strait', '1944-10-25');

-- Outcomes table
INSERT INTO Outcomes VALUES ('Arizona', 'Pearl Harbor', 'sunk');
INSERT INTO Outcomes VALUES ('Bismarck', 'Denmark Strait', 'sunk');
INSERT INTO Outcomes VALUES ('California', 'Surigao Strait', 'ok');
-- SHORTENED FOR BREVITY

-- Ships table
INSERT INTO Ships VALUES ('California', 'Tennessee', 1921);
INSERT INTO Ships VALUES ('Haruna', 'Kongo', 1915);
INSERT INTO Ships VALUES ('Hiei', 'Kongo', 1914);
-- SHORTENED FOR BREVITY

-- PROBLEMS 
-- a) Find the names of all ships launched prior to 1918, but call the resulting column ShipName.
SELECT 'a.' AS Message;
SELECT name AS ShipName
FROM Ships
WHERE launched < 1918;

-- b) Find the names of ships sunk in battle and the name of the battle in which they were sunk.
SELECT 'b.' AS Message;
SELECT O.ship AS ShipName, O.battle AS BattleName
FROM Outcomes O
JOIN Battles B ON O.battle = B.name
WHERE O.result = 'sunk';

-- c) Find the names of all ships that begin with the letter "R".
SELECT 'c.' AS Message;
SELECT name
FROM Ships
WHERE name LIKE 'R%';

-- d) Find the names of all ships whose name consists of three or more words (e.g., King George V).
SELECT 'd.' AS Message;
SELECT name
FROM Ships
WHERE LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) >= 2;

-- e) Find the ships heavier than 35,000 tons.
SELECT 'e.' AS Message;
SELECT class
FROM Classes
WHERE displacement > 35000;

-- f) List the name, displacement, and number of guns of the ships engaged in the battle of Guadalcanal.
SELECT 'f.' AS Message;
SELECT S.name, C.displacement, C.numGuns
FROM Ships S
JOIN Classes C ON S.class = C.class
JOIN Outcomes O ON S.name = O.ship
WHERE O.battle = 'Guadalcanal';

-- g) List all the ships mentioned in the database. (Remember that all these ships may not appear in the Ships relation.)
SELECT 'g.' AS Message;
SELECT name FROM Ships
UNION
SELECT ship FROM Outcomes;

-- h) Find the names of the ships with a 16-inch bore.
SELECT 'h.' AS Message;
SELECT S.name
FROM Ships S
JOIN Classes C ON S.class = C.class
WHERE C.bore = 16.0;

-- i) Find the battles in which ships of the Kongo class participated.
SELECT 'i.' AS Message;
SELECT B.name AS BattleName
FROM Battles B
JOIN Outcomes O ON B.name = O.battle
JOIN Ships S ON O.ship = S.name
JOIN Classes C ON S.class = C.class
WHERE C.class = 'Kongo';

-- j) Find the countries whose ships had the largest number of guns.
SELECT 'j.' AS Message;
SELECT country
FROM Classes
WHERE numGuns = (SELECT MAX(numGuns) FROM Classes);

Output:

+---------+
| Message |
+---------+
| a.      |
+---------+
+----------+
| ShipName |
+----------+
| Haruna   |
| Hiei     |
+----------+
+---------+
| Message |
+---------+
| b.      |
+---------+
+----------+----------------+
| ShipName | BattleName     |
+----------+----------------+
| Bismarck | Denmark Strait |
+----------+----------------+
+---------+
| Message |
+---------+
| c.      |
+---------+
+---------+
| Message |
+---------+
| d.      |
+---------+
+---------+
| Message |
+---------+
| e.      |
+---------+
+----------------+
| class          |
+----------------+
| Bismarck       |
| Iowa           |
| North Carolina |
| Yamato         |
+----------------+
+---------+
| Message |
+---------+
| f.      |
+---------+
+---------+
| Message |
+---------+
| g.      |
+---------+
+------------+
| name       |
+------------+
| California |
| Haruna     |
| Hiei       |
| Arizona    |
| Bismarck   |
+------------+
+---------+
| Message |
+---------+
| h.      |
+---------+
+---------+
| Message |
+---------+
| i.      |
+---------+
+---------+
| Message |
+---------+
| j.      |
+---------+
+---------+
| country |
+---------+
| USA     |
+---------+