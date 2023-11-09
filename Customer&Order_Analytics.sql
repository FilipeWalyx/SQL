-- Customer & Order Analytics Project.
-- In this SQL, I'm querying a database with multiple tables in it to quantify statistics about customer and order data.

-- How many orders were placed in January?
SELECT COUNT(orderID) AS Number_Of_Orders_Placed_In_January
FROM JanSales WHERE length(orderID)=6 AND orderID<>'Order ID';

-- How many of those orders were for an iPhone?
SELECT COUNT(orderID) AS Number_Of_iPhone_Orders
FROM JanSales WHERE Product='iPhone'
AND length(orderID)=6 AND orderID<>'Order ID';

-- Select the customer account numbers for all the orders that were placed in February.
SELECT DISTINCT acctnum
FROM customers cust INNER JOIN FebSales febs
ON cust.order_id = febs.orderID
WHERE length(orderID)=6 AND orderID<>'Order ID';

-- Which product was the cheapest one sold in January, and what was the price?
SELECT DISTINCT Product, MIN(price) AS Price FROM JanSales
GROUP BY product, price ORDER BY price ASC LIMIT 1;

-- What is the total revenue for each product sold in January?
SELECT Product, sum(Quantity) * price AS Revenue FROM JanSales
WHERE length(orderID)=6 AND orderID<>'Order ID'
GROUP BY Product ORDER BY Revenue DESC;

/* Which products were sold in February at 548 Lincoln St, Seattle, WA 98101,
how many of each were sold, and what was the total revenue? */
SELECT Product, sum(Quantity) AS Quantity,
sum(Quantity) * price AS Revenue From FebSales
WHERE location = '548 Lincoln St, Seattle, WA 98101'
GROUP BY Product ORDER BY Revenue DESC;

/* How many customers ordered more than 2 products at a time in February,
and what was the average amount spent for those customers? */
SELECT COUNT(DISTINCT cust.acctnum) AS Number_Of_Customers,
avg(Quantity*price) AS Average_Amount_Spent
FROM FebSales febs LEFT JOIN customers cust
ON febs.orderID = cust.order_id
WHERE febs.Quantity> 2
AND length(orderID)=6 AND orderID<>'Order ID';
