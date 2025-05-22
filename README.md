# NIH Grant Typst Templates

Repository for NIH Grant Application Templates using Typst

## Overview

This repository contains templates and tools for creating NIH grant applications using Typst, a modern markup-based typesetting system. The repository includes templates for different grant types (R01, R03), shared components, and scripts for data analysis and visualization.

## Repository Structure

```
nih-grant-typst/
├── .github/workflows/      # GitHub Actions workflows for automatic compilation
├── .vscode/                # VSCode configuration files
├── templates/              # Typst templates for grant applications
│   ├── R01/                # R01 grant template
│   ├── R03/                # R03 grant template
│   └── shared/             # Shared components for all templates
├── scripts/                # Helper scripts and analysis code
│   ├── analysis/           # Data analysis scripts
│   └── helpers/            # Helper utilities
├── quarto/                 # Progress report templates using Quarto
├── data/                   # Data organization structure
│   ├── raw/                # Original, unmodified data
│   ├── cleaned/            # Processed, analysis-ready data
│   └── scripts/            # Data processing scripts
├── examples/               # Example outputs and figures
└── outputs/                # Compiled template outputs (generated)
```

## Getting Started

### Prerequisites

1. Install [Typst](https://typst.app/docs/installation/) command-line tool
2. (Optional) Install [Python](https://www.python.org/downloads/) and [R](https://www.r-project.org/) for data analysis scripts

### Installation

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/nih-grant-typst.git
   cd nih-grant-typst
   ```

2. (Optional) Set up a Python virtual environment and install dependencies:
   ```
   python -m venv .venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   pip install -r requirements.txt
   ```

3. (Optional) Install R dependencies:
   ```
   R -e "install.packages(c('tidyverse', 'ggplot2', 'patchwork', 'viridis'))"
   ```

## Usage

### Compiling Typst Templates

To compile the Typst templates, use the provided helper script:

```bash
./scripts/compile_templates.sh
```

This script handles the correct project root setting to resolve import errors. The compiled PDFs will be saved in the `outputs/` directory.

Alternatively, you can run the Typst compiler directly with the `--root` flag:

```bash
typst compile --root . templates/R01/R01.typ outputs/R01_template.pdf
typst compile --root . templates/R03/R03.typ outputs/R03_template.pdf
```

### Creating Your Own Grant

1. Copy one of the template directories and rename it for your project:
   ```
   cp -r templates/R01 my_grant
   ```

2. Edit the files in your new directory to customize the content for your grant application.

3. Compile your customized template:
   ```
   typst compile --root . my_grant/R01.typ my_grant.pdf
   ```

### Using Quarto for Progress Reports

The repository includes Quarto templates for creating NIH grant progress reports:

1. Navigate to the quarto directory:
   ```
   cd quarto
   ```

2. Render the progress report:
   ```
   quarto render progress-report.qmd
   ```

## Data Organization

This repository follows best practices for research data management:

- `data/raw/`: Original, unmodified data files (never modify these files)
- `data/cleaned/`: Processed, analysis-ready datasets with accompanying data dictionaries
- `data/scripts/`: Scripts for data preprocessing and feature extraction

Each directory contains a README.md with detailed documentation.

## Contributing

Contributions to improve the templates or add new features are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
