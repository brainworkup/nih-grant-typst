# NIH Grant Workflow Diagrams

This directory contains visual representations of the NIH grant development workflow, showing the progression from template selection to submission-ready document.

## Available Diagrams

### 1. Interactive Mermaid Flowchart
**File**: `grant-workflow-diagram.md`

A comprehensive interactive flowchart using Mermaid syntax that shows:
- Template selection process
- Document development phases  
- Review and revision cycles
- Quality checkpoints
- Final submission preparation

**Best viewed in**: GitHub, GitLab, or any Mermaid-compatible markdown viewer

### 2. Text-Based Flowchart
**File**: `workflow-text-diagram.txt` (see below)

A simple ASCII representation for quick reference in any text editor.

### 3. Python Diagram Generator
**File**: `generate_workflow_diagram.py`

A matplotlib-based script to generate high-resolution PNG and PDF diagrams.

**To use**:
```bash
# Install requirements first
pip install matplotlib numpy
# Or with conda
conda install matplotlib numpy

# Generate diagrams
cd figures
python generate_workflow_diagram.py
```

## Workflow Overview

The NIH grant development process follows these key phases:

1. **Setup Phase** - Template selection and project configuration
2. **Development Phase** - Core document creation and editing
3. **Review Phase** - Content and format validation  
4. **Revision Phase** - Iterative improvements based on feedback
5. **Submission Phase** - Final preparation and delivery

## Key Decision Points

- **Grant Type Selection**: R01 (12 pages), R03 (6 pages), R21 (6 pages)
- **Content Review**: Scientific merit and clarity assessment
- **Quality Check**: Format compliance and completeness
- **Feedback Integration**: Major vs. minor revision paths

## Quality Gates

Each phase includes specific checkpoints to ensure compliance with NIH requirements:

- ✅ Page limits respected
- ✅ Required sections included  
- ✅ References properly formatted
- ✅ Figures and tables labeled
- ✅ Budget narratives aligned
- ✅ Biosketches current and relevant

## Tools Integration

The workflow integrates with the following tools in this repository:

- **`quick_start.py`**: Interactive template setup
- **Typst compiler**: Document generation
- **Template system**: Standardized formatting
- **Reference management**: Bibliography handling

For questions about the workflow or tools, see the main project README.
