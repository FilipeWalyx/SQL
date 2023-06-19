--Create a soft drink store database.
CREATE TABLE softdrinks (id INTEGER PRIMARY KEY, name TEXT, flavor TEXT, cases INTEGER, price NUMERIC);

INSERT INTO softdrinks VALUES (1, "Coca-Cola", "Original", 50, 8.99);
INSERT INTO softdrinks VALUES (2, "Coca-Cola", "Diet", 40, 8.50);
INSERT INTO softdrinks VALUES (3, "Coca-Cola", "Zero Sugar", 25, 8);
INSERT INTO softdrinks VALUES (4, "Pepsi", "Original", 50, 9.99);
INSERT INTO softdrinks VALUES (5, "Pepsi", "Diet", 40, 9.50);
INSERT INTO softdrinks VALUES (6, "Pepsi", "Zero Sugar", 25, 9);
INSERT INTO softdrinks VALUES (7, "Fanta", "Orange", 50, 8.99);
INSERT INTO softdrinks VALUES (8, "Fanta", "Pineapple", 40, 8.50);
INSERT INTO softdrinks VALUES (9, "Fanta", "Grape", 30, 7.99);
INSERT INTO softdrinks VALUES (10, "Fanta", "Lemon", 25, 7.99);
INSERT INTO softdrinks VALUES (11, "Fanta", "Apple", 20, 7.99);
INSERT INTO softdrinks VALUES (12, "Sprite", "Original", 50, 8.99);
INSERT INTO softdrinks VALUES (13, "Sprite", "Zero Sugar", 25, 8.50);
INSERT INTO softdrinks VALUES (14, "Mountain Dew", "Original", 50, 9.99);
INSERT INTO softdrinks VALUES (15, "Mountain Dew", "Diet", 40, 9.50);

--Display the database ordered by the most expensive price.
SELECT * FROM softdrinks ORDER BY price DESC;

--What is the total amount of cases of each brand of soft drink?
SELECT name, SUM(cases) FROM softdrinks GROUP BY name ORDER BY SUM(cases) DESC;
