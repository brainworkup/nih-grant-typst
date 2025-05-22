# Raw Data

This directory contains original, unmodified data files collected as part of the NIH grant project on neural mechanisms of cognitive control in neurodevelopmental disorders.

## Principles

- Files in this directory must NEVER be modified
- Consider this directory as a read-only archive
- Any data processing must be done on copies of these files
- All file operations should be performed through documented scripts

## Data Structure

Raw data is organized into the following subdirectories:

### behavioral/

Behavioral task data collected during testing sessions.

- **File format**: CSV or TSV files
- **Naming convention**: `YYYY-MM-DD_SUBJECT-ID_TASK.csv`
- **Examples**:
  - `2025-03-15_P001_StopSignal.csv`
  - `2025-03-15_P001_Flanker.csv`
  - `2025-03-15_P001_TaskSwitching.csv`

### neuroimaging/

Neuroimaging data collected during MRI sessions.

- **File format**: NIFTI files (.nii.gz)
- **Naming convention**: `YYYY-MM-DD_SUBJECT-ID_SCAN-TYPE_RUN.nii.gz`
- **Examples**:
  - `2025-03-15_P001_T1w.nii.gz`
  - `2025-03-15_P001_task-StopSignal_run-01_bold.nii.gz`
  - `2025-03-15_P001_task-Flanker_run-01_bold.nii.gz`

### eeg/

EEG data collected during sessions.

- **File format**: Brain Vision (.vhdr, .vmrk, .eeg) or EDF (.edf)
- **Naming convention**: `YYYY-MM-DD_SUBJECT-ID_TASK_RUN.vhdr`
- **Examples**:
  - `2025-03-15_P001_StopSignal_run-01.vhdr`
  - `2025-03-15_P001_Flanker_run-01.vhdr`

### clinical/

Clinical and demographic data for participants.

- **File format**: CSV files
- **Naming convention**: `YYYY-MM-DD_SUBJECT-ID_ASSESSMENT.csv`
- **Examples**:
  - `2025-03-15_P001_Demographics.csv`
  - `2025-03-15_P001_ADHD-RS.csv`
  - `2025-03-15_P001_ADOS-2.csv`

## Data Acquisition Parameters

Detailed acquisition parameters are documented in the following files:

- `neuroimaging_parameters.json`: MRI acquisition parameters
- `eeg_parameters.json`: EEG acquisition parameters
- `task_parameters.json`: Behavioral task parameters

## Data Checksums

To verify data integrity, MD5 checksums for all files are stored in:

- `checksums.md5`

Use the following command to verify file integrity:

```bash
md5sum -c checksums.md5
```

## Data Inventory

A complete inventory of all collected data is maintained in:

- `data_inventory.csv`

This file includes:
- Subject ID
- Date of collection
- Types of data collected
- Quality assessment ratings
- Notes on any issues during collection
