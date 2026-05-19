-- =====================================================
-- 01. OVERALL MANUFACTURING PERFORMANCE BASELINE
-- Purpose:
-- Calculate the main operational baseline metrics across all records,
-- including production volume, cost, quality, downtime, productivity,
-- energy efficiency, and overall defect status rate.
-- =====================================================

SELECT
    COUNT(*) AS total_records,
    ROUND(AVG(ProductionVolume), 2) AS avg_production_volume,
    ROUND(AVG(ProductionCost), 2) AS avg_production_cost,
    ROUND(AVG(SupplierQuality), 2) AS avg_supplier_quality,
    ROUND(AVG(DeliveryDelay), 2) AS avg_delivery_delay,
    ROUND(AVG(DefectRate), 2) AS avg_defect_rate,
    ROUND(AVG(QualityScore), 2) AS avg_quality_score,
    ROUND(AVG(MaintenanceHours), 2) AS avg_maintenance_hours,
    ROUND(AVG(DowntimePercentage), 2) AS avg_downtime_percentage,
    ROUND(AVG(InventoryTurnover), 2) AS avg_inventory_turnover,
    ROUND(AVG(StockoutRate), 2) AS avg_stockout_rate,
    ROUND(AVG(WorkerProductivity), 2) AS avg_worker_productivity,
    ROUND(AVG(SafetyIncidents), 2) AS avg_safety_incidents,
    ROUND(AVG(EnergyConsumption), 2) AS avg_energy_consumption,
    ROUND(AVG(EnergyEfficiency), 2) AS avg_energy_efficiency,
    ROUND(AVG(AdditiveProcessTime), 2) AS avg_additive_process_time,
    ROUND(AVG(AdditiveMaterialCost), 2) AS avg_additive_material_cost,
    ROUND(
        100.0 * SUM(CASE WHEN DefectStatus = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS defect_status_rate
FROM manufacturing_data;
