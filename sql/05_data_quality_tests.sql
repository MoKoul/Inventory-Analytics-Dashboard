-- =============================================
-- Data Quality Tests
-- =============================================

-- 1. Orphaned records in Fact (missing Date)
SELECT f.*
FROM dbo.FactInventory f  
LEFT JOIN dbo.DimDate d ON f.DateKey=d.DateKey
WHERE d.DateKey IS NULL;

-- 2. Orphaned SKU
SELECT f.*
FROM dbo.FactInventory f  
LEFT JOIN dbo.DimSKU s ON f.SKUKey = s.SKUKey
WHERE s.SKUKey IS NULL;

-- 3. Orpaned Warehouse
SELECT f.*
FROM dbo.FactInventory f 
LEFT JOIN dbo.DimWarehouse w    ON f.WarehouseKey = w.WarehouseKey
WHERE w.WarehouseKey IS NULL;

-- 4. Orphaned Supplier
SELECT f.*
FROM   dbo.FactInventory f    
LEFT JOIN dbo.DimSupplier s ON f.SupplierKey =  s.SupplierKey
WHERE s.SupplierKey IS NULL;

-- 5. orphaned Region
SELECT f.*
FROM dbo.FactInventory f  
LEFT JOIN dbo.DimRegion r  ON f.RegionKey = r.RegionKey
WHERE r.RegionKey IS NULL;

-- 6. Duplicate check in Fact (should be unique by Date + SKU + Warehouse)
SELECT DateKey, SKUKey, WarehouseKey, COUNT(*) AS cnt    
FROM dbo.FactInventory 
GROUP BY DateKey, SKUKey, WarehouseKey 
HAVING COUNT(*) > 1;

-- 7. Row-count parity check
SELECT
    (SELECT COUNT(*) FROM dbo.stg_inventory) AS staging_count,
    (SELECT COUNT(*) FROM dbo.FactInventory) AS fact_count;


