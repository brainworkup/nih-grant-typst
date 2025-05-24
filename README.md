# NIH Grant Typst Templates

A modern, reproducible workflow for creating NIH grant applications using Typst, with integrated support for R and Python data analysis via Quarto.

[![Compile Typst Documents](https://github.com/brainworkup/nih-grant-typst/actions/workflows/compile-typst.yml/badge.svg)](https://github.com/brainworkup/nih-grant-typst/actions/workflows/compile-typst.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/brainworkup/nih-grant-typst.git
cd nih-grant-typst

# Set up the environment (choose one)
conda env create -f environment.yml  # Recommended: includes everything
# OR
pip install -r requirements.txt      # Python only
# OR
Rscript -e "install.packages(c('tidyverse', 'ggplot2', 'patchwork', 'viridis'))"  # R only

# Compile example templates
./scripts/compile_templates.sh
```

## 📋 Features

- ✅ **NIH-compliant formatting** - Automated margins, fonts, and page limits
- ✅ **Multiple grant types** - R01, R03, with more coming soon
- ✅ **Integrated data analysis** - Seamless R and Python integration
- ✅ **Reproducible research** - Quarto-based progress reports
- ✅ **Smart reference management** - BibTeX with NIH-style formatting
- ✅ **Version control friendly** - Clean text-based format
- ✅ **Automated compilation** - GitHub Actions for PDF generation
- ✅ **Modular components** - Reusable sections across grants

## 🏗️ Repository Structure

```
nih-grant-typst/
├── templates/             # Typst templates for grant applications
│   ├── R01/               # R01 grant template
│   ├── R03/               # R03 grant template
│   └── shared/            # Shared components (aims, budget)
├── scripts/               # Helper scripts and analysis code
│   ├── analysis/          # Data analysis scripts
│   │   ├── figures/       # R/Python scripts for figures
│   │   └── tables/        # R scripts for tables
│   └── helpers/           # Utility scripts
├── quarto/                # Progress report templates
├── data/                  # Data organization structure
│   ├── raw/               # Original, unmodified data
│   ├── cleaned/           # Processed, analysis-ready data
│   └── scripts/           # Data processing scripts
├── examples/              # Example outputs and figures
└── outputs/               # Compiled PDFs (generated)
```

## 📖 Complete Usage Guide

### Creating Your First Grant

#### 1. Choose Your Template

```bash
# For an R01 grant
cp -r templates/R01 my_r01_grant

# For an R03 grant
cp -r templates/R03 my_r03_grant
```

#### 2. Customize Your Grant

Edit the main file (e.g., `my_r01_grant/R01.typ`):

```typst
#import "config.typ": *
#import "../shared/specific_aims.typ": specific_aims_example
#import "../shared/budget.typ": budget_example

// Update with your information
#show: nih-grant.with(
  title: "Your Grant Title Here",
  pi: "Dr. Your Name",
  institution: "Your Institution"
)

// Add your content
#specific_aims[
  Your specific aims content here...
]
```

#### 3. Compile Your Grant

```bash
# Using the helper script
./scripts/compile_templates.sh

# Or compile directly with correct root setting
typst compile --root . my_r01_grant/R01.typ outputs/my_r01_grant.pdf
```

### 🔬 Integrating Data Analysis

#### Option 1: R Analysis with Quarto

Create a Quarto document for your analysis:

```r
---
title: "Data Analysis for NIH Grant"
format: 
  html: default
  typst: default
---

```{r}
#| label: fig-results
#| fig-cap: "Primary outcome analysis"

library(ggplot2)
data <- read.csv("data/cleaned/results.csv")

ggplot(data, aes(x = time, y = outcome, color = group)) +
  geom_line() +
  theme_minimal() +
  labs(title = "Treatment Effect Over Time")

ggsave("outputs/figures/primary_outcome.png", dpi = 300)
```
```

Reference in your Typst document:

```typst
#figure(
  image("outputs/figures/primary_outcome.png"),
  caption: [Treatment effect over time showing significant improvement in the intervention group.]
)
```

#### Option 2: Python Analysis

```python
# scripts/analysis/figures/generate_figures.py
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load and analyze data
data = pd.read_csv('data/cleaned/results.csv')
sns.set_style("whitegrid")

