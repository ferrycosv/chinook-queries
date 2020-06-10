-- 1. Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT CustomerId,FirstName||' '||LastName, Country FROM Customer WHERE Country != "USA"

-- 2. Provide a query only showing the Customers from Brazil.
SELECT * FROM Customer WHERE Country = "Brazil"

-- 3. Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT FirstName||' '||LastName,InvoiceId,InvoiceDate,BillingCountry FROM Customer A INNER JOIN Invoice B on (A.CustomerId =B.CustomerId) WHERE Country = "Brazil"

-- 4. Provide a query showing only the Employees who are Sales Agents.
SELECT * FROM Employee WHERE Title = "Sales Support Agent"

-- 5. Provide a query showing a unique list of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry FROM Invoice

-- 6. Provide a query showing the invoices of customers who are from Brazil.
SELECT B.* FROM Customer A INNER JOIN Invoice B on (A.CustomerId =B.CustomerId) WHERE A.Country = "Brazil"

-- 7. Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT C.FirstName||' '||C.LastName SalesAgent,B.* FROM Customer A INNER JOIN Invoice B on (A.CustomerId =B.CustomerId) INNER JOIN Employee  C on (A.SupportRepId = C.EmployeeId)

-- 8. Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT C.FirstName||' '||C.LastName SalesAgent, A.Country, A.FirstName||' '||A.LastName CustomerName, B.Total FROM Customer A INNER JOIN Invoice B on (A.CustomerId =B.CustomerId) INNER JOIN Employee  C on (A.SupportRepId = C.EmployeeId)

-- 9. How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years?
SELECT strftime('%Y',InvoiceDate) year,COUNT(1),sum(total) FROM Invoice WHERE CAST(strftime('%Y',InvoiceDate) as INTEGER) IN (2009,2011) GROUP BY strftime('%Y',InvoiceDate)

-- 10. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT COUNT(1),InvoiceId FROM InvoiceLine WHERE InvoiceId=37 GROUP BY InvoiceId

