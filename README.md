# Manufacturing Defect Risk Analysis

## Project Overview

This project analyzes manufacturing operations data to identify which operational conditions are most strongly associated with defective production outcomes.

The analysis focuses on defect risk, quality performance, production volume, maintenance intensity, downtime, and operational efficiency. The goal is to separate strong defect-risk signals from weak or less meaningful factors using SQL and Power BI.

This project is designed as a SQL-heavy operations analytics case study, supported by a Power BI executive dashboard.

---

## Business Objective

The main business question:

**Which operational factors are most associated with higher defect status rates?**

This project helps manufacturing and quality teams understand:

- Which production conditions are linked with higher defect risk
- Which metrics are strong defect-risk signals versus weak signals
- Whether downtime, supplier quality, or worker productivity meaningfully separate defect outcomes
- How multiple operational risk factors combine to create higher-risk production profiles

---

## Dataset Overview

The dataset contains **3,240 manufacturing records** with operational, quality, cost, energy, and defect-related fields.

The raw dataset includes production and process-related variables such as production volume, production cost, supplier quality, defect rate, quality score, maintenance hours, downtime percentage, inventory turnover, worker productivity, energy consumption, additive process time, additive material cost, and defect status.

### Data Notes

The raw CSV is not included in this repository if redistribution rights are unclear. The SQL workflow documents the full import, staging, cleaning, validation, and analysis process.

The dataset does not include production date, shift, operator ID, or machine ID. Because of this, the project focuses on **risk-factor analysis** rather than time-series, shift-level, operator-level, or machine-level performance analysis.

---

## Key Columns Used

| Column | Description |
|---|---|
| `ProductionVolume` | Production output volume |
| `ProductionCost` | Cost associated with production |
| `SupplierQuality` | Supplier quality score |
| `DeliveryDelay` | Delivery delay measurement |
| `DefectRate` | Recorded defect rate |
| `QualityScore` | Overall quality score |
| `MaintenanceHours` | Maintenance time associated with production |
| `DowntimePercentage` | Percentage of downtime |
| `InventoryTurnover` | Inventory turnover measure |
| `StockoutRate` | Stockout rate |
| `WorkerProductivity` | Worker productivity score |
| `SafetyIncidents` | Number or rate of safety incidents |
| `EnergyConsumption` | Energy consumed during production |
| `EnergyEfficiency` | Energy efficiency score |
| `AdditiveProcessTime` | Additive process time |
| `AdditiveMaterialCost` | Additive material cost |
| `DefectStatus` | Binary defect outcome: 0 = non-defective, 1 = defective |

---

## Tools Used

- **SQL Server / SSMS** — data import, cleaning, validation, and analysis
- **SQL** — KPI calculations, banding logic, defect-risk analysis, and risk profiling
- **Power BI** — dashboard creation and executive visualization
- **DAX** — calculated columns and dashboard measures

---

## Repository Structure

```text
manufacturing-defect-risk-analysis/
│
├── README.md
├── sql/
│   ├── 00_import_and_cleaning.sql
│   ├── 01_data_validation.sql
│   ├── 02_baseline_kpis.sql
│   ├── 03_defect_risk_analysis.sql
│   ├── 04_cost_efficiency_analysis.sql
│   └── 05_high_risk_profile.sql
├── powerbi/
│   └── manufacturing_defect_risk_dashboard.pbix
└── visuals/
    ├── manufacturing_defect_risk_dashboard.jpg
    └── sql-results/
        ├── 01_range_check.jpg
        ├── 02_defect_status_distribution.jpg
        ├── 03_baseline_kpis.jpg
        ├── 04_defective_vs_non_defective.jpg
        ├── 05_production_volume_band.jpg
        ├── 06_maintenance_band.jpg
        ├── 07_quality_score_band.jpg
        ├── 08_downtime_band.jpg
        ├── 09_supplier_quality_band.jpg
        ├── 10_productivity_band.jpg
        ├── 11_cost_efficiency.jpg
        └── 12_high_risk_profile.jpg
```

---

## Project Workflow
1. Data Import and Cleaning

The raw dataset was first imported into a staging table where all columns were stored as text. This avoided import failures caused by blanks, nulls, or type conversion issues.

The final analysis table was then created using TRY_CAST and NULLIF to safely convert the data into numeric fields.

The workflow followed this structure:

Raw CSV → Staging Table → Clean Typed Table → Analysis

This approach allowed the data to be imported safely before enforcing numeric data types.

