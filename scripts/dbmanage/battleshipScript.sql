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
INSERT INTO Outcomes VALUES ('Duke of York', 'North Cape', 'ok');
INSERT INTO Outcomes VALUES ('Fuso', 'Surigao Strait', 'sunk');
INSERT INTO Outcomes VALUES ('Hood', 'Denmark Strait', 'sunk');
INSERT INTO Outcomes VALUES ('King George V', 'Denmark Strait', 'ok');
INSERT INTO Outcomes VALUES ('Kirishima', 'Guadacanal', 'sunk');
INSERT INTO Outcomes VALUES ('Prince of Wales', 'Denmark Strait', 'damaged');
INSERT INTO Outcomes VALUES ('Rodney', 'Denmark Strait', 'ok');
INSERT INTO Outcomes VALUES ('Scharnhorst', 'North Cape', 'sunk');
INSERT INTO Outcomes VALUES ('South Dakota', 'Guadacanal', 'damaged');
INSERT INTO Outcomes VALUES ('Tennessee', 'Surigao Strait', 'ok');
INSERT INTO Outcomes VALUES ('Washington', 'Guadacanal', 'ok');
INSERT INTO Outcomes VALUES ('West Virginia', 'Surigao Strait', 'ok');
INSERT INTO Outcomes VALUES ('Yamashiro', 'Surigao Strait', 'sunk');

-- Ships table
INSERT INTO Ships VALUES ('California', 'Tennessee', 1921);
INSERT INTO Ships VALUES ('Haruna', 'Kongo', 1915);
INSERT INTO Ships VALUES ('Hiei', 'Kongo', 1914);
INSERT INTO Ships VALUES ('Iowa', 'Iowa', 1943);
INSERT INTO Ships VALUES ('Kirishima', 'Kongo', 1915);
INSERT INTO Ships VALUES ('Kongo', 'Kongo', 1913);
INSERT INTO Ships VALUES ('Missouri', 'Iowa', 1944);
INSERT INTO Ships VALUES ('Musashi', 'Yamato', 1942);
INSERT INTO Ships VALUES ('New Jersey', 'Iowa', 1943);
INSERT INTO Ships VALUES ('North Carolina', 'North Carolina', 1941);
INSERT INTO Ships VALUES ('Ramillies', 'Revenge', 1917);
INSERT INTO Ships VALUES ('Renown', 'Renown', 1916);
INSERT INTO Ships VALUES ('Repulse', 'Renown', 1916);
INSERT INTO Ships VALUES ('Resolution', 'Revenge', 1916);
INSERT INTO Ships VALUES ('Revenge', 'Revenge', 1916);
INSERT INTO Ships VALUES ('Royal Oak', 'Revenge', 1916);
INSERT INTO Ships VALUES ('Royal Sovereign', 'Revenge', 1916);
INSERT INTO Ships VALUES ('Tennessee', 'Tennessee', 1920);
INSERT INTO Ships VALUES ('Washington', 'North Carolina', 1941);
INSERT INTO Ships VALUES ('Wisconsin', 'Iowa', 1944);
INSERT INTO Ships VALUES ('Yamato', 'Yamato', 1941);

-- PROBLEMS
-- a) Find those countries that have both battleships and battlecruisers.
SELECT 'a.' AS Message;
SELECT country
FROM Classes
WHERE type IN ('bb', 'bc')
GROUP BY country
HAVING COUNT(DISTINCT type) = 2;

-- b) Find those ships that were damaged in one battle, but later fought in another.
SELECT 'b.' AS Message;
SELECT DISTINCT O1.ship
FROM Outcomes O1
JOIN Outcomes O2 ON O1.ship = O2.ship AND O1.result = 'damaged' AND O2.result = 'ok'
WHERE O1.battle <> O2.battle;

-- c) Find the classes of ships, at least one of which was sunk in a battle.
SELECT 'c.' AS Message;
SELECT DISTINCT C.class
FROM Classes C
JOIN Ships S ON C.class = S.class
JOIN Outcomes O ON S.name = O.ship
WHERE O.result = 'sunk';

-- d) Find the names of the ships whose number of guns was the largest for those ships of the same bore.
SELECT bore, MAX(numGuns) 
FROM Classes 
GROUP BY bore;


-- e) Find for each class the year in which the first ship of that class was launched.
SELECT 'e.' AS Message;
SELECT class, MIN(launched) AS first_ship_launched_yr
FROM Ships
GROUP BY class;

Output:

+---------+
| Message |
+---------+
| a.      |
+---------+
+-------------+
| country     |
+-------------+
| Gt. Britain |
| Japan       |
+-------------+
+---------+
| Message |
+---------+
| b.      |
+---------+
+---------+
| Message |
+---------+
| c.      |
+---------+
+-------+
| class |
+-------+
| Kongo |
+-------+
+------+--------------+
| bore | MAX(numGuns) |
+------+--------------+
| 15.0 |            8 |
| 16.0 |            9 |
| 14.0 |           12 |
| 18.0 |            9 |
+------+--------------+
+---------+
| Message |
+---------+
| e.      |
+---------+
+----------------+------------------------+
| class          | first_ship_launched_yr |
+----------------+------------------------+
| Tennessee      |                   1920 |
| Kongo          |                   1913 |
| Iowa           |                   1943 |
| Yamato         |                   1941 |
| North Carolina |                   1941 |
| Revenge        |                   1916 |
| Renown         |                   1916 |
+----------------+------------------------+