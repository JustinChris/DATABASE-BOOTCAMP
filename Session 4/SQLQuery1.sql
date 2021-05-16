USE CoffeeShop

SELECT ht.TransactionID, c.CustomerName
FROM Customer as c, HeaderTransaction as ht
WHERE ht.CustomerID = c.CustomerID

SELECT *
FROM Customer as c
JOIN HeaderTransaction as ht on c.CustomerID = ht.CustomerID
JOIN DetailTransaction as dt on ht.TransactionID = dt.TransactionID