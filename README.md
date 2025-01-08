Case-Control Study of Comorbidities in IBD, Crohn's Disease, and Ulcerative Colitis
This repository contains the code, data, and visualizations for a case-control study aimed at identifying comorbidities associated with Inflammatory Bowel Disease (IBD), Crohn's disease, and Ulcerative Colitis. The study utilized the OMOP Common Data Model to standardize the analysis and provide robust statistical insights.

Overview
The main objective of this project was to investigate comorbidities related to IBD, Crohn's disease, and Ulcerative Colitis by performing statistical analyses, odds ratio calculations, and data visualization. Key findings are presented in heatmaps, bar charts, and comprehensive summary reports.

Files in the Repository
Code
case_control_matching.R

Implements a 1:4 matching algorithm for cases and controls, matching on variables such as age, gender, and race.
Outputs a combined dataset for downstream analyses.

Key features:
Age calculation using birthdate.
Ensures 1:4 ratio between cases and controls.
Output: a1_fixed.csv (processed data).
comorbidities_association.R

Analyzes comorbidities associated with IBD and computes:
Odds Ratios (OR)
Confidence Intervals (CI)
P-values using Fisher's Exact Test.
Outputs a detailed CSV file with all calculated statistics for comorbidities.
Output: comorbidity_odds_ratios_results.csv.
Socio-economics_association.py

Examines socio-economic variables' association with cases and controls.
Statistical analyses include:
Chi-Square and Fisher's Exact Tests.
Logistic Regression for Odds Ratios.
Outputs summary statistics for socio-economic data.
Output: results_table.csv.

Data
41_comorbidities.csv: Contains the list of comorbidities analyzed in the study.
a1_fixed.csv: Matched dataset of cases and controls with demographic and clinical data.
demographics_socioeconomic_results.xlsx: summary of demographic and socio-economic results.
Visualizations: 41_map.png shows Heatmap of odds ratios, p-values, and case percentages for 41 comorbidities.
Key Insight: Highlights significant comorbidities for IBD patients.
output (2).png: Bar chart displaying odds ratios for all comorbidities.
Key Insight: Visual representation of comorbidities' relative risk.

How to Use
Prerequisites:
Install the required R and Python libraries:
R: dplyr, tidyr, lubridate, epitools.
Python: pandas, numpy, scipy, statsmodels.

Running the Code:
Start by running case_control_matching.R to create the matched dataset.
Use comorbidities_association.R for comorbidity analysis.
Analyze socio-economic variables using Socio-economics_association.py.

Outputs: The outputs include datasets, statistical tables, and visualizations.

Results
Comorbidities Analysis:
Identified significant comorbidities across cardiovascular, dermatological, endocrine, and socio-economic domains.
Statistical results include Odds Ratios, Confidence Intervals, and p-values.

Socio-Economic Insights:
Explored relationships between socio-economic factors and disease cases/controls.
