-- =====================================================
-- 01. CREATE DATABASE
-- Purpose:
-- Create a dedicated database for the manufacturing analysis project.
-- =====================================================

CREATE DATABASE manufacturing_analysis;
GO

USE manufacturing_analysis;
GO
-- =====================================================
-- 02. CREATE STAGING TABLE
-- Purpose:
-- Create a staging table with all columns stored as text.
-- This allows messy CSV data, blanks, and formatting issues
-- to be imported safely before type conversion.
-- =====================================================

DROP TABLE IF EXISTS manufacturing_staging;

CREATE TABLE manufacturing_staging (
    ProductionVolume NVARCHAR(100) NULL,
    ProductionCost NVARCHAR(100) NULL,
    SupplierQuality NVARCHAR(100) NULL,
    DeliveryDelay NVARCHAR(100) NULL,
    DefectRate NVARCHAR(100) NULL,
    QualityScore NVARCHAR(100) NULL,
    MaintenanceHours NVARCHAR(100) NULL,
    DowntimePercentage NVARCHAR(100) NULL,
    InventoryTurnover NVARCHAR(100) NULL,
    StockoutRate NVARCHAR(100) NULL,
    WorkerProductivity NVARCHAR(100) NULL,
    SafetyIncidents NVARCHAR(100) NULL,
    EnergyConsumption NVARCHAR(100) NULL,
    EnergyEfficiency NVARCHAR(100) NULL,
    AdditiveProcessTime NVARCHAR(100) NULL,
    AdditiveMaterialCost NVARCHAR(100) NULL,
    DefectStatus NVARCHAR(100) NULL
);
-- =====================================================
-- 03. VERIFY STAGING IMPORT
-- Purpose:
-- Confirm that the CSV was successfully imported into the staging table.
-- =====================================================

SELECT 
    COUNT(*) AS staging_rows
FROM manufacturing_staging;
-- =====================================================
-- 04. PREVIEW STAGING DATA
-- Purpose:
-- Inspect a sample of imported rows before conversion.
-- =====================================================

SELECT TOP 10 *
FROM manufacturing_staging;
-- =====================================================
-- 05. CREATE CLEAN FINAL TABLE
-- Purpose:
-- Convert the staging table into a clean numeric table using TRY_CAST.
-- NULLIF handles blank strings, while TRY_CAST prevents conversion
-- errors from breaking the workflow.
-- =====================================================

DROP TABLE IF EXISTS manufacturing_data;

SELECT
    TRY_CAST(NULLIF(ProductionVolume, '') AS FLOAT) AS ProductionVolume,
    TRY_CAST(NULLIF(ProductionCost, '') AS FLOAT) AS ProductionCost,
    TRY_CAST(NULLIF(SupplierQuality, '') AS FLOAT) AS SupplierQuality,
    TRY_CAST(NULLIF(DeliveryDelay, '') AS FLOAT) AS DeliveryDelay,
    TRY_CAST(NULLIF(DefectRate, '') AS FLOAT) AS DefectRate,
    TRY_CAST(NULLIF(QualityScore, '') AS FLOAT) AS QualityScore,
    TRY_CAST(NULLIF(MaintenanceHours, '') AS FLOAT) AS MaintenanceHours,
    TRY_CAST(NULLIF(DowntimePercentage, '') AS FLOAT) AS DowntimePercentage,
    TRY_CAST(NULLIF(InventoryTurnover, '') AS FLOAT) AS InventoryTurnover,
    TRY_CAST(NULLIF(StockoutRate, '') AS FLOAT) AS StockoutRate,
    TRY_CAST(NULLIF(WorkerProductivity, '') AS FLOAT) AS WorkerProductivity,
    TRY_CAST(NULLIF(SafetyIncidents, '') AS FLOAT) AS SafetyIncidents,
    TRY_CAST(NULLIF(EnergyConsumption, '') AS FLOAT) AS EnergyConsumption,
    TRY_CAST(NULLIF(EnergyEfficiency, '') AS FLOAT) AS EnergyEfficiency,
    TRY_CAST(NULLIF(AdditiveProcessTime, '') AS FLOAT) AS AdditiveProcessTime,
    TRY_CAST(NULLIF(AdditiveMaterialCost, '') AS FLOAT) AS AdditiveMaterialCost,
    TRY_CAST(NULLIF(DefectStatus, '') AS INT) AS DefectStatus
INTO manufacturing_data
FROM manufacturing_staging;
-- =====================================================
-- 06. VERIFY FINAL CLEAN TABLE
-- Purpose:
-- Confirm that the final typed table contains the same number of rows
-- as the staging table after conversion.
-- =====================================================

SELECT 
    COUNT(*) AS final_rows
FROM manufacturing_data;
-- =====================================================
-- 07. PREVIEW FINAL CLEAN DATA
-- Purpose:
-- Inspect the final typed table after conversion.
-- =====================================================

SELECT TOP 10 *
FROM manufacturing_data;
