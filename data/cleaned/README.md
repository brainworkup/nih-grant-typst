# Cleaned Data

This directory contains processed and analysis-ready datasets derived from the raw data. All data in this directory has undergone quality control and preprocessing steps to prepare it for analysis.

## Principles

- All cleaned data must be generated through documented and reproducible processes
- Every dataset should include version information and processing date
- Changes to preprocessing should result in new versions, not overwriting existing files
- Each dataset should have an accompanying data dictionary

## Directory Structure

Cleaned data is organized into the following subdirectories:

### behavioral/

Processed behavioral task data.

- **File format**: CSV or RDS files
- **Naming convention**: `DATASET_NAME_v[VERSION]_YYYY-MM-DD.ext`
- **Examples**:
  - `stop_signal_task_v1.0_2025-04-10.csv`
  - `flanker_task_v1.0_2025-04-10.csv`
  - `task_switching_v1.0_2025-04-10.csv`

### neuroimaging/

Preprocessed neuroimaging data and derivatives.

- **File format**: NIFTI files (.nii.gz), text files (.txt), and matrices (.mat)
- **Naming convention**: `[DATATYPE]_v[VERSION]_YYYY-MM-DD.ext`
- **Examples**:
  - `preprocessed_func_v1.0_2025-04-15/`
  - `connectivity_matrices_v1.0_2025-04-20.mat`
  - `roi_timeseries_v1.0_2025-04-22.txt`

### eeg/

Preprocessed EEG data and derivatives.

- **File format**: EEGLAB (.set, .fdt), Fieldtrip (.mat), or MNE-Python (.fif)
- **Naming convention**: `[DATATYPE]_v[VERSION]_YYYY-MM-DD.ext`
- **Examples**:
  - `preprocessed_eeg_v1.0_2025-04-18/`
  - `erp_data_v1.0_2025-04-25.mat`
  - `time_frequency_v1.0_2025-04-27.mat`

### merged/

Datasets that combine multiple data types or modalities.

- **File format**: CSV, RDS, or HDF5 files
- **Naming convention**: `[DATATYPE]_v[VERSION]_YYYY-MM-DD.ext`
- **Examples**:
  - `behavior_brain_merged_v1.0_2025-05-01.csv`
  - `multimodal_features_v1.0_2025-05-05.h5`

## Data Dictionaries

Each cleaned dataset has an accompanying data dictionary stored in the same directory:

- **File format**: CSV or Markdown files
- **Naming convention**: `[DATASET_NAME]_dictionary_v[VERSION].ext`
- **Content**: Variable names, descriptions, units, possible values, coding schemes

## Processing Logs

Processing logs for each dataset are stored in:

- `processing_logs/`

These logs document:
- Input files used
- Software versions
- Processing parameters
- Quality control metrics
- Any manual interventions
- Date and time of processing
- Processing duration

## Quality Control

Quality control metrics and reports are stored in:

- `quality_control/`

These include:
- Data quality metrics
- Outlier detection results
- Visualization reports
- Subject/scan exclusions and justifications

## Analysis-Ready Datasets

The following analysis-ready datasets combine multiple processed data sources:

1. `complete_dataset_v1.0_2025-05-10.csv`
   - Includes all behavioral measures, key neuroimaging features, and demographic data
   - One row per participant
   - Suitable for most statistical analyses

2. `longitudinal_dataset_v1.0_2025-05-12.csv`
   - Time series data for participants with multiple visits
   - Includes key measures at each timepoint
   - Suitable for longitudinal analyses

## Version History

A record of all dataset versions is maintained in:

- `version_history.csv`

This tracks:
- Version numbers
- Dates
- Changes from previous versions
- Reasons for new versions
- Responsible team member
