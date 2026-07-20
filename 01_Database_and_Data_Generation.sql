-- 1. CREATE DATABASE FROM SCRATCH
-- نقوم بإنشاء قاعدة البيانات أولاً إذا لم تكن موجودة
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Sales_DataWarehouse')
BEGIN
    CREATE DATABASE Sales_DataWarehouse;
END
GO

USE Sales_DataWarehouse;
GO

-- 2. DROP TABLES IF THEY EXIST TO START FRESH
-- هذا الجزء يمنع الأخطاء إذا كانت الجداول موجودة مسبقاً
IF OBJECT_ID('FactSales', 'U') IS NOT NULL DROP TABLE FactSales;
IF OBJECT_ID('DimCustomer', 'U') IS NOT NULL DROP TABLE DimCustomer;
IF OBJECT_ID('DimProduct', 'U') IS NOT NULL DROP TABLE DimProduct;
IF OBJECT_ID('DimStore', 'U') IS NOT NULL DROP TABLE DimStore;
IF OBJECT_ID('DimDate', 'U') IS NOT NULL DROP TABLE DimDate;
GO

-- 3. CREATE DIMENSION TABLES (ENGLISH)
CREATE TABLE DimCustomer (
    CustomerKey INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100),
    City NVARCHAR(50)
);

CREATE TABLE DimProduct (
    ProductKey INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100),
    Category NVARCHAR(50)
);

CREATE TABLE DimStore (
    StoreKey INT PRIMARY KEY IDENTITY(1,1),
    StoreName NVARCHAR(100),
    City NVARCHAR(50)
);

CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY, -- Format: YYYYMMDD (e.g., 20260101)
    FullDate DATE,
    Month INT,
    Year INT
);

-- 4. CREATE FACT TABLE
CREATE TABLE FactSales (
    SaleKey INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT, 
    DateKey INT REFERENCES DimDate(DateKey),
    CustomerKey INT REFERENCES DimCustomer(CustomerKey),
    ProductKey INT REFERENCES DimProduct(ProductKey),
    StoreKey INT REFERENCES DimStore(StoreKey),
    Quantity INT,
    Revenue DECIMAL(18, 2)
);
GO

-- 5. INSERT DIMENSIONS DATA
INSERT INTO DimCustomer (CustomerName, City) VALUES 
('Sara Ahmed', 'Riyadh'), ('Mohamed Ali', 'Jeddah'), ('Fahad Al-Majed', 'Riyadh'), 
('Amal Abdullah', 'Dammam'), ('Khaled Hassan', 'Riyadh'), ('Noura Sultan', 'Jeddah'),
('Abdulrahman Fahad', 'Dammam'), ('Haifa Mohamed', 'Riyadh'), ('Sultan Khaled', 'Jeddah'),
('Reem Abdulaziz', 'Dammam');

INSERT INTO DimProduct (ProductName, Category) VALUES 
('iPhone 15', 'Electronics'), ('Samsung Screen', 'Electronics'), ('Smart Watch', 'Electronics'),
('Sports Shirt', 'Clothing'), ('Running Shoes', 'Clothing'), ('Jeans Pants', 'Clothing'),
('Office Desk', 'Furniture'), ('Ergonomic Chair', 'Furniture'), ('Smart Lamp', 'Furniture');

INSERT INTO DimStore (StoreName, City) VALUES 
('Olaya Branch', 'Riyadh'), 
('Tahliyah Branch', 'Jeddah'), 
('Shatea Branch', 'Dammam');
GO

-- 6. GENERATE 365 DAYS FOR YEAR 2026 IN DIMDATE
DECLARE @StartDate DATE = '2026-01-01';
WHILE @StartDate <= '2026-12-31'
BEGIN
    INSERT INTO DimDate (DateKey, FullDate, Month, Year)
    VALUES (
        CAST(FORMAT(@StartDate, 'yyyyMMdd') AS INT),
        @StartDate,
        MONTH(@StartDate),
        YEAR(@StartDate)
    );
    SET @StartDate = DATEADD(day, 1, @StartDate);
END;
GO

-- 7. THE LOOP TO GENERATE 10,000 RANDOM SALES ROWS
SET NOCOUNT ON;
DECLARE @Counter INT = 1;
DECLARE @RandomDateKey INT;
DECLARE @RandomCustomerKey INT;
DECLARE @RandomProductKey INT;
DECLARE @RandomStoreKey INT;
DECLARE @RandomQuantity INT;
DECLARE @RandomRevenue DECIMAL(18,2);
DECLARE @RandomOrderID INT;

WHILE @Counter <= 10000
BEGIN
    -- Select a random DateKey from DimDate
    SELECT TOP 1 @RandomDateKey = DateKey FROM DimDate ORDER BY NEWID();
    
    -- Generate random keys based on dimensions count
    SET @RandomCustomerKey = (ABS(CHECKSUM(NEWID())) % 10) + 1;
    SET @RandomProductKey = (ABS(CHECKSUM(NEWID())) % 9) + 1;
    SET @RandomStoreKey = (ABS(CHECKSUM(NEWID())) % 3) + 1;
    SET @RandomQuantity = (ABS(CHECKSUM(NEWID())) % 5) + 1;
    SET @RandomOrderID = 50000 + (ABS(CHECKSUM(NEWID())) % 20000);

    -- Realistic pricing logic based on category
    IF @RandomProductKey IN (1, 2, 3) -- Electronics
        SET @RandomRevenue = @RandomQuantity * ((ABS(CHECKSUM(NEWID())) % 1500) + 500);
    ELSE IF @RandomProductKey IN (4, 5, 6) -- Clothing
        SET @RandomRevenue = @RandomQuantity * ((ABS(CHECKSUM(NEWID())) % 150) + 50);
    ELSE -- Furniture
        SET @RandomRevenue = @RandomQuantity * ((ABS(CHECKSUM(NEWID())) % 400) + 150);

    -- Insert into Fact table
    INSERT INTO FactSales (OrderID, DateKey, CustomerKey, ProductKey, StoreKey, Quantity, Revenue)
    VALUES (@RandomOrderID, @RandomDateKey, @RandomCustomerKey, @RandomProductKey, @RandomStoreKey, @RandomQuantity, @RandomRevenue);

    SET @Counter = @Counter + 1;
END;
PRINT 'Database created and 10,000 rows successfully generated in English!';
GO


