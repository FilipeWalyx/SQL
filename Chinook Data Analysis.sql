-- Show Customers (their full names, customer ID, and country) who are not in the US.
SELECT FirstName, LastName, CustomerId, Country FROM customers
WHERE Country <> 'USA';

-- Show only the Customers from Brazil.
SELECT * FROM customers WHERE Country = 'Brazil';

-- Find the Invoices of customers who are from Brazil. The resulting table should show
-- the customer's full name, Invoice ID, Date of the invoice, and billing country.
SELECT cust.FirstName, cust.LastName, invo.InvoiceId, invo.InvoiceDate, invo.BillingCountry
FROM invoices invo LEFT JOIN customers cust
ON invo.CustomerId = cust.CustomerId
WHERE BillingCountry = 'Brazil';

-- Show the full names of customers who have support reps,
-- their employee IDs, their full names and their titles.
SELECT cust.FirstName, cust.LastName, empl.EmployeeId,
empl.FirstName, empl.LastName, empl.Title
FROM customers cust JOIN employees empl
ON cust.SupportRepId = empl.EmployeeId;

-- Show the Employees who are Sales Agents.
SELECT * FROM employees
WHERE Title LIKE 'Sales%' AND Title LIKE '%Agent';

-- Find a unique/distinct list of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry FROM invoices ORDER BY BillingCountry ASC;

-- How many invoices were issued for each billing country?
SELECT BillingCountry, COUNT(BillingCountry) AS Number_Of_Invoices FROM invoices
GROUP BY BillingCountry ORDER BY Number_Of_Invoices DESC;

-- Provide a query that shows the invoices associated with each sales agent.
-- The resulting table should include the Sales Agent's full name.
SELECT empl.FirstName, empl.LastName, invo.*
FROM employees empl
JOIN customers cust ON cust.SupportRepId = empl.EmployeeId
JOIN invoices invo ON invo.CustomerId = cust.CustomerId;

-- Show the Invoice Total, Customer name, Country, and Sales Agent name for all invoices and customers.
SELECT invo.Total, cust.FirstName, cust.LastName,
cust.Country, empl.FirstName, empl.LastName
FROM employees empl
JOIN customers cust ON cust.SupportRepId = empl.EmployeeId
JOIN invoices invo ON invo.CustomerId = cust.CustomerId;

-- How many Invoices were there in 2009?
SELECT COUNT(InvoiceId) AS Number_Of_Invoices_In_2009
FROM invoices WHERE InvoiceDate LIKE '%2009%';

-- What are the total sales for 2009?
SELECT SUM(Total) AS Total_Sales_For_2009
FROM invoices WHERE InvoiceDate LIKE '%2009%';

-- Write a query that includes the purchased track name with each invoice line ID.
SELECT trac.Name, invoitem.InvoiceLineId
FROM invoice_items invoitem JOIN tracks trac
ON invoitem.TrackId = trac.TrackId;

-- Write a query that includes the purchased track name AND artist name with each invoice line ID.
SELECT trac.Name AS Track, arti.Name AS Artist, invoitem.InvoiceLineId
FROM invoice_items invoitem LEFT JOIN tracks trac
ON invoitem.TrackId = trac.TrackId
INNER JOIN albums albu
ON albu.AlbumId = trac.AlbumId
LEFT JOIN artists arti
ON arti.ArtistId = albu.ArtistId;

-- List the artists by the amount of money in sales that their music brought in.
SELECT arti.Name AS Artist, SUM(invo.Total) AS Total_Sales
FROM invoices invo INNER JOIN invoice_items invoitem
ON invo.InvoiceId = invoitem.InvoiceId
LEFT JOIN tracks trac
ON invoitem.TrackId = trac.TrackId
INNER JOIN albums albu
ON trac.AlbumId = albu.AlbumId
LEFT JOIN artists arti
ON albu.ArtistId = arti.ArtistId
GROUP BY arti.ArtistId ORDER BY Total_Sales DESC;