2. Data Validation

Before performing analysis, the cleaned table was validated to make sure it was reliable and suitable for analysis.

The validation process included:

Confirming final row count after import
Checking for null values in key columns
Verifying numeric ranges for major operational metrics
Confirming valid binary values in DefectStatus
Data Validation Results
Row Count Validation

The final cleaned table contained:

Check	Result
Final Rows	3,240

The row count matched the expected dataset size, confirming that no records were lost during the staging and cleaning process.

Null Value Check

Key operational and quality fields were checked for missing values.

Column Checked	Null Count
ProductionVolume	0
ProductionCost	0
DefectRate	0
DowntimePercentage	0
StockoutRate	0
DefectStatus	0

No null values were found in the main analysis fields.

Numeric Range Check

The numeric range check confirmed that key fields contained reasonable values after type conversion.

Metric	Minimum	Maximum
DefectRate	0.50	4.99
DowntimePercentage	0.00	5.00
QualityScore	60.01	99.99
WorkerProductivity	80.00	99.99
ProductionVolume	100	999
ProductionCost	5,000.17	19,993.37

The ranges appeared valid, with no obvious import or conversion errors.

Defect Status Distribution

DefectStatus was checked to confirm that it contained valid binary values only.

DefectStatus	Records
0	517
1	2,723

The dataset is heavily weighted toward defective records, with a defect status rate of 84.04%.

This influenced the direction of the analysis. Instead of treating defects as rare events, the project focused on identifying which operating conditions were associated with even higher defect risk.

Baseline KPI Analysis

The overall manufacturing baseline was calculated to understand the general production, quality, cost, and defect profile of the dataset.

Metric	Value
Total Records	3,240
Avg Production Volume	548.52
Avg Production Cost	12,423.02
Avg Supplier Quality	89.83
Avg Delivery Delay	2.56
Avg Defect Rate	2.75
Avg Quality Score	80.13
Avg Maintenance Hours	11.48
Avg Downtime Percentage	2.50
Avg Inventory Turnover	6.02
Avg Stockout Rate	0.05
Avg Worker Productivity	90.04
Avg Safety Incidents	4.59
Avg Energy Consumption	2,988.49
Avg Energy Efficiency	0.30
Avg Additive Process Time	5.47
Avg Additive Material Cost	299.52
Defect Status Rate	84.04%

The baseline shows a high-defect production environment, making defect-risk separation the main focus of the project.

Defect Risk Analysis

The analysis compared defective and non-defective records to identify which operational conditions were most different when defects occurred.

Defective vs Non-Defective Records
Metric	Non-Defective	Defective
Records	517	2,723
Avg Production Volume	470.87	563.27
Avg Production Cost	12,158.88	12,473.17
Avg Supplier Quality	89.33	89.93
Avg Delivery Delay	2.54	2.56
Avg Defect Rate	2.01	2.89
Avg Quality Score	85.44	79.13
Avg Maintenance Hours	6.79	12.37
Avg Downtime Percentage	2.49	2.50
Avg Worker Productivity	90.11	90.03

The clearest differences appeared in:

Production volume
Defect rate
Quality score
Maintenance hours

Defective records were associated with higher production volume, higher maintenance hours, higher defect rate, and lower quality score.

Risk Factor Analysis

Several operational factors were grouped into bands to test whether they meaningfully separated defect outcomes.

Production Volume Band
Production Volume Band	Records	Avg Production Volume	Defect Status Rate
Low Volume	1,088	246.39	80.51%
Medium Volume	1,044	545.09	80.17%
High Volume	1,108	848.44	91.16%

High production volume records had a defect status rate above 91%, around 10 percentage points higher than low and medium volume records.

This suggests that heavier production loads may be associated with increased defect risk.

Maintenance Hours Band
Maintenance Band	Records	Avg Maintenance Hours	Defect Status Rate
Low Maintenance	1,091	3.52	71.40%
Medium Maintenance	797	10.64	80.80%
High Maintenance	1,352	18.39	96.15%

High maintenance records showed the strongest defect-risk separation, with a defect status rate of 96.15%.

This suggests that maintenance-heavy conditions may reflect equipment stress, recurring process issues, or operational instability.

Quality Score Band
Quality Score Band	Records	Avg Quality Score	Defect Status Rate
Low Quality Score	1,190	67.37	95.80%
Medium Quality Score	1,208	82.40	77.07%
High Quality Score	842	94.92	77.43%

Defect risk increased sharply when quality score dropped below 75.

