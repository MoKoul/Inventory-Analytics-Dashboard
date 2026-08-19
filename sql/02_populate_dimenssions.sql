-- ====================================
-- 1. Populate DimDate
-- ====================================
TRUNCATE TABLE dbo.DimDate;
GO

WITH DateSeries AS (
    SELECT CAST('2024-01-01' AS DATE) AS FullDate
    UNION ALL
    SELECT DATEADD(DAY,   1 , FullDate) 
    FROM DateSeries
    WHERE   FullDate < '2024-12-30'
)
INSERT INTO dbo.DimDate (
    DateKey, FullDate, DayOfMonth, DayName, DayOfWeek, WeekOfYear, 
     MonthNumber, MonthName, Quarter, Year, IsWeekend
)
SELECT
    CONVERT(INT, CONVERT(VARCHAR(8), FullDate, 112)) AS DateKey,
    FullDate,
    DAY(FullDate) AS DayOfMonth,
    DATENAME(WEEKDAY, FullDate)  AS DayName,
    DATEPART(WEEKDAY, FullDate) AS DayOfWeek,
    DATEPART(WEEK, FullDate) AS WeekOfYear,
    MONTH(FullDate) AS MonthNumber,
    DATENAME(MONTH, FullDate) AS MonthName,
    DATEPART(QUARTER, FullDate)  AS Quarter,
    DATEPART(YEAR, FullDate) AS Year, 
    CASE WHEN DATEPART(WEEKDAY, FullDate) IN (1, 7) THEN 1 ELSE 0 END AS IsWeekend
FROM DateSeries
Option (MAXRECURSION 365);
GO  

-- ====================================
-- 2. Populate DimSKU
-- ====================================
TRUNCATE TABLE DimSKU;
GO

INSERT INTO dbo.DimSKU (SKU_ID)
SELECT  DISTINCT  sku_id
FROM dbo.stg_inventory
WHERE   sku_id IS NOT NULL;
GO

-- ====================================
-- 3. Populate DimWarehouse
-- ====================================
TRUNCATE TABLE dbo.DimWarehouse;
GO

INSERT INTO     dbo.DimWarehouse (Warehouse_ID)
SELECT DISTINCT   warehouse_id 
FROM dbo.stg_inventory
WHERE warehouse_id  IS NOT NULL;
GO

-- ====================================
-- 4. Populate DimSupplier
-- ====================================
TRUNCATE TABLE DimSupplier;
GO

INSERT INTO dbo.DimSupplier (Supplier_ID)
SELECT DISTINCT supplier_id
FROM dbo.stg_inventory
WHERE supplier_id  IS NOT NULL;
GO

-- ====================================
-- 5. Populate DimSupplier
-- ====================================
TRUNCATE TABLE dbo.DimRegion;
GO

INSERT INTO dbo.DimRegion (Region)
SELECT  DISTINCT region
FROM dbo.stg_inventory
WHERE region IS NOT NULL;
GO



