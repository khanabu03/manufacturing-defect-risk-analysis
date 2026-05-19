-- =====================================================
-- 01. COST AND EFFICIENCY BY DEFECT STATUS
-- Purpose:
-- Compare cost, energy, efficiency, and process-time metrics
-- between defective and non-defective records to determine whether
-- defects are associated with more expensive or inefficient production.
-- =====================================================

SELECT
    DefectStatus,
    COUNT(*) AS records,
    ROUND(AVG(ProductionCost), 2) AS avg_production_cost,
    ROUND(AVG(AdditiveMaterialCost), 2) AS avg_additive_material_cost,
    ROUND(AVG(AdditiveProcessTime), 2) AS avg_additive_process_time,
    ROUND(AVG(EnergyConsumption), 2) AS avg_energy_consumption,
    ROUND(AVG(EnergyEfficiency), 2) AS avg_energy_efficiency,
    ROUND(AVG(SafetyIncidents), 2) AS avg_safety_incidents
FROM manufacturing_data
GROUP BY DefectStatus
ORDER BY DefectStatus;
