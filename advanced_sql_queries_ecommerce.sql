
-- 1. SELECT, WHERE, ORDER BY
SELECT o.OrderID, c.Name, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA'
ORDER BY o.OrderDate DESC;

-- 2. GROUP BY with SUM
SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantitySold
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantitySold DESC;

-- 3. INNER JOIN
SELECT o.OrderID, c.Name AS Customer, p.ProductName, od.Quantity
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID;

-- 4. LEFT JOIN
SELECT c.Name, o.OrderID, o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY c.Name;

-- 5. RIGHT JOIN
-- NOTE: RIGHT JOIN is not supported in SQLite, use only in MySQL or PostgreSQL
SELECT c.Name, o.OrderID, o.OrderDate
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 6. Subquery: Products with above average sales
SELECT ProductName
FROM Products
WHERE ProductID IN (
    SELECT ProductID
    FROM OrderDetails
    GROUP BY ProductID
    HAVING SUM(Quantity) > (
        SELECT AVG(TotalQty)
        FROM (
            SELECT SUM(Quantity) AS TotalQty
            FROM OrderDetails
            GROUP BY ProductID
        ) AS AvgSales
    )
);

-- 7. Create View: TopSellingProducts
CREATE VIEW TopSellingProducts AS
SELECT p.ProductName, SUM(od.Quantity) AS TotalSold
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalSold DESC;

-- 8. Create Index on OrderDate
CREATE INDEX idx_order_date ON Orders(OrderDate);
