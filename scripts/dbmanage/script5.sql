-- a) Given a speed and amount of RAM (as arguments of the function), look up the PCs with that speed and RAM, printing the model number and price of each.
BEGIN TRANSACTION;
SELECT model, price
FROM PC
WHERE speed = <speed_argument> AND ram = <ram_argument>;
COMMIT;


-- b) Given a model number, delete the tuple for that model from both PC and Product.
BEGIN TRANSACTION;
DELETE FROM PC WHERE model = <model_number>;
DELETE FROM Product WHERE model = <model_number>;
COMMIT;

-- c) Given a model number, decrease the price of that model PC by $100.
BEGIN TRANSACTION;
UPDATE PC
SET price = price - 100
WHERE model = <model_number>;
COMMIT;

-- d) Given a maker, model number, processor speed, RAM size, hard-disk size, and price, check that there is no product with that model. If there is such a model, print an error message for the user. If no such model existed in the database, enter the information about that model into the PC and Product tables.
BEGIN TRANSACTION;
IF EXISTS (SELECT * FROM Product WHERE model = <model_number>)
    PRINT 'Error: Model already exists';
ELSE
    BEGIN
        INSERT INTO Product (maker, model, type) VALUES (<maker>, <model_number>, <type>);
        INSERT INTO PC (model, speed, ram, hd, price) VALUES (<model_number>, <processor_speed>, <ram_size>, <hd_size>, <price>);
    END
COMMIT;