Medium and high quality score bands showed similar defect rates, suggesting the main risk threshold occurs at the low-quality level.

Downtime Percentage Band
Downtime Band	Records	Avg Downtime Percentage	Defect Status Rate
Low Downtime	982	0.77	84.11%
Medium Downtime	1,278	2.48	84.12%
High Downtime	980	4.26	83.88%

Downtime percentage did not meaningfully separate defect outcomes.

Defect status rates stayed close to 84% across all downtime bands.

Supplier Quality Band
Supplier Quality Band	Records	Avg Supplier Quality	Defect Status Rate
Low Supplier Quality	835	82.51	82.87%
Medium Supplier Quality	1,625	89.90	84.37%
High Supplier Quality	780	97.53	84.62%

Supplier quality showed minimal separation across bands and was not a strong defect-risk signal in this dataset.

Worker Productivity Band
Productivity Band	Records	Avg Worker Productivity	Defect Status Rate
Low Productivity	1,111	83.51	84.61%
Medium Productivity	1,153	90.52	83.26%
High Productivity	976	96.91	84.32%

Worker productivity did not meaningfully separate defect outcomes.

The defect status rate remained close across all productivity bands.

Cost and Efficiency Analysis

Cost and efficiency metrics were compared between defective and non-defective records.

Metric	Non-Defective	Defective
Avg Production Cost	12,158.88	12,473.17
Avg Additive Material Cost	299.77	299.47
Avg Additive Process Time	5.44	5.48
Avg Energy Consumption	2,975.16	2,991.03
Avg Energy Efficiency	0.31	0.30
Avg Safety Incidents	4.70	4.57

Defective records had slightly higher production cost and energy consumption, but the differences were small.

Cost and efficiency metrics were not the strongest defect-risk signals in this dataset.

Combined Risk Profile

The strongest individual risk factors were combined into a practical risk profile.

The three major risk conditions were:

High maintenance hours
Low quality score
High production volume

Each record was assigned a risk factor count from 0 to 3.

Risk Factor Count	Records	Avg Production Volume	Avg Maintenance Hours	Avg Quality Score	Defect Status Rate
0	796	397.78	6.48	87.55	53.89%
1	1,397	523.28	11.12	81.01	92.27%
2	888	670.05	15.25	74.42	96.17%
3	159	846.30	18.58	67.21	94.97%

Records with no major risk factors had a defect status rate of 53.89%, while records with one or more major risk factors exceeded 92%.

This suggests that the presence of any major risk factor sharply increases defect likelihood.

Dashboard

The Power BI dashboard summarizes the main findings and highlights the strongest defect-risk signals.

SQL Result Screenshots

Detailed SQL result screenshots are available in the visuals/sql-results folder.

Key Findings
The overall defect status rate was 84.04%, showing a high-defect production environment.
High maintenance hours showed the strongest defect-risk separation, with a 96.15% defect status rate.
Low quality score records had a 95.80% defect status rate.
High production volume records had a 91.16% defect status rate.
Downtime percentage, supplier quality, and worker productivity were weaker signals.
Records with no major risk factors had a much lower defect status rate of 53.89%.
Records with one or more major risk factors had defect status rates above 92%.
Business Recommendation

Quality teams should prioritize monitoring production records with:

High maintenance hours
Low quality scores
High production volume

These conditions showed the clearest separation in defect risk.

Downtime percentage, supplier quality, and worker productivity were weaker signals in this dataset and should not be treated as primary defect-risk indicators without further investigation.

Final Insight

Defect risk was not evenly explained by every operational metric.

The strongest signals were maintenance intensity, low quality performance, and high production volume. When these risk factors appeared, defect status rates rose sharply above 92%.

This analysis shows how manufacturing teams can use operational data to prioritize quality monitoring around the conditions most associated with defective outcomes.

Limitations
The dataset does not include machine ID, operator ID, shift, or production date.
Because no time column was available, trend analysis over time could not be performed.
DefectStatus was heavily imbalanced, with 84.04% defective records.
The analysis identifies associations, not direct causation.
Downtime was provided as a percentage rather than actual downtime minutes.
The raw dataset is not included if redistribution rights are unclear.

Skills Demonstrated
SQL data cleaning and validation
Staging-table import workflow
Safe type conversion using TRY_CAST
Manufacturing KPI analysis
Defect-risk segmentation
Operational risk profiling
Power BI dashboard design
Business insight generation
Executive recommendation writing
