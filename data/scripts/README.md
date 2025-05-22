# Data Processing Scripts

This directory contains scripts specifically for data preprocessing, cleaning, and feature extraction. These scripts are separate from the general analysis scripts in the main `scripts/` directory and focus exclusively on transforming raw data into analysis-ready formats.

## Purpose

These scripts serve to:

1. Document all data transformations for reproducibility
2. Standardize data processing across team members
3. Automate routine data processing tasks
4. Ensure consistent data quality control

## Script Categories

The scripts are organized into the following categories:

### preprocessing/

Scripts for initial data preprocessing.

- **MRI preprocessing**: e.g., slice timing correction, motion correction, spatial normalization
- **EEG preprocessing**: e.g., filtering, artifact removal, epoching
- **Behavioral data preprocessing**: e.g., outlier removal, calculation of derived measures

### quality_control/

Scripts for assessing data quality and identifying problematic data.

- **MRI QC**: e.g., motion assessment, SNR calculation, artifact detection
- **EEG QC**: e.g., channel quality assessment, artifact quantification
- **Behavioral QC**: e.g., response validity checks, engagement metrics

### feature_extraction/

Scripts for extracting features from preprocessed data.

- **MRI features**: e.g., ROI extraction, connectivity matrices, activation maps
- **EEG features**: e.g., ERPs, time-frequency features, connectivity measures
- **Behavioral features**: e.g., summary statistics, model parameters

### merging/

Scripts for combining data across modalities and preparing final datasets.

- **Data integration**: e.g., combining behavioral and neural measures
- **Group dataset creation**: e.g., creating analysis-ready datasets for specific aims

## Script Requirements

All scripts must:

1. Begin with a header that includes:
   - Script purpose
   - Author name and contact
   - Date created and last modified
   - Input requirements (files, format)
   - Output description (files, format)
   - Dependencies (libraries, other scripts)
   - Usage examples

2. Include detailed inline comments explaining:
   - Each processing step
   - Rationale for parameter choices
   - Any manual intervention points
   - Potential limitations or caveats

3. Log all operations to a processing log file, including:
   - Start and end times
   - Input files used
   - Parameters applied
   - Quality metrics
   - Warning or error messages
   - Output files created

## Naming Conventions

Scripts should follow this naming convention:

- `[DATA_TYPE]_[PROCESSING_STAGE]_[SPECIFIC_FUNCTION].ext`

Examples:
- `fmri_preproc_motion_correction.py`
- `eeg_qc_artifact_detection.R`
- `behavioral_feature_extract_ssrt.R`
- `multimodal_merge_complete_dataset.R`

## Dependencies

All script dependencies should be documented in:

- `environment.yml` (for conda environment)
- `requirements.txt` (for pip installation)

Dependencies specific to a script should also be noted in the script's header.

## Usage

Most scripts can be run from the command line with appropriate arguments:

```bash
Rscript data/scripts/behavioral_feature_extract_ssrt.R \
  --input data/raw/behavioral/stop_signal_task \
  --output data/cleaned/behavioral/stop_signal_task_v1.0_2025-04-10.csv \
  --log data/cleaned/processing_logs/ssrt_extraction_2025-04-10.log
```

Scripts should include help documentation accessible via:

```bash
python data/scripts/fmri_preproc_motion_correction.py --help
```

## Processing Workflow

The complete data processing workflow is documented in:

- `data_processing_workflow.md`

This document outlines the order in which scripts should be run and dependencies between processing steps.

## Version Control

All scripts are version controlled through Git. When making changes:

1. Document the changes in the script header
2. Update the "last modified" date
3. Consider creating a new version if changes affect outputs significantly
