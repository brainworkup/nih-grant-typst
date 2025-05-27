#!/bin/bash
# Setup script for NIH Grant Typst Templates
# This script prepares your environment for using the templates

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up NIH Grant Typst Templates...${NC}"
echo "========================================"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print status
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
    else
        echo -e "${RED}✗${NC} $2"
        return 1
    fi
}

# Check for required tools
echo -e "\n${YELLOW}Checking required tools...${NC}"

# Check Typst
if command_exists typst; then
    version=$(typst --version)
    print_status 0 "Typst installed: $version"
else
    print_status 1 "Typst not found. Please install from https://typst.app"
    echo "  Installation options:"
    echo "  - macOS: brew install typst"
    echo "  - Windows: winget install typst"
    echo "  - Linux: See https://github.com/typst/typst"
    MISSING_DEPS=true
fi

# Check Git
if command_exists git; then
    print_status 0 "Git installed"
else
    print_status 1 "Git not found"
    MISSING_DEPS=true
fi

# Check Python (optional)
if command_exists python3 || command_exists python; then
    if command_exists python3; then
        PYTHON_CMD=python3
    else
        PYTHON_CMD=python
    fi
    version=$($PYTHON_CMD --version 2>&1)
    print_status 0 "Python installed: $version"
    PYTHON_AVAILABLE=true
else
    echo -e "${YELLOW}ℹ${NC} Python not found (optional for analysis scripts)"
    PYTHON_AVAILABLE=false
fi

# Check R (optional)
if command_exists R; then
    version=$(R --version | head -n 1)
    print_status 0 "R installed: $version"
    R_AVAILABLE=true
else
    echo -e "${YELLOW}ℹ${NC} R not found (optional for analysis scripts)"
    R_AVAILABLE=false
fi

# Check Quarto (optional)
if command_exists quarto; then
    version=$(quarto --version)
    print_status 0 "Quarto installed: $version"
else
    echo -e "${YELLOW}ℹ${NC} Quarto not found (optional for progress reports)"
fi

# Exit if required dependencies are missing
if [ "$MISSING_DEPS" = true ]; then
    echo -e "\n${RED}Required dependencies are missing. Please install them and run this script again.${NC}"
    exit 1
fi

# Create necessary directories
echo -e "\n${YELLOW}Creating directory structure...${NC}"

directories=(
    "outputs"
    "outputs/figures"
    "my_grants"
    "data/raw"
    "data/cleaned"
    "data/scripts"
)

for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        print_status 0 "Created $dir"
    else
        echo -e "${YELLOW}ℹ${NC} $dir already exists"
    fi
done

# Set up Python environment if available
if [ "$PYTHON_AVAILABLE" = true ]; then
    echo -e "\n${YELLOW}Setting up Python environment...${NC}"

    # Check for conda
    if command_exists conda; then
        echo "Would you like to create a conda environment? (y/n)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            conda env create -f environment.yml
            print_status 0 "Conda environment created"
            echo -e "${GREEN}Activate with: conda activate nih-grant-typst${NC}"
        fi
    else
        # Try pip install
        echo "Would you like to install Python dependencies with pip? (y/n)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            $PYTHON_CMD -m pip install -r requirements.txt
            print_status 0 "Python dependencies installed"
        fi
    fi
fi

# Set up R packages if available
if [ "$R_AVAILABLE" = true ]; then
    echo -e "\n${YELLOW}Setting up R packages...${NC}"
    echo "Would you like to install R dependencies? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        Rscript -e "install.packages(c('tidyverse', 'ggplot2', 'patchwork', 'viridis', 'kableExtra'), repos='http://cran.rstudio.com/')"
        print_status 0 "R packages installed"
    fi
fi

# Make scripts executable
echo -e "\n${YELLOW}Making scripts executable...${NC}"
if [ -d "scripts" ]; then
    find scripts -name "*.sh" -exec chmod +x {} \;
    print_status 0 "Shell scripts are now executable"
fi

if [ -d "tools" ]; then
    find tools -name "*.sh" -exec chmod +x {} \;
    chmod +x tools/*.py 2>/dev/null || true
    print_status 0 "Tool scripts are now executable"
fi

# Test compilation
echo -e "\n${YELLOW}Testing template compilation...${NC}"
echo "Would you like to compile the example templates? (y/n)"
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
    if [ -f "scripts/compile_templates.sh" ]; then
        ./scripts/compile_templates.sh
        print_status $? "Templates compiled successfully"
    else
        echo -e "${YELLOW}ℹ${NC} compile_templates.sh not found, trying direct compilation..."
        typst compile --root . templates/R01/R01.typ outputs/R01_example.pdf
        typst compile --root . templates/R03/R03.typ outputs/R03_example.pdf
        print_status 0 "Templates compiled successfully"
    fi
fi

# VSCode setup
if command_exists code; then
    echo -e "\n${YELLOW}VSCode detected${NC}"
    echo "Would you like to install recommended VSCode extensions? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        code --install-extension nvarner.typst-lsp
        code --install-extension mgt19937.typst-preview
        code --install-extension quarto.quarto
        code --install-extension REditorSupport.r
        code --install-extension ms-python.python
        print_status 0 "VSCode extensions installed"
    fi
fi

# Final setup summary
echo -e "\n${GREEN}=== Setup Complete ===${NC}"
echo -e "\nNext steps:"
echo "1. Copy a template to start your grant:"
echo "   cp -r templates/R01 my_grants/my_r01"
echo ""
echo "2. Edit your grant:"
echo "   ${YELLOW}# Using VSCode${NC}"
echo "   code my_grants/my_r01/R01.typ"
echo ""
echo "3. Compile your grant:"
echo "   typst compile --root . my_grants/my_r01/R01.typ outputs/my_r01.pdf"
echo ""
echo -e "${GREEN}Happy grant writing!${NC}"

# Create a quick start script
cat > quick_start.sh << 'EOF'
#!/bin/bash
# Quick start script for new grants

echo "NIH Grant Quick Start"
echo "===================="
echo ""
echo "Which type of grant would you like to create?"
echo "1) R01 - Research Project Grant"
echo "2) R03 - Small Grant Program"
echo "3) Exit"
echo ""
read -p "Enter your choice (1-3): " choice

case $choice in
    1)
        grant_type="R01"
        template_dir="templates/R01"
        ;;
    2)
        grant_type="R03"
        template_dir="templates/R03"
        ;;
    3)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

read -p "Enter a name for your grant project: " project_name
project_dir="my_grants/${project_name// /_}"

echo "Creating $grant_type grant: $project_name"
cp -r "$template_dir" "$project_dir"
echo "Grant created at: $project_dir"
echo ""
echo "To edit your grant: code $project_dir/$grant_type.typ"
echo "To compile: typst compile --root . $project_dir/$grant_type.typ outputs/${project_name// /_}.pdf"
EOF

chmod +x quick_start.sh
echo -e "\n${GREEN}Created quick_start.sh for easy grant creation${NC}"
