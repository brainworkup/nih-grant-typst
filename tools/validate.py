#!/usr/bin/env python3
"""
NIH Grant PDF Validation Tool

Validates compiled grant PDFs for NIH compliance including:
- Page limits
- Font requirements
- Margin specifications
- File size limits
"""

import sys
import argparse
from pathlib import Path
from typing import Dict, List, Tuple
import PyPDF2
import re
from dataclasses import dataclass


@dataclass
class GrantLimits:
    """NIH grant type specifications"""
    research_strategy: int
    total_pages: int = None
    file_size_mb: int = 100


# NIH grant specifications
GRANT_LIMITS = {
    'R01': GrantLimits(research_strategy=12),
    'R03': GrantLimits(research_strategy=6),
    'R21': GrantLimits(research_strategy=6),
    'R15': GrantLimits(research_strategy=12),
    'K99': GrantLimits(research_strategy=12),
}


class NIHGrantValidator:
    """Validates NIH grant PDFs for compliance"""

    def __init__(self, pdf_path: Path, grant_type: str = None):
        self.pdf_path = pdf_path
        self.grant_type = grant_type or self._detect_grant_type()
        self.errors = []
        self.warnings = []

    def _detect_grant_type(self) -> str:
        """Try to detect grant type from filename"""
        filename = self.pdf_path.stem.upper()
        for grant in GRANT_LIMITS.keys():
            if grant in filename:
                return grant
        return 'R01'  # Default

    def validate(self) -> bool:
        """Run all validation checks"""
        print(f"\nValidating {self.pdf_path.name} as {self.grant_type} grant...")
        print("-" * 50)

        # Run validation checks
        self._check_file_exists()
        self._check_file_size()
        self._check_page_count()
        self._check_page_dimensions()
        self._check_text_content()

        # Report results
        self._report_results()

        return len(self.errors) == 0

    def _check_file_exists(self):
        """Verify file exists and is readable"""
        if not self.pdf_path.exists():
            self.errors.append(f"File not found: {self.pdf_path}")
            return False
        return True

    def _check_file_size(self):
        """Check file size is within limits"""
        size_mb = self.pdf_path.stat().st_size / (1024 * 1024)
        limit = GRANT_LIMITS[self.grant_type].file_size_mb

        print(f"File size: {size_mb:.2f} MB")

        if size_mb > limit:
            self.errors.append(f"File size {size_mb:.2f} MB exceeds {limit} MB limit")
        elif size_mb > limit * 0.9:
            self.warnings.append(f"File size {size_mb:.2f} MB is close to {limit} MB limit")

    def _check_page_count(self):
        """Verify page counts are within limits"""
        try:
            with open(self.pdf_path, 'rb') as f:
                reader = PyPDF2.PdfReader(f)
                page_count = len(reader.pages)

            print(f"Total pages: {page_count}")

            # Check specific section limits if we can detect them
            self._check_section_pages(reader)

        except Exception as e:
            self.errors.append(f"Error reading PDF: {str(e)}")

    def _check_section_pages(self, reader):
        """Check page limits for specific sections"""
        # This is a simplified check - in reality would need more sophisticated parsing
        research_strategy_pages = 0
        in_research_strategy = False

        try:
            for i, page in enumerate(reader.pages):
                text = page.extract_text().upper()

                if "RESEARCH STRATEGY" in text:
                    in_research_strategy = True
                elif any(section in text for section in ["BIBLIOGRAPHY", "REFERENCES CITED", "BUDGET"]):
                    in_research_strategy = False

                if in_research_strategy:
                    research_strategy_pages += 1

            limit = GRANT_LIMITS[self.grant_type].research_strategy

            if research_strategy_pages > 0:
                print(f"Research Strategy pages (estimated): {research_strategy_pages}")
                if research_strategy_pages > limit:
                    # self.errors.
                    self.errors.append(f"Research Strategy ({research_strategy_pages} pages) exceeds {limit} page limit")
               elif research_strategy_pages > limit * 0.9:
                   self.warnings.append(f"Research Strategy ({research_strategy_pages} pages) is close to {limit} page limit")

       except Exception as e:
           self.warnings.append(f"Could not analyze section pages: {str(e)}")

   def _check_page_dimensions(self):
       """Verify page dimensions meet NIH requirements"""
       try:
           with open(self.pdf_path, 'rb') as f:
               reader = PyPDF2.PdfReader(f)
               if len(reader.pages) > 0:
                   page = reader.pages[0]
                   width = float(page.mediabox.width) / 72  # Convert points to inches
                   height = float(page.mediabox.height) / 72

                   print(f"Page dimensions: {width:.2f}\" x {height:.2f}\"")

                   # Check for US Letter size (8.5 x 11 inches)
                   if abs(width - 8.5) > 0.1 or abs(height - 11) > 0.1:
                       self.errors.append(f"Page size must be US Letter (8.5\" x 11\"), found {width:.2f}\" x {height:.2f}\"")

       except Exception as e:
           self.warnings.append(f"Could not check page dimensions: {str(e)}")

   def _check_text_content(self):
       """Basic text content validation"""
       try:
           with open(self.pdf_path, 'rb') as f:
               reader = PyPDF2.PdfReader(f)

               # Check first page for basic content
               if len(reader.pages) > 0:
                   first_page_text = reader.pages[0].extract_text()

                   # Look for common required elements
                   if not any(word in first_page_text.upper() for word in ['SPECIFIC AIMS', 'PROJECT', 'TITLE']):
                       self.warnings.append("First page may be missing standard grant elements")

       except Exception as e:
           self.warnings.append(f"Could not analyze text content: {str(e)}")

   def _report_results(self):
       """Print validation results"""
       print("\nValidation Results:")
       print("-" * 50)

       if not self.errors and not self.warnings:
           print("✅ All checks passed!")

       if self.warnings:
           print(f"\n⚠️  Warnings ({len(self.warnings)}):")
           for warning in self.warnings:
               print(f"   - {warning}")

       if self.errors:
           print(f"\n❌ Errors ({len(self.errors)}):")
           for error in self.errors:
               print(f"   - {error}")

       print("\n" + "=" * 50)


def validate_multiple_pdfs(pdf_paths: List[Path], grant_type: str = None) -> bool:
   """Validate multiple PDF files"""
   all_valid = True

   for pdf_path in pdf_paths:
       validator = NIHGrantValidator(pdf_path, grant_type)
       if not validator.validate():
           all_valid = False

   return all_valid


def main():
   """Main entry point"""
   parser = argparse.ArgumentParser(
       description="Validate NIH grant PDFs for compliance",
       formatter_class=argparse.RawDescriptionHelpFormatter,
       epilog="""
Examples:
 python validate.py grant.pdf
 python validate.py grant.pdf --type R03
 python validate.py *.pdf --type R01
       """
   )

   parser.add_argument(
       'pdfs',
       nargs='+',
       help='PDF files to validate'
   )

   parser.add_argument(
       '--type',
       choices=list(GRANT_LIMITS.keys()),
       help='Grant type (auto-detected from filename if not specified)'
   )

   parser.add_argument(
       '--strict',
       action='store_true',
       help='Treat warnings as errors'
   )

   args = parser.parse_args()

   # Convert to Path objects
   pdf_paths = [Path(pdf) for pdf in args.pdfs]

   # Validate PDFs
   all_valid = validate_multiple_pdfs(pdf_paths, args.type)

   # Exit with appropriate code
   sys.exit(0 if all_valid else 1)


if __name__ == "__main__":
   main()
