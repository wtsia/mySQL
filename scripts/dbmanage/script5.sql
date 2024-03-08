-- Create Product table
CREATE TABLE Product (
    maker CHAR(1),
    model INT,
    type VARCHAR(7),
    PRIMARY KEY (model)
);

-- Create PC table
CREATE TABLE PC (
    model INT,
    speed DECIMAL,
    ram INT,
    hd INT,
    price INT,
    PRIMARY KEY (model)
);

INSERT INTO Product (maker, model, type) VALUES
('A', 1001, 'pc'),
('A', 1002, 'pc'),
('A', 1003, 'pc'),
('A', 2004, 'laptop'),
('A', 2005, 'laptop'),
('A', 2006, 'laptop'),
('B', 1004, 'pc'),
('B', 1005, 'pc'),
('B', 1006, 'pc'),
('B', 2007, 'laptop'),
('C', 1007, 'pc'),
('D', 1008, 'pc'),
('D', 1009, 'pc'),
('D', 1010, 'pc'),
('D', 3004, 'printer'),
('D', 3005, 'printer'),
('E', 1011, 'pc'),
('E', 1012, 'pc'),
('E', 1013, 'pc'),
('E', 2001, 'laptop'),
('E', 2002, 'laptop'),
('E', 2003, 'laptop'),
('E', 3001, 'printer'),
('E', 3002, 'printer'),
('E', 3003, 'printer'),
('F', 2008, 'laptop'),
('F', 2009, 'laptop'),
('G', 2010, 'laptop'),
('H', 3006, 'printer'),
('H', 3007, 'printer');

INSERT INTO PC (model, speed, ram, hd, price) VALUES
(1001, 2.66, 1024, 250, 2114),
(1002, 2.10, 512, 250, 995),
(1003, 1.42, 512, 80, 478),
(1004, 2.80, 1024, 250, 649),
(1005, 3.20, 512, 250, 630),
(1006, 3.20, 1024, 320, 1049),
(1007, 2.20, 1024, 200, 510),
(1008, 2.20, 2048, 250, 770),
(1009, 2.00, 1024, 250, 650),
(1010, 2.80, 2048, 300, 770),
(1011, 1.86, 2048, 160, 959),
(1012, 2.80, 1024, 160, 649),
(1013, 3.06, 512, 80, 529);


-- a) Given a speed and amount of RAM (as arguments of the function), look up the PCs with that speed and RAM, printing the model number and price of each.
-- The transaction is read-only
BEGIN TRANSACTION;
SELECT model, price
FROM PC
WHERE speed = ? AND ram = ?;
COMMIT;

-- b) Given a model number, delete the tuple for that model from both PC and Product.
BEGIN TRANSACTION;
DELETE FROM PC WHERE model = ?;
DELETE FROM Product WHERE model = ?;
COMMIT;

-- c) Given a model number, decrease the price of that model PC by $100.
BEGIN TRANSACTION;
UPDATE PC
SET price = price - 100
WHERE model = ?;
COMMIT;

-- d) Given a maker, model number, processor speed, RAM size, hard-disk size, and price, check that there is no product with that model. If there is such a model, print an error message for the user. If no such model existed in the database, enter the information about that model into the PC and Product tables.
BEGIN TRANSACTION;
IF EXISTS (SELECT 1 FROM Product WHERE model = ?) THEN
    PRINT 'Error: A product with this model already exists.';
ELSE
    INSERT INTO Product (maker, model, type) VALUES (?, ?, 'pc');  
    INSERT INTO PC (model, speed, ram, hd, price) VALUES (?, ?, ?, ?, ?);
END IF;
COMMIT;

