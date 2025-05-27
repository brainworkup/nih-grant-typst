# Scripts Usage Guide

This directory contains various scripts to help with NIH grant preparation, data analysis, and document compilation. Below is a comprehensive guide on how to use each script.

## 📁 Directory Structure

```
scripts/
├── compile_templates.sh           # Compile Typst templates
├── analysis/
│   ├── figures/
│   │   ├── generate_figures.R     # Generate statistical figures
│   │   ├── fixed_zscore_script.R  # Z-score analysis
│   │   └── process_data.py        # Data processing utilities
│   └── tables/
│       └── generate_tables.R      # Generate formatted tables
└── helpers/
    └── reference_formatter.py     # Format and manage references
```

## 🔨 Compilation Scripts

### compile_templates.sh
Compiles Typst templates with proper root directory settings to resolve import issues.

**Usage:**
```bash
# Make the script executable (first time only)
chmod +x scripts/compile_templates.sh

# Run the compilation script
./scripts/compile_templates.sh
```

**What it does:**
- Compiles R01 template → `outputs/R01_template.pdf`
- Compiles R03 template → `outputs/R03_template.pdf`
- Creates output directory if it doesn't exist
- Uses `--root .` flag to resolve relative imports

**Requirements:**
- Typst compiler installed
- Templates located in `templates/R01/` and `templates/R03/`

## 📊 Analysis Scripts

### analysis/figures/generate_figures.R
Creates publication-ready statistical visualizations, particularly normal distribution plots with z-score cutoffs.

**Usage:**
```r
# Run interactively in R/RStudio
source("scripts/analysis/figures/generate_figures.R")

# Or run from command line
Rscript scripts/analysis/figures/generate_figures.R
```

**Functions available:**
- `create_gaussian_plot()` - Creates normal distribution with critical z-values
- `create_shaded_regions_plot()` - Creates plots with highlighted statistical regions
- `main()` - Generates all plots and saves to `outputs/figures/`

**Generated files:**
- `outputs/figures/gaussian_z_scores.png` - Z-score distribution plot
- `outputs/figures/gaussian_regions.png` - Shaded regions plot

**Requirements:**
```r
# Required R packages
install.packages(c("tidyverse", "ggplot2", "patchwork", "viridis", "scales"))
```

### analysis/tables/generate_tables.R
Creates formatted tables for grant reports and publications in HTML or LaTeX format.

**Usage:**
```r
# Load the script
source("scripts/analysis/tables/generate_tables.R")

# Create demographic table
demographics <- data.frame(
  Group = c("TD", "ADHD", "ASD"),
  N = c(50, 48, 45),
  Age = c("12.4 (3.2)", "12.1 (3.5)", "11.8 (3.3)"),
  Sex = c("25M/25F", "30M/18F", "32M/13F"),
  IQ = c("112.3 (12.5)", "108.6 (13.2)", "106.8 (15.4)"),
  SES = c("46.8 (11.2)", "43.2 (12.5)", "44.5 (13.1)")
)

table <- create_demographic_table(demographics, "demographic_table.html")
```

**Functions available:**
- `create_demographic_table()` - Formatted demographic characteristics table
- `create_stats_table()` - Statistical model results table
- `create_correlation_table()` - Correlation matrix with significance stars

**Requirements:**
```r
# Required R packages
install.packages(c("tidyverse", "kableExtra", "xtable", "flextable", "pander"))
```

## 🔧 Helper Scripts

### helpers/reference_formatter.py
Comprehensive reference management tool for NIH grant applications with BibTeX processing and citation extraction.

**Usage:**

**Format BibTeX references to NIH style:**
```bash
python scripts/helpers/reference_formatter.py references.bib --output formatted_refs.txt --format nih
```

**Check for duplicate references:**
```bash
python scripts/helpers/reference_formatter.py references.bib --check-duplicates
```

**Extract citations from Typst documents:**
```bash
python scripts/helpers/reference_formatter.py --extract-citations main.typ
```

**Sort references:**
```bash
python scripts/helpers/reference_formatter.py references.bib --sort first-author --output sorted_refs.txt
```

**Available options:**
- `--format`: Output format (`nih`, `bibtex`, `apa`)
- `--sort`: Sort by (`first-author`, `year`, `key`)
- `--check-duplicates`: Find potential duplicate entries
- `--extract-citations FILE`: Extract citation keys from Typst documents
- `--output FILE`: Write output to file (default: stdout)

**Requirements:**
- Python 3.6+
- No additional packages required (uses only standard library)

## 🚀 Quick Start Examples

### 1. Complete Workflow Example
```bash
# 1. Compile templates
./scripts/compile_templates.sh

# 2. Generate figures for your grant
Rscript scripts/analysis/figures/generate_figures.R

# 3. Check your references
python scripts/helpers/reference_formatter.py templates/R01/references.bib --check-duplicates

# 4. Format references for NIH
python scripts/helpers/reference_formatter.py templates/R01/references.bib --format nih --output formatted_references.txt
```

### 2. Data Analysis Workflow
```r
# Load table generation functions
source("scripts/analysis/tables/generate_tables.R")

# Load figure generation functions  
source("scripts/analysis/figures/generate_figures.R")

# Generate your analysis outputs
main()  # Creates figures
create_demographic_table(your_data)  # Creates tables
```

### 3. Reference Management Workflow
```bash
# Extract all citations from your main document
python scripts/helpers/reference_formatter.py --extract-citations templates/R01/R01.typ

# Check for duplicates in your bibliography
python scripts/helpers/reference_formatter.py templates/R01/references.bib --check-duplicates

# Generate NIH-formatted reference list
python scripts/helpers/reference_formatter.py templates/R01/references.bib --format nih --sort first-author
```

## 📝 Tips and Best Practices

1. **Always run from the project root directory** to ensure relative paths work correctly
2. **Check script permissions** - make shell scripts executable with `chmod +x`
3. **Install all required packages** before running R scripts
4. **Use version control** to track changes to your scripts and outputs
5. **Test scripts on sample data** before running on your actual grant data

## 🐛 Troubleshooting

**Common issues:**

1. **"Command not found" errors**: Ensure required software (Typst, R, Python) is installed and in your PATH
2. **Import/package errors**: Install required R packages or Python modules
3. **Permission denied**: Make scripts executable with `chmod +x script_name.sh`
4. **Path issues**: Always run scripts from the project root directory
5. **Missing output directories**: Scripts will create output directories automatically

**Getting help:**
- Check the script headers for specific usage instructions
- Review error messages carefully
- Ensure all dependencies are installed
- Verify file paths and permissions

## 🔄 Updates and Maintenance

To keep scripts up to date:
1. Regularly check for package updates in R and Python
2. Update Typst compiler as needed
3. Backup important outputs before making changes
4. Test scripts after any system updates