-- Which artist's music was sold the most?
SELECT arti.Name AS Artist, SUM(invo.Total) AS Total_Sales
FROM invoices invo INNER JOIN invoice_items invoitem
ON invo.InvoiceId = invoitem.InvoiceId
LEFT JOIN tracks trac
ON invoitem.TrackId = trac.TrackId
INNER JOIN albums albu
ON trac.AlbumId = albu.AlbumId
LEFT JOIN artists arti
ON albu.ArtistId = arti.ArtistId
GROUP BY arti.ArtistId ORDER BY Total_Sales DESC LIMIT 1;

-- Which artist's music was sold the least?
SELECT arti.Name AS Artist, SUM(invo.Total) AS Total_Sales
FROM invoices invo INNER JOIN invoice_items invoitem
ON invo.InvoiceId = invoitem.InvoiceId
LEFT JOIN tracks trac
ON invoitem.TrackId = trac.TrackId
INNER JOIN albums albu
ON trac.AlbumId = albu.AlbumId
LEFT JOIN artists arti
ON albu.ArtistId = arti.ArtistId
GROUP BY arti.ArtistId ORDER BY Total_Sales ASC LIMIT 1;

-- Provide a query that shows all the Tracks, and include the Album name, Media type, and Genre.
SELECT trac.Name AS Track, albu.Title AS Album,
medt.Name AS Media_Type, genr.Name AS Genre
FROM tracks trac JOIN albums albu
ON trac.AlbumId = albu.AlbumId
JOIN media_types medt
ON trac.MediaTypeId = medt.MediaTypeId
JOIN genres genr
ON trac.GenreId = genr.GenreId
ORDER BY Track ASC;

-- List all tracks and the number of playlists they are in?
SELECT trac.Name AS Track, COUNT(playt.PlaylistId) AS Number_Of_Playlists
FROM tracks trac LEFT JOIN playlist_track playt
ON trac.TrackId = playt.TrackId
GROUP BY trac.TrackId ORDER BY Number_Of_Playlists DESC;

-- List all tracks from the most sold to the least and the amount of money in sales?
SELECT trac.Name AS Track, SUM(invo.Total) AS Total_Sales
FROM invoices invo JOIN invoice_items invoitem
ON invo.InvoiceId = invoitem.InvoiceId
JOIN tracks trac
ON invoitem.TrackId = trac.TrackId
GROUP BY trac.TrackId ORDER BY Total_Sales DESC;

-- How much profitable was each music genres?
SELECT genr.Name AS Genre, SUM(invo.Total) AS Total_Sales
FROM invoices invo JOIN invoice_items invoitem
ON invo.InvoiceId = invoitem.InvoiceId
JOIN tracks trac
ON invoitem.TrackId = trac.TrackId
JOIN genres genr
ON trac.GenreId = genr.GenreId
GROUP BY genr.GenreId ORDER BY Total_Sales DESC;

-- Show the total sales made by each sales agent.
SELECT empl.FirstName, empl.LastName, ROUND(SUM(invo.Total),2) AS Total_Sales
FROM employees empl JOIN customers cust
ON empl.EmployeeId = cust.SupportRepId
JOIN invoices invo
ON cust.CustomerId = invo.CustomerId
WHERE empl.Title LIKE 'Sales%' AND empl.Title LIKE '%Agent'
GROUP BY empl.EmployeeId ORDER BY Total_Sales DESC;

-- Which sales agent made the most dollars in sales in 2009?
SELECT empl.FirstName, empl.LastName, ROUND(SUM(invo.Total),2) AS Total_Sales
FROM employees empl JOIN customers cust
ON empl.EmployeeId = cust.SupportRepId
JOIN invoices invo
ON cust.CustomerId = invo.CustomerId
WHERE empl.Title LIKE 'Sales%' AND empl.Title LIKE '%Agent'
AND invo.InvoiceDate LIKE '%2009%'
GROUP BY empl.EmployeeId ORDER BY Total_Sales DESC LIMIT 1;
