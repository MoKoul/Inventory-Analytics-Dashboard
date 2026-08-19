TRUNCATE TABLE dbo.FactInventory;
GO

INSERT INTO dbo.FactInventory (
    DateKey, SKUKey, WarehouseKey, SupplierKey, RegionKey,
    UnitsSold, InventoryLevel, SupplierLeadTimeDays, ReorderPoint,
    OrderQuantity, UnitCost, UnitPrice, IsPromotion, StockoutFlagRaw,
    DemandForcast, ReorderBreach, ForecastError, AbsPctError, Margin, MarginPct
)
SELECT
    d.DateKey,
    s.SKUKey,
    w.WarehouseKey,
    sup.SupplierKey,
    r.RegionKey,

    stg.units_sold,
    stg.inventory_level,
    stg.supplier_lead_time_days,
    stg.reorder_point,
    stg.order_quantity,
    stg.unit_cost,
    stg.unit_price,
    stg.is_promotion,
    stg.stockout_flag_raw,
    stg.demand_forecast,
    stg.reorder_breach,
    stg.forecast_error,
    stg.abs_pct_error,
    stg.margin,
    stg.margin_pct
FROM dbo.stg_inventory stg 
INNER JOIN dbo.DimDate d ON d.FullDate = CAST(stg.sale_date AS DATE)
INNER JOIN dbo.DimSKU s ON s.SKU_ID = stg.sku_id
INNER JOIN dbo.DimWarehouse w ON w.Warehouse_ID = stg.warehouse_id
INNER JOIN dbo.DimSupplier sup ON sup.Supplier_ID = stg.supplier_id
INNER JOIN dbo.DimRegion  r  ON  r.Region = stg.region;
GO