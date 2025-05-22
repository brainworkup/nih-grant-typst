# Data Organization for NIH Grant Project

This directory contains research data related to the NIH grant project on neural mechanisms of cognitive control in neurodevelopmental disorders.

## Directory Structure

The data is organized into the following subdirectories:

- **raw/**: Original, unmodified data files
- **cleaned/**: Processed and analysis-ready datasets
- **scripts/**: Data processing scripts specific to this dataset

## Data Management Principles

### Raw Data

- Raw data must NEVER be modified
- Files should be named using the following convention: `YYYY-MM-DD_SUBJECT-ID_TASK_MODALITY.ext`
- Example: `2025-03-15_P001_SST_fMRI.nii.gz`
- Include checksums for all raw data files to ensure data integrity
- Document all data collection parameters in a separate metadata file

### Cleaned Data

- All preprocessing steps must be documented and reproducible via scripts
- Include clear version tracking with date suffixes: `DATASET_NAME_v1.0_YYYY-MM-DD.ext`
- Each dataset should have an accompanying data dictionary in CSV or TSV format
- For CSV/TSV files, first row must contain variable names, with no spaces (use underscores)
- Missing data should be coded consistently (e.g., NA, -999, etc.) and documented

### Scripts

- Each data processing script should be self-contained and documented
- Include clear input/output specifications at the top of each script
- Use consistent style and naming conventions
- Scripts should be parameterized to work with different inputs

## Data Types

### Behavioral Data

- **Location**: `raw/behavioral/` and `cleaned/behavioral/`
- **Format**: CSV files with subject ID, task parameters, and response variables
- **Variables**: RT (reaction time), ACC (accuracy), and task-specific measures

### Neuroimaging Data

- **Location**: `raw/neuroimaging/` and `cleaned/neuroimaging/`
- **Format**: Standard neuroimaging formats (NIFTI, BIDS)
- **Processing**: See `scripts/preprocessing/` for processing pipelines

### EEG Data

- **Location**: `raw/eeg/` and `cleaned/eeg/`
- **Format**: Standard EEG formats (EDF, BrainVision)
- **Processing**: See `scripts/preprocessing/` for processing pipelines

## Data Security and Access

- PHI and identifiable information should NEVER be stored in this repository
- De-identified data only
- Access is restricted to project team members

## Data Backup

- Data is backed up automatically to [BACKUP_LOCATION]
- Backup frequency: [FREQUENCY]
- Backup retention policy: [RETENTION_POLICY]

## Data Documentation

Each subdirectory contains a README file with specific details about the data stored in that location.