-- 11. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: [GROUP BY](http://www.sqlite.org/lang_select.html#resultset)
SELECT COUNT(1),InvoiceId FROM InvoiceLine GROUP BY InvoiceId

-- 12. Provide a query that includes the track name with each invoice line item.
SELECT A.*,B.Name FROM InvoiceLine A INNER JOIN Track B on (A.TrackId = B.TrackId)

-- 13. Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT A.*,B.Name TrackName,D.Name ArtistName FROM InvoiceLine A INNER JOIN Track B on (A.TrackId = B.TrackId) INNER JOIN Album C on (B.AlbumId = C.AlbumId) INNER JOIN Artist D on (C.ArtistId = D.ArtistId)

-- 14. Provide a query that shows the # of invoices per country. HINT: [GROUP BY](http://www.sqlite.org/lang_select.html#resultset)
SELECT BillingCountry, count(1) FROM Invoice GROUP BY BillingCountry

-- 15. Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resultant table.
SELECT A.PlaylistId,A.Name, COUNT(1) FROM Playlist A INNER JOIN PlaylistTrack B on (A.PlaylistId = B.PlaylistId) GROUP BY A.PlaylistId,A.Name

-- 16. Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.
SELECT A.Name,B.Title,C.Name,D.Name,Composer,Milliseconds,Bytes,UnitPrice FROM Track A INNER JOIN Album B on (A.AlbumId=B.AlbumId) INNER JOIN MediaType C on (A.MediaTypeId=C.MediaTypeId) INNER JOIN Genre D on (A.GenreId=D.GenreId)

-- 17. Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT A.InvoiceId,
CustomerId,
InvoiceDate,
BillingAddress,
BillingCity,
BillingState,
BillingCountry,
BillingPostalCode,
Total,COUNT(1) NumOfInvoiceLines FROM Invoice A INNER JOIN InvoiceLine B on (A.InvoiceId=B.InvoiceId) GROUP BY A.InvoiceId,
CustomerId,
InvoiceDate,
BillingAddress,
BillingCity,
BillingState,
BillingCountry,
BillingPostalCode,
Total

-- 18. Provide a query that shows total sales made by each sales agent.
SELECT C.FirstName||' '||C.LastName SalesAgent, sum(A.Total) TotalValue,COUNT(1) TotalSales FROM Invoice A INNER JOIN Customer B on (A.CustomerId=B.CustomerId) INNER JOIN Employee C on (B.SupportRepId = C.EmployeeId) GROUP BY C.FirstName||' '||C.LastName

-- 19. Which sales agent made the most in sales in 2009?
SELECT C.FirstName||' '||C.LastName SalesAgent, sum(A.Total) TotalValue,COUNT(1) TotalSales FROM Invoice A INNER JOIN Customer B on (A.CustomerId=B.CustomerId) INNER JOIN Employee C on (B.SupportRepId = C.EmployeeId) WHERE CAST(strftime('%Y',InvoiceDate) as INTEGER) = 2009 GROUP BY C.FirstName||' '||C.LastName ORDER BY 2 DESC LIMIT 0,1


-- 20. Which sales agent made the most in sales in 2010?
SELECT C.FirstName||' '||C.LastName SalesAgent, sum(A.Total) TotalValue,COUNT(1) TotalSales FROM Invoice A INNER JOIN Customer B on (A.CustomerId=B.CustomerId) INNER JOIN Employee C on (B.SupportRepId = C.EmployeeId) WHERE CAST(strftime('%Y',InvoiceDate) as INTEGER) = 2010 GROUP BY C.FirstName||' '||C.LastName ORDER BY 2 DESC LIMIT 0,1

-- 21. Which sales agent made the most in sales over all?
SELECT C.FirstName||' '||C.LastName SalesAgent, sum(A.Total) TotalValue,COUNT(1) TotalSales FROM Invoice A INNER JOIN Customer B on (A.CustomerId=B.CustomerId) INNER JOIN Employee C on (B.SupportRepId = C.EmployeeId) GROUP BY C.FirstName||' '||C.LastName ORDER BY 2 DESC LIMIT 0,1

-- 22. Provide a query that shows the # of customers assigned to each sales agent.
SELECT C.FirstName||' '||C.LastName SalesAgent,COUNT(1) TotalCustomers FROM Customer B INNER JOIN Employee C on (B.SupportRepId = C.EmployeeId) GROUP BY C.FirstName||' '||C.LastName

-- 23. Provide a query that shows the total sales per country. Which country's customers spent the most?
SELECT BillingCountry,sum(Total) FROM Invoice GROUP BY BillingCountry
order by sum(Total) desc

-- 24. Provide a query that shows the most purchased track of 2013.
SELECT B.TrackId,sum(B.Quantity) 
FROM Invoice A 
INNER JOIN InvoiceLine B on (A.InvoiceId=B.InvoiceId) 
WHERE CAST(strftime('%Y',InvoiceDate) as INTEGER) = 2013 
GROUP BY B.TrackId 
ORDER BY 2 DESC LIMIT 0,1

-- 25. Provide a query that shows the top 5 most purchased tracks over all.
SELECT B.TrackId,sum(B.UnitPrice*B.Quantity) FROM Invoice A INNER JOIN InvoiceLine B on (A.InvoiceId=B.InvoiceId) GROUP BY B.TrackId ORDER BY 2 DESC LIMIT 0,5

-- 26. Provide a query that shows the top 3 best selling artists.
SELECT E.Name ArtistName, sum(B.Quantity*B.UnitPrice)
FROM Invoice A 
INNER JOIN InvoiceLine B on (A.InvoiceId=B.InvoiceId) 
INNER JOIN Track C on (B.TrackId=C.TrackId) 
INNER JOIN Album D on (C.AlbumId = D.AlbumId) 
INNER JOIN Artist E on (D.ArtistId=E.ArtistId)  
GROUP BY E.Name
ORDER BY 2 DESC 
LIMIT 0,3

-- 27. Provide a query that shows the most purchased Media Type.
SELECT D.Name MediaTypeName, sum(B.Quantity*B.UnitPrice)
FROM Invoice A 
INNER JOIN InvoiceLine B on (A.InvoiceId=B.InvoiceId) 
INNER JOIN Track C on (B.TrackId=C.TrackId) 
INNER JOIN MediaType D on (C.MediaTypeId = D.MediaTypeId) 
GROUP BY D.Name
ORDER BY 2 DESC 
LIMIT 0,1


















