# GitHub Repository Setup for NIH Grant Application Generator

Your task is to create a GitHub repository that generates NIH grant applications (R01, R03, etc.) using Typst as the primary markup language. The repository should be structured to work seamlessly with VSCode or Positron as development environments, and integrate with R and Python for data analysis and visualization, using Quarto for reproducible documentation.

## Repository Structure

Create a well-organized repository with the following components:

1. Core Typst templates for NIH grant applications (R01, R03, etc.)
2. Integration scripts for R and Python
3. VSCode/Positron configuration files
4. Documentation using Quarto
5. Example grant applications
6. CI/CD pipeline for validation

## Implementation Steps

1. **Initialize Repository**
   - Create a new GitHub repository with an appropriate name (e.g., `nih-grant-typst`)
   - Add README.md, LICENSE, and .gitignore files

2. **Set Up Typst Templates**
   - Create base templates for different NIH grant types
   - Structure templates to follow NIH guidelines for margins, fonts, and sections
   - Implement variables for customization

3. **Integrate R and Python**
   - Create directories for R and Python scripts
   - Set up example scripts that generate figures and tables for grants
   - Establish a workflow for integrating analysis outputs into Typst documents

4. **Configure Development Environment**
   - Add .vscode/settings.json for VSCode configuration
   - Include extensions.json to recommend Typst, R, Python, and Quarto extensions
   - Add Positron-specific configurations if applicable

5. **Implement Quarto Documentation**
   - Create comprehensive documentation using Quarto
   - Include tutorials for using the templates
   - Document the integration between Typst, R, and Python

6. **Create Example Applications**
   - Provide complete example grant applications
   - Include samples of figures, tables, and bibliographies

## Output Format

The repository should have the following structure:
```
nih-grant-typst/
├── README.md
├── LICENSE
├── .gitignore
├── .vscode/
│   ├── settings.json
│   └── extensions.json
├── templates/
│   ├── r01/
│   │   ├── main.typ
│   │   ├── sections/
│   │   └── config.typ
│   ├── r03/
│   │   ├── main.typ
│   │   ├── sections/
│   │   └── config.typ
│   └── common/
│       ├── nih-functions.typ
│       └── bibliography.typ
├── scripts/
│   ├── r/
│   │   └── generate_figures.R
│   └── python/
│       └── data_analysis.py
├── examples/
│   ├── r01-example/
│   └── r03-example/
├── docs/
│   ├── _quarto.yml
│   ├── index.qmd
│   └── tutorials/
└── .github/
    └── workflows/
        └── validate.yml
```

## Examples

### Example: R01 Template Structure (main.typ)

```typst
#import "config.typ": *
#import "../common/nih-functions.typ": *

#show: nih-document.with(
  grant-type: "R01",
  pi-name: "[PI Name]",
  institution: "[Institution]",
  project-title: "[Project Title]"
)

#include "sections/abstract.typ"
#include "sections/specific-aims.typ"
#include "sections/significance.typ"
#include "sections/innovation.typ"
#include "sections/approach.typ"
#include "sections/bibliography.typ"
```

### Example: Integration with R (in a Quarto document)

```quarto
---
title: "Data Analysis for NIH Grant"
format: html
---

```{r}
#| label: fig-survival
#| fig-cap: "Survival analysis comparing treatment groups"

library(survival)
library(ggplot2)

# Analysis code here
ggplot(survival_data, aes(x=time, y=surv, color=group)) + 
  geom_line() +
  theme_minimal() +
  labs(title="Kaplan-Meier Survival Curves")
```

The figure will be exported and can be referenced in your Typst document:

```typst
#figure(
  image("figures/survival-plot.png"),
  caption: [Survival analysis comparing treatment groups.]
)
```
```

## Notes

- Ensure all templates strictly adhere to NIH formatting requirements
- Typst is relatively new, so include detailed setup instructions
- Consider using GitHub Actions to validate that generated PDFs meet NIH requirements
- Structure templates to be modular for easy updating when NIH guidelines change
- Include clear documentation on how to customize templates for different research areas
