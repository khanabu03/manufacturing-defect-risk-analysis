-- =====================================================
-- 01. ROW COUNT VALIDATION
-- Purpose:
-- Confirm that the final cleaned table contains the expected
-- number of records after importing through the staging table.
-- =====================================================

SELECT 
    COUNT(*) AS total_rows
FROM manufacturing_data;
-- =====================================================
-- 02. NULL VALUE CHECK
-- Purpose:
-- Verify that key operational and quality columns do not contain
-- missing values after import and type conversion.
-- =====================================================

SELECT
    SUM(CASE WHEN ProductionVolume IS NULL THEN 1 ELSE 0 END) AS null_production_volume,
    SUM(CASE WHEN ProductionCost IS NULL THEN 1 ELSE 0 END) AS null_production_cost,
    SUM(CASE WHEN DefectRate IS NULL THEN 1 ELSE 0 END) AS null_defect_rate,
    SUM(CASE WHEN DowntimePercentage IS NULL THEN 1 ELSE 0 END) AS null_downtime_percentage,
    SUM(CASE WHEN StockoutRate IS NULL THEN 1 ELSE 0 END) AS null_stockout_rate,
    SUM(CASE WHEN DefectStatus IS NULL THEN 1 ELSE 0 END) AS null_defect_status
FROM manufacturing_data;
-- =====================================================
-- 03. NUMERIC RANGE CHECK
-- Purpose:
-- Check the minimum and maximum values for major numeric columns
-- to confirm that the dataset contains reasonable operational ranges
-- and no obvious outliers caused by import or conversion issues.
-- =====================================================

SELECT
    MIN(DefectRate) AS min_defect_rate,
    MAX(DefectRate) AS max_defect_rate,
    MIN(DowntimePercentage) AS min_downtime,
    MAX(DowntimePercentage) AS max_downtime,
    MIN(QualityScore) AS min_quality_score,
    MAX(QualityScore) AS max_quality_score,
    MIN(WorkerProductivity) AS min_worker_productivity,
    MAX(WorkerProductivity) AS max_worker_productivity,
    MIN(ProductionVolume) AS min_production_volume,
    MAX(ProductionVolume) AS max_production_volume,
    MIN(ProductionCost) AS min_production_cost,
    MAX(ProductionCost) AS max_production_cost
FROM manufacturing_data;
-- =====================================================
-- 04. DEFECT STATUS DISTRIBUTION
-- Purpose:
-- Confirm that DefectStatus contains valid binary values only
-- and check the balance between non-defective and defective records.
-- =====================================================

SELECT
    DefectStatus,
    COUNT(*) AS records
FROM manufacturing_data
GROUP BY DefectStatus
ORDER BY DefectStatus;
