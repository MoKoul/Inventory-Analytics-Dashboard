IF OBJECT_ID('dbo.FactInventory', 'U') IS NOT NULL DROP TABLE dbo.FactInventory;
GO

-- =============================================
-- 1. DimDate
-- =============================================
IF  OBJECT_ID('dbo.DimDate', 'U') IS NOT NULL DROP TABLE dbo.DimDate;
GO

CREATE table dbo.DimDate (
    DateKey         INT             NOT NULL,        -- YYYYMMDD
    FullDate        DATE            NOT NULL,
    DayOfMonth      TINYINT         NOT NULL,
    DayName         VARCHAR(10)     NOT NULL,
    DayOfWeek       TINYINT         NOT NULL,
    WeekOfYear      TINYINT         NOT NULL,
    MonthNumber     TINYINT         NOT NULL,
    MonthName       VARCHAR(10)     NOT NULL,
    Quarter         TINYINT         NOT NULL,
    Year            SMALLINT        NOT NULL,
    IsWeekend       TINYINT         NOT NULL,

    CONSTRAINT PK_DimDate PRIMARY KEY CLUSTERED (DateKey)
);
GO

-- =============================================
-- 2. DimSKU
-- =============================================
IF OBJECT_ID('dbo.DimSKU', 'U') IS NOT NULL DROP TABLE dbo.DimSKU;
GO

CREATE TABLE DimSKU (
    SKUKey          INT IDENTITY(1,1)       NOT NULL,
    SKU_ID          VARCHAR(20)             NOT NULL,

    CONSTRAINT PK_DimSKU    PRIMARY KEY    CLUSTERED (SKUKey),
    CONSTRAINT UQ_DimSKU_ID     UNIQUE  (SKU_ID)
);
GO 

-- =============================================
-- 3. DimWarehouse
-- =============================================
IF OBJECT_ID('dbo.DimWarehouse', 'U') IS NOT NULL DROP TABLE dbo.DimWarehouse;
GO

CREATE TABLE DimWarehouse(
    WarehouseKey        INT   IDENTITY(1,1)          NOT NULL,
    Warehouse_ID        VARCHAR(20)                  NOT NULL,

    CONSTRAINT PK_DimWarhouse   PRIMARY KEY     CLUSTERED (WarehouseKey),
    CONSTRAINT UQ_DimWarehouse_ID   UNIQUE  (Warehouse_ID)
);
GO 

-- =============================================
-- 4. DimSupplier
-- =============================================
IF OBJECT_ID('dbo.DimSupplier', 'U')    IS NOT NULL DROP TABLE dbo.DimSupplier;
GO

CREATE TABLE DimSupplier(
    SupplierKey     INT IDENTITY(1, 1)          NOT NULL,
    Supplier_ID     VARCHAR(20)                 NOT NULL,

    CONSTRAINT  PK_DimSupplier  PRIMARY KEY CLUSTERED (SupplierKey),
    CONSTRAINT  UQ_DimSupplier_ID   UNIQUE      (Supplier_ID)
);
GO 

-- =============================================
-- 5. DimSupplier
-- =============================================
if OBJECT_ID('dbo.DimRegion', 'U')  IS NOT NULL DROP TABLE Dimregion;
GO

CREATE TABLE DimRegion(
    RegionKey       INT     IDENTITY(1, 1)  NOT NULL,
    Region          VARCHAR(20)             NOT NULL,

    CONSTRAINT PK_DimRegion     PRIMARY KEY     CLUSTERED (RegionKey),
    CONSTRAINT UQ_DimRegion     UNIQUE      (Region)
);
GO


