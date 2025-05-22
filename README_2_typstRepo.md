# Create a github repo for NIH grants using Typst

Here's a structured GitHub repository setup for generating NIH grant applications using Typst, along with integration for R/Python/Quarto:

```
nih-grant-typst/
├── .github/
│   └── workflows/
│       └── compile-typst.yml
├── .vscode/
│   ├── extensions.json
│   └── settings.json
├── templates/
│   ├── R01/
│   │   ├── R01.typ
│   │   ├── references.bib
│   │   └── config.typ
│   ├── R03/
│   │   └── R03.typ
│   └── shared/
│       ├── specific_aims.typ
│       └── budget.typ
├── scripts/
│   ├── analysis/
│   │   ├── figures/
│   │   │   ├── generate_figures.R
│   │   │   └── process_data.py
│   │   └── tables/
│   └── helpers/
│       └── reference_formatter.py
├── quarto/
│   ├── _extensions/
│   ├── _quarto.yml
│   └── progress-report.qmd
├── examples/
│   ├── sample_R01.pdf
│   └── demo_figure.png
├── .gitignore
├── LICENSE
├── README.md
├── requirements.txt
└── environment.yml
```

**1. Key Components:**

- **Templates**: Organized by grant type with modular sections

  - `config.typ` for NIH formatting requirements (margins, fonts, page limits)
  - Shared components for common sections (budget tables, biosketches)
  - Reference management with BibTeX integration

- **VS Code Configuration**:

  ```json
  // .vscode/extensions.json
  {
    "recommendations": [
      "nvarner.typst-lsp",
      "quarto.quarto",
      "r-lang.r",
      "ms-python.python"
    ]
  }
  ```

- **Automation**:
  - GitHub Action to compile Typst documents on push
  - Python/R scripts for:
    - Automated budget calculations
    - Figure generation from experimental data
    - Reference validation and formatting

**2. Setup Instructions (README.md):**

````markdown
# NIH Grant Templates with Typst

A modern workflow for creating NIH grant applications using reproducible research tools.

## Requirements

1. [Typst](https://typst.app/) compiler
2. [Quarto](https://quarto.org/)
3. VS Code with recommended extensions
4. R/Python environments

## Quickstart

```bash
git clone https://github.com/yourusername/nih-grant-typst
cd nih-grant-typst
python -m venv .venv
source .venv/bin/activate.fish
pip install -r requirements.txt
Rscript -e "install.packages(c('ggplot2', 'rmarkdown'))"

# Compile sample R01
typst compile templates/R01/R01.typ
```
````

## Features

- Auto-formatting for NIH page limits
- Dynamic budget tables with Python calculations
- Collaborative writing with Git version control
- Quarto integration for data-driven narratives

````

**3. Typical Workflow:**

1. User selects template:
   ```bash
   typst new R01 --template templates/R01
````

2. Integrates data analysis:

   ```typst
   #import "scripts/analysis/figures/stress_test.png": fig
   #figure(fig, width: 65%)[Stress test results]
   ```

3. Combines with Quarto for preliminary data:

   ````qmd
   #| echo: false
   ```{python}
   from NIHtools import format_table
   print(format_table(stats))
   ````

   ```

   ```

4. Final validation:
   ```python
   from NIHtools import validate_application
   validate_application("R01.typ")
   ```

**4. Additional Tools:**

- **Quarto Extension**: Custom NIH template components
- **Validation Scripts**:
  - Page limit checker
  - Font size validator
  - Margin compliance verification
- **Reference Formatter**: Converts between BibTeX and NIH-required formats

This setup combines the typesetting advantages of Typst with reproducible research practices through Python/R integration, while maintaining compliance with NIH formatting requirements through automated validation checks.
