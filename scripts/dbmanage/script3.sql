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


-- a) Find the ships heavier than 35,000 tons.
SELECT name
FROM Classes
WHERE displacement > 35000;

-- b) List the name, displacement, and number of guns of the ships engaged in the battle of Guadalcanal.
SELECT S.name, C.displacement, C.numGuns
FROM Ships S
JOIN Classes C ON S.class = C.class
JOIN Outcomes O ON S.name = O.ship
JOIN Battles B ON O.battle = B.name
WHERE B.name = 'Guadalcanal';

-- c) List all the ships mentioned in the database. (Remember that all these ships may not appear in the Ships relation.)
SELECT name FROM Ships
UNION
SELECT ship FROM Outcomes;


-- d) Find the names of the ships with a 16-inch bore using subquery with `IN`:
SELECT name
FROM Ships
WHERE class IN (SELECT class FROM Classes WHERE bore = 16.0);


-- `EXISTS`:
SELECT name
FROM Ships S
WHERE EXISTS (SELECT 1 FROM Classes C WHERE C.class = S.class AND C.bore = 16.0);


-- e) Find the battles in which ships of the Kongo class participated using subquery with `IN`:
SELECT DISTINCT B.name
FROM Battles B
WHERE B.name IN (SELECT O.battle FROM Outcomes O JOIN Ships S ON O.ship = S.name WHERE S.class = 'Kongo');


-- Using `EXISTS`:
SELECT DISTINCT B.name
FROM Battles B
WHERE EXISTS (SELECT 1 FROM Outcomes O JOIN Ships S ON O.ship = S.name WHERE O.battle = B.name AND S.class = 'Kongo');


-- f) Find the countries whose ships had the largest number of guns using subquery with `ALL`:
SELECT DISTINCT country
FROM Classes C
WHERE C.numGuns >= ALL (SELECT numGuns FROM Classes);

-- Using `ANY`:
SELECT DISTINCT country
FROM Classes C
WHERE C.numGuns >= ANY (SELECT numGuns FROM Classes);
