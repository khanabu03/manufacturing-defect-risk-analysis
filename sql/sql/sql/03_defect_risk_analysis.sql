-- =====================================================
-- 01. DEFECTIVE VS NON-DEFECTIVE OPERATING CONDITIONS
-- Purpose:
-- Compare operational metrics between non-defective and defective
-- production records to identify which conditions differ most when
-- defects occur.
-- =====================================================

SELECT
    DefectStatus,
    COUNT(*) AS records,
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
    ROUND(AVG(AdditiveMaterialCost), 2) AS avg_additive_material_cost
FROM manufacturing_data
GROUP BY DefectStatus
ORDER BY DefectStatus;
-- =====================================================
-- 02. DEFECT RISK BY PRODUCTION VOLUME BAND
-- Purpose:
-- Test whether higher production volume is associated with
-- increased defect risk by grouping records into volume bands.
-- =====================================================

SELECT
    CASE
        WHEN ProductionVolume < 400 THEN 'Low Volume'
        WHEN ProductionVolume < 700 THEN 'Medium Volume'
        ELSE 'High Volume'
    END AS production_volume_band,
    COUNT(*) AS records,
    ROUND(AVG(ProductionVolume), 2) AS avg_production_volume,
    ROUND(AVG(DefectRate), 2) AS avg_defect_rate,
    ROUND(AVG(QualityScore), 2) AS avg_quality_score,
    ROUND(AVG(MaintenanceHours), 2) AS avg_maintenance_hours,
    ROUND(
        100.0 * SUM(CASE WHEN DefectStatus = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS defect_status_rate
FROM manufacturing_data
GROUP BY
    CASE
        WHEN ProductionVolume < 400 THEN 'Low Volume'
        WHEN ProductionVolume < 700 THEN 'Medium Volume'
        ELSE 'High Volume'
    END
ORDER BY defect_status_rate DESC;
-- =====================================================
-- 03. DEFECT RISK BY MAINTENANCE HOURS BAND
-- Purpose:
-- Test whether higher maintenance hours are associated with
-- increased defect risk by grouping records into maintenance bands.
-- =====================================================

SELECT
    CASE
        WHEN MaintenanceHours < 8 THEN 'Low Maintenance'
        WHEN MaintenanceHours < 14 THEN 'Medium Maintenance'
        ELSE 'High Maintenance'
    END AS maintenance_band,
    COUNT(*) AS records,
    ROUND(AVG(MaintenanceHours), 2) AS avg_maintenance_hours,
    ROUND(AVG(ProductionVolume), 2) AS avg_production_volume,
    ROUND(AVG(DefectRate), 2) AS avg_defect_rate,
    ROUND(AVG(QualityScore), 2) AS avg_quality_score,
    ROUND(
        100.0 * SUM(CASE WHEN DefectStatus = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS defect_status_rate
FROM manufacturing_data
GROUP BY
    CASE
        WHEN MaintenanceHours < 8 THEN 'Low Maintenance'
        WHEN MaintenanceHours < 14 THEN 'Medium Maintenance'
        ELSE 'High Maintenance'
    END
ORDER BY defect_status_rate DESC;
-- =====================================================
-- 04. DEFECT RISK BY QUALITY SCORE BAND
-- Purpose:
-- Test whether lower quality scores are associated with increased
-- defect risk by grouping production records into quality score bands.
-- =====================================================

SELECT
    CASE
        WHEN QualityScore < 75 THEN 'Low Quality Score'
        WHEN QualityScore < 90 THEN 'Medium Quality Score'
        ELSE 'High Quality Score'
    END AS quality_score_band,
    COUNT(*) AS records,
    ROUND(AVG(QualityScore), 2) AS avg_quality_score,
    ROUND(AVG(ProductionVolume), 2) AS avg_production_volume,
    ROUND(AVG(MaintenanceHours), 2) AS avg_maintenance_hours,
    ROUND(AVG(DefectRate), 2) AS avg_defect_rate,
    ROUND(
        100.0 * SUM(CASE WHEN DefectStatus = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS defect_status_rate
FROM manufacturing_data
GROUP BY
    CASE
        WHEN QualityScore < 75 THEN 'Low Quality Score'
        WHEN QualityScore < 90 THEN 'Medium Quality Score'
        ELSE 'High Quality Score'
    END
ORDER BY defect_status_rate DESC;
-- =====================================================
-- 05. DEFECT RISK BY DOWNTIME PERCENTAGE BAND
-- Purpose:
-- Test whether higher downtime percentage is associated with
-- increased defect risk by grouping production records into
-- downtime percentage bands.
-- =====================================================

SELECT
    CASE
        WHEN DowntimePercentage < 1.5 THEN 'Low Downtime'
        WHEN DowntimePercentage < 3.5 THEN 'Medium Downtime'
        ELSE 'High Downtime'
    END AS downtime_band,
    COUNT(*) AS records,
    ROUND(AVG(DowntimePercentage), 2) AS avg_downtime_percentage,
    ROUND(AVG(ProductionVolume), 2) AS avg_production_volume,
    ROUND(AVG(MaintenanceHours), 2) AS avg_maintenance_hours,
    ROUND(AVG(QualityScore), 2) AS avg_quality_score,
    ROUND(AVG(DefectRate), 2) AS avg_defect_rate,
    ROUND(
        100.0 * SUM(CASE WHEN DefectStatus = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS defect_status_rate
FROM manufacturing_data
GROUP BY
    CASE
        WHEN DowntimePercentage < 1.5 THEN 'Low Downtime'
        WHEN DowntimePercentage < 3.5 THEN 'Medium Downtime'
        ELSE 'High Downtime'
    END
ORDER BY defect_status_rate DESC;
-- =====================================================
-- 06. DEFECT RISK BY SUPPLIER QUALITY BAND
-- Purpose:
-- Test whether supplier quality is associated with defect risk
-- by grouping production records into supplier quality bands.
-- =====================================================

SELECT
    CASE
        WHEN SupplierQuality < 85 THEN 'Low Supplier Quality'
        WHEN SupplierQuality < 95 THEN 'Medium Supplier Quality'
        ELSE 'High Supplier Quality'
    END AS supplier_quality_band,
    COUNT(*) AS records,
    ROUND(AVG(SupplierQuality), 2) AS avg_supplier_quality,
    ROUND(AVG(DefectRate), 2) AS avg_defect_rate,
    ROUND(AVG(QualityScore), 2) AS avg_quality_score,
    ROUND(AVG(ProductionVolume), 2) AS avg_production_volume,
    ROUND(AVG(MaintenanceHours), 2) AS avg_maintenance_hours,
    ROUND(
        100.0 * SUM(CASE WHEN DefectStatus = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS defect_status_rate
FROM manufacturing_data
GROUP BY
    CASE
        WHEN SupplierQuality < 85 THEN 'Low Supplier Quality'
        WHEN SupplierQuality < 95 THEN 'Medium Supplier Quality'
        ELSE 'High Supplier Quality'
    END
ORDER BY defect_status_rate DESC;
-- =====================================================
-- 07. DEFECT RISK BY WORKER PRODUCTIVITY BAND
-- Purpose:
-- Test whether worker productivity is associated with defect risk
-- by grouping production records into productivity bands.
-- =====================================================

SELECT
    CASE
        WHEN WorkerProductivity < 87 THEN 'Low Productivity'
        WHEN WorkerProductivity < 94 THEN 'Medium Productivity'
        ELSE 'High Productivity'
    END AS productivity_band,
    COUNT(*) AS records,
    ROUND(AVG(WorkerProductivity), 2) AS avg_worker_productivity,
    ROUND(AVG(ProductionVolume), 2) AS avg_production_volume,
    ROUND(AVG(QualityScore), 2) AS avg_quality_score,
    ROUND(AVG(MaintenanceHours), 2) AS avg_maintenance_hours,
    ROUND(AVG(DefectRate), 2) AS avg_defect_rate,
    ROUND(
        100.0 * SUM(CASE WHEN DefectStatus = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS defect_status_rate
FROM manufacturing_data
GROUP BY
    CASE
        WHEN WorkerProductivity < 87 THEN 'Low Productivity'
        WHEN WorkerProductivity < 94 THEN 'Medium Productivity'
        ELSE 'High Productivity'
    END
ORDER BY defect_status_rate DESC;