# Create publication-quality figure
fig, ax = plt.subplots(figsize=(8, 6))
sns.lineplot(data=data, x='time', y='outcome', hue='group', ax=ax)
ax.set_title('Treatment Effect Over Time')
plt.savefig('outputs/figures/python_analysis.png', dpi=300, bbox_inches='tight')
```

### 📊 Data Organization

Follow our structured approach for reproducible research:

```
data/
├── raw/                    # Never modify these files
│   ├── behavioral/         # Original behavioral data
│   ├── neuroimaging/       # MRI/fMRI data
│   └── clinical/           # Clinical assessments
├── cleaned/                # Processed data with documentation
│   ├── behavioral/         # Analysis-ready datasets
│   └── processing_logs/    # Document all transformations
└── scripts/                # Processing scripts
    └── preprocessing/      # Data cleaning code
```

### 📚 Working with References

#### Managing Citations

Add references to `references.bib`:

```bibtex
@article{smith2023example,
  title = {Example Study Title},
  author = {Smith, Jane and Doe, John},
  journal = {Journal of Example Studies},
  volume = {42},
  pages = {123--456},
  year = {2023},
  doi = {10.1234/example}
}
```

Cite in Typst:

```typst
Previous research has shown significant effects @smith2023example.
```

#### Format References for NIH

```bash
# Convert to NIH style
python scripts/helpers/reference_formatter.py references.bib --format nih

# Check for duplicates
python scripts/helpers/reference_formatter.py references.bib --check-duplicates
```

### 📝 Creating Progress Reports

Generate professional progress reports using Quarto:

```bash
cd quarto
quarto render progress-report.qmd --to pdf
quarto render progress-report.qmd --to html
```

## 🎨 Available Templates

### R01 - Research Project Grant
- **Purpose**: Major research projects
- **Research Strategy**: 12 pages
- **Budget**: Modular or detailed
- **Duration**: Up to 5 years
- [View template](templates/R01/)

### R03 - Small Grant Program
- **Purpose**: Limited research projects
- **Research Strategy**: 6 pages  
- **Budget**: $50,000/year maximum
- **Duration**: Up to 2 years
- [View template](templates/R03/)

### Coming Soon
- R21 - Exploratory/Developmental Research
- K99/R00 - Pathway to Independence  
- F31 - Predoctoral Fellowship

## 🛠️ Advanced Features

### VSCode Integration

We include configurations for optimal development:
- Typst syntax highlighting and preview
- Integrated compilation tasks (Ctrl+Shift+B)
- Recommended extensions for R, Python, and Quarto

### Automated Validation

Ensure your grant meets NIH requirements:

```bash
# Check page limits (coming soon)
python scripts/helpers/validate_grant.py outputs/my_grant.pdf --type R01

# Validate formatting
python scripts/helpers/check_formatting.py outputs/my_grant.pdf
```

### Custom Components

Create reusable components for your grants:

```typst
// templates/shared/my_custom_section.typ
#let my_section(content) = {
  heading(level: 1, [MY CUSTOM SECTION])
  set par(first-line-indent: 0.5in)
  content
}
```

## 🤝 Contributing

We welcome contributions! See our [Contributing Guidelines](CONTRIBUTING.md).

### Ways to Contribute
- Add new grant templates
- Improve existing templates
- Share helper scripts
- Enhance documentation
- Report issues

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Typst community for the excellent typesetting system
- NIH for grant formatting guidelines
- Contributors who have improved these templates

## 📧 Support

- **Issues**: [GitHub Issues](https://github.com/brainworkup/nih-grant-typst/issues)
- **Discussions**: [GitHub Discussions](https://github.com/brainworkup/nih-grant-typst/discussions)

---

*Remember: Always check the latest NIH guidelines as requirements may change.*
