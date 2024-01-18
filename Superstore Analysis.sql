CREATE TABLE superstore (
    item_id INTEGER PRIMARY KEY,
    item_name TEXT,
    category TEXT,
    price DECIMAL(10, 2),
    stock_quantity INTEGER,
    average_rating DECIMAL(3, 2)
);

INSERT INTO superstore (item_id, item_name, category, price, stock_quantity, average_rating)
VALUES
    (1, 'Stainless Steel Cookware Set', 'Kitchen Supplies', 89.99, 50, 4.6),
    (2, 'Memory Foam Mattress', 'Furnishings', 499.99, 30, 4.8),
    (3, 'Smart LED TV', 'Electronics', 549.00, 20, 4.5),
    (4, 'Robot Vacuum Cleaner', 'Appliances', 199.50, 40, 4.3),
    (5, 'Wireless Bluetooth Speaker', 'Electronics', 39.99, 60, 4.2),
    (6, 'Non-Stick Baking Set', 'Kitchen Supplies', 29.95, 80, 4.4),
    (7, 'Cotton Bedding Set', 'Furnishings', 89.00, 25, 4.7),
    (8, 'Smart Home Security Camera', 'Electronics', 79.95, 15, 4.1),
    (9, 'Air Purifier', 'Appliances', 129.50, 35, 4.6),
    (10, 'Premium Coffee Maker', 'Kitchen Supplies', 79.99, 50, 4.9),
    (11, 'Ergonomic Office Chair', 'Furnishings', 189.00, 20, 4.5),
    (12, 'Wireless Earbuds', 'Electronics', 49.99, 75, 4.3),
    (13, 'Slow Cooker', 'Appliances', 49.95, 30, 4.7),
    (14, 'Cutlery Set', 'Kitchen Supplies', 34.50, 40, 4.4),
    (15, 'Cozy Throw Blanket', 'Furnishings', 24.99, 100, 4.2);

-- Order the superstore items by price.
SELECT * FROM superstore ORDER BY price;

-- Select the items in the category of Kitchen Supplies.
SELECT * FROM superstore WHERE category = "Kitchen Supplies";

-- What is the average price of the Kitchen Supplies items?
SELECT AVG(price) AS Average_Price_Of_Kitchen_Supplies_Items FROM superstore WHERE category = "Kitchen Supplies";

-- What is the average of the average rating of all items?
SELECT AVG(average_rating) AS Average_Rating_Of_All_Items FROM superstore;

-- What items have an average rating greater than or equal to 4.5?
SELECT * FROM superstore WHERE average_rating >= 4.5 ORDER BY average_rating DESC;

-- What items have an average rating of less than 4.5?
SELECT * FROM superstore WHERE average_rating < 4.5 ORDER BY average_rating DESC;

-- What is the most expensive item?
SELECT * FROM superstore ORDER BY price DESC LIMIT 1;

-- What is the total revenue from the most expensive items?
SELECT item_name AS Most_Expensive_Item, price AS Price, stock_quantity AS Stock, (price * stock_quantity) AS Total_Revenue_Expected
    FROM superstore ORDER BY price DESC LIMIT 1;

-- What is the least expensive item?
SELECT * FROM superstore ORDER BY price ASC LIMIT 1;

-- What is the total revenue from the least expensive items?
SELECT item_name AS Least_Expensive_Item, price AS Price, stock_quantity AS Stock, (price * stock_quantity) AS Total_Revenue_Expected
    FROM superstore ORDER BY price ASC LIMIT 1;

-- What is the total revenue which can be generated from the superstore?
SELECT SUM(price * stock_quantity) AS Total_Revenue_Expected_From_Superstore FROM superstore;

-- What is the total revenue that can be generated from each one of the superstore items?
SELECT item_name AS Item, price AS Price, stock_quantity AS Stock, (price * stock_quantity) AS Total_Revenue_Expected
    FROM superstore ORDER BY Total_Revenue_Expected DESC;

-- Which item will generate the most revenue?
SELECT item_name AS Item, price AS Price, stock_quantity AS Stock, (price * stock_quantity) AS Total_Revenue_Expected
    FROM superstore ORDER BY Total_Revenue_Expected DESC LIMIT 1;

-- Which item will generate the least revenue?
SELECT item_name AS Item, price AS Price, stock_quantity AS Stock, (price * stock_quantity) AS Total_Revenue_Expected
    FROM superstore ORDER BY Total_Revenue_Expected ASC LIMIT 1;
