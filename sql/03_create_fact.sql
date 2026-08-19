IF OBJECT_ID('dbo.FactInventory', 'U') IS NOT NULL DROP TABLE dbo.FactInventory;
GO

CREATE TABLE dbo.FactInventory(
    InventoryKey            BIGINT  IDENTITY(1, 1)          NOT NULL,

    -- Foreing Keys
    DateKey                 INT                             NOT NULL,
    SKUKey                  INT                             NOT NULL,
    WarehouseKey            INT                             NOT NULL,
    SupplierKey             INT                             NOT NULL,
    RegionKey               INT                             NOT NULL,


    -- Measures
    UnitsSold               INT                             NULL,
    InventoryLevel          INT                             NULL,
    SupplierLeadTimeDays    INT                             NULL,
    ReorderPoint            INT                             NULL,
    OrderQuantity           INT                             NULL,
    UnitCost                DECIMAL(10, 2)                  NULL,
    UnitPrice               DECIMAL(10, 2)                  NULL,
    IsPromotion             TINYINT                         NULL,
    StockoutFlagRaw         TINYINT                         NULL,
    DemandForcast           DECIMAL(10, 2)                  NULL,
    ReorderBreach           TINYINT                         NULL,
    ForecastError           DECIMAL(10, 2)                  NULL,
    AbsPctError             DECIMAL(10, 4)                  NULL,
    Margin                  DECIMAL(10, 2)                  NULL,
    MarginPct               DECIMAL(10, 4)                  NULL,

    CONSTRAINT  PK_FactInventory PRIMARY KEY    CLUSTERED (InventoryKey)
);
GO

-- Foreign Keys Constraints
ALTER TABLE dbo.FactInventory
ADD CONSTRAINT  FK_FactInventory_DimDate
    FOREIGN KEY (DateKey) REFERENCES dbo.DimDate(DateKey);
GO

ALTER TABLE dbo.FactInventory
ADD CONSTRAINT  FK_FactInventory_DimSKU
    FOREIGN KEY (SKUKey) REFERENCES dbo.DimSKU(SKUKey);
GO

ALTER TABLE dbo.FactInventory
ADD CONSTRAINT FK_FactInventory_DimWarehouse
    FOREIGN KEY (WarehouseKey) REFERENCES dbo.DimWarehouse(WarehouseKey);
GO

ALTER TABLE dbo.FactInventory
ADD CONSTRAINT FK_FactInventory_DimSupplier
    FOREIGN KEY (SupplierKey) REFERENCES dbo.DimSupplier(SupplierKey);
GO

ALTER TABLE dbo.FactInventory
ADD CONSTRAINT FK_FactInventory_DimRegion
    FOREIGN KEY (RegionKey) REFERENCES dbo.DimRegion(RegionKey);
GO

-- Explicit Indexes on Foreign Keys (performance)
CREATE NONCLUSTERED INDEX IX_FactInventory_DateKey       ON dbo.FactInventory(DateKey);
CREATE NONCLUSTERED INDEX IX_FactInventory_SKUKey        ON dbo.FactInventory(SKUKey);
CREATE NONCLUSTERED INDEX IX_FactInventory_WarehouseKey  ON dbo.FactInventory(WarehouseKey);
CREATE NONCLUSTERED INDEX IX_FactInventory_SupplierKey   ON dbo.FactInventory(SupplierKey);
CREATE NONCLUSTERED INDEX IX_FactInventory_RegionKey     ON dbo.FactInventory(RegionKey);
GO



