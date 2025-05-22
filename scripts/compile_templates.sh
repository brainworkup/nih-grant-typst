#!/bin/bash

# Helper script to compile Typst templates with correct root setting
# This resolves import issues for relative paths

# Create output directory if it doesn't exist
mkdir -p outputs

# Compile R01 template
echo "Compiling R01 template..."
typst compile --root . templates/R01/R01.typ outputs/R01_template.pdf

# Compile R03 template
echo "Compiling R03 template..."
typst compile --root . templates/R03/R03.typ outputs/R03_template.pdf

echo "Templates compiled successfully!"
echo "Output files are in the 'outputs' directory:"
echo "- outputs/R01_template.pdf"
echo "- outputs/R03_template.pdf"
