-- =====================================================
-- 01. DEFECT STATUS RATE BY COMBINED RISK PROFILE
-- Purpose:
-- Combine the strongest defect-risk signals identified earlier:
-- high maintenance hours, low quality score, and high production volume.
-- This query checks whether records with multiple risk conditions show
-- higher defect status rates than records with fewer risk conditions.
-- =====================================================

WITH risk_flags AS (
    SELECT
        *,
        CASE WHEN MaintenanceHours >= 14 THEN 1 ELSE 0 END AS high_maintenance_flag,
        CASE WHEN QualityScore < 75 THEN 1 ELSE 0 END AS low_quality_score_flag,
        CASE WHEN ProductionVolume >= 700 THEN 1 ELSE 0 END AS high_volume_flag
    FROM manufacturing_data
),
risk_score AS (
    SELECT
        *,
        high_maintenance_flag + low_quality_score_flag + high_volume_flag AS risk_factor_count
    FROM risk_flags
)
SELECT
    risk_factor_count,
    COUNT(*) AS records,
    ROUND(AVG(ProductionVolume), 2) AS avg_production_volume,
    ROUND(AVG(MaintenanceHours), 2) AS avg_maintenance_hours,
    ROUND(AVG(QualityScore), 2) AS avg_quality_score,
    ROUND(AVG(DefectRate), 2) AS avg_defect_rate,
    ROUND(
        100.0 * SUM(CASE WHEN DefectStatus = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS defect_status_rate
FROM risk_score
GROUP BY risk_factor_count
ORDER BY risk_factor_count DESC;
