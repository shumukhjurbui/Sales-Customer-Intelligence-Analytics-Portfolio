USE Sales_DataWarehouse;
GO

SELECT 
    SUM(Revenue) AS Total_Sales,
    COUNT(DISTINCT OrderID) AS Total_Orders,
    AVG(Revenue) AS Average_Order_Value
FROM FactSales;

USE Sales_DataWarehouse;
GO

SELECT 
    p.ProductName,
    p.Category,
    SUM(f.Quantity) AS Total_Qty_Sold,
    SUM(f.Revenue) AS Total_Revenue
FROM FactSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.ProductName, p.Category
ORDER BY Total_Revenue DESC;

USE Sales_DataWarehouse;
GO

SELECT 
    s.City,
    s.StoreName,
    SUM(f.Revenue) AS Total_Sales
FROM FactSales f
JOIN DimStore s ON f.StoreKey = s.StoreKey
GROUP BY s.City, s.StoreName
ORDER BY Total_Sales DESC;

USE Sales_DataWarehouse;
GO


SELECT 
    c.CustomerName,
    SUM(f.Revenue) AS Customer_Spend,
    RANK() OVER (ORDER BY SUM(f.Revenue) DESC) AS Customer_Rank
FROM FactSales f
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.CustomerName;

USE Sales_DataWarehouse;
GO

CREATE OR ALTER VIEW vw_DetailedSalesSummary AS
SELECT 
    f.OrderID,
    c.CustomerName,
    p.ProductName,
    s.StoreName,
    f.Quantity,
    f.Revenue
FROM FactSales f
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
JOIN DimProduct p ON f.ProductKey = p.ProductKey
JOIN DimStore s ON f.StoreKey = s.StoreKey;
GO

SELECT TOP 100 * FROM vw_DetailedSalesSummary;


USE Sales_DataWarehouse;
GO

CREATE OR ALTER PROCEDURE GetSalesByCategory
    @CategoryName VARCHAR(50)
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(f.Revenue) AS Category_Revenue
    FROM FactSales f
    JOIN DimProduct p ON f.ProductKey = p.ProductKey
    WHERE p.Category = @CategoryName
    GROUP BY p.ProductName
    ORDER BY Category_Revenue DESC;
END;
GO

EXEC GetSalesByCategory 'Electronics';
