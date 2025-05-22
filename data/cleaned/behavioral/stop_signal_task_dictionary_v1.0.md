# Stop Signal Task Data Dictionary

This document describes the variables in the stop signal task dataset.

## Dataset Information

- **Dataset name**: stop_signal_task_v1.0_2025-04-10.csv
- **Version**: 1.0
- **Date created**: 2025-04-10
- **Created by**: [Researcher Name]
- **Source data**: Raw behavioral data from stop signal task
- **Processing script**: `data/scripts/behavioral_feature_extract_ssrt.R`

## Variable Descriptions

| Variable Name | Description | Data Type | Units | Possible Values | Missing Value Code |
|---------------|-------------|-----------|-------|-----------------|-------------------|
| subject_id | Participant identifier | string | N/A | P001-P180 | N/A |
| group | Diagnostic group | string | N/A | TD, ADHD, ASD | N/A |
| age | Age at testing | numeric | years | 7-18 | NA |
| sex | Biological sex | string | N/A | M, F | NA |
| visit_number | Visit number | integer | N/A | 1, 2, 3 | NA |
| session_date | Date of testing session | date | YYYY-MM-DD | N/A | NA |
| ssrt | Stop-signal reaction time | numeric | ms | 100-500 | NA |
| mean_go_rt | Mean reaction time on go trials | numeric | ms | 200-1000 | NA |
| sd_go_rt | Standard deviation of go reaction times | numeric | ms | >0 | NA |
| go_accuracy | Proportion of correct go responses | numeric | proportion | 0-1 | NA |
| stop_accuracy | Proportion of successful stops | numeric | proportion | 0-1 | NA |
| omission_rate | Proportion of go trials with no response | numeric | proportion | 0-1 | NA |
| commission_rate | Proportion of stop trials with a response | numeric | proportion | 0-1 | NA |
| mean_ssd | Mean stop signal delay | numeric | ms | 0-500 | NA |
| post_error_slowing | RT difference after error vs. correct | numeric | ms | -500-500 | NA |
| excluded | Whether participant was excluded from analysis | boolean | N/A | TRUE, FALSE | NA |
| exclusion_reason | Reason for exclusion | string | N/A | various | NA |

## Derived Variables

The following variables are derived from the raw data:

### SSRT (Stop-Signal Reaction Time)

SSRT is calculated using the integration method:
1. Go RTs are rank-ordered
2. The nth RT is identified, where n = number of go trials × probability of responding on stop trials
3. SSRT = nth go RT - mean SSD

### Post-Error Slowing

Calculated as the difference between:
- Mean RT on go trials following a stop-failure trial
- Mean RT on go trials following a correct go trial

## Quality Control

Records are flagged for exclusion if they meet any of these criteria:
- Go accuracy < 80%
- Stop accuracy outside 20%-80% range
- SSRT < 50ms or > 500ms
- More than 10% of trials with RT < 100ms

## Preprocessing Steps

1. Removal of practice trials
2. Removal of trials with RT < 100ms (anticipatory responses)
3. Removal of RT outliers (>3SD from participant's mean)
4. Calculation of summary statistics and derived measures
5. Application of QC criteria and exclusion flagging

## Usage Notes

- For group comparisons, use the 'excluded' variable to filter out problematic data
- SSRT is the primary measure of inhibitory control
- Consider age as a covariate in all analyses
