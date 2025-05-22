#!/usr/bin/env python3
"""
Reference Formatter for NIH Grant Applications

This script provides utilities for formatting and managing references for NIH grant applications.
It can convert BibTeX references to NIH-style references, check for duplicates, and
generate reference lists in various formats.

Usage:
    python reference_formatter.py input.bib --output refs.txt --format nih
    python reference_formatter.py input.bib --check-duplicates
    python reference_formatter.py --extract-citations document.typ

Author: Your Name
Date: 2025-05-22
"""

import argparse
import re
import sys
from pathlib import Path
from typing import Dict, List, Optional, Set, Tuple


class BibEntry:
    """Class representing a bibliographic entry."""

    def __init__(self, entry_type: str, key: str, fields: Dict[str, str]):
        self.entry_type = entry_type
        self.key = key
        self.fields = fields

    def __repr__(self) -> str:
        return f"BibEntry({self.entry_type}, {self.key}, {len(self.fields)} fields)"

    def get_author_list(self) -> List[str]:
        """Extract list of authors from the author field."""
        if "author" not in self.fields:
            return []

        # Split authors by 'and' and clean up each name
        authors = self.fields["author"].split(" and ")
        return [author.strip() for author in authors]

    def get_first_author_last_name(self) -> str:
        """Get the last name of the first author."""
        authors = self.get_author_list()
        if not authors:
            return ""

        # Handle different name formats (Last, First or First Last)
        first_author = authors[0]
        if "," in first_author:
            return first_author.split(",")[0].strip()
        else:
            # Assume the last word is the last name
            return first_author.split()[-1].strip()

    def format_nih_style(self) -> str:
        """Format the reference in NIH style."""
        try:
            # Get basic fields with fallbacks
            authors = self.get_author_list()
            title = self.fields.get("title", "").strip("{}").rstrip(".")
            journal = self.fields.get("journal", "").strip("{}")
            year = self.fields.get("year", "")
            volume = self.fields.get("volume", "")
            number = self.fields.get("number", "")
            pages = self.fields.get("pages", "").replace("--", "-")

            # Format authors (up to 3, then et al.)
            if len(authors) > 3:
                author_str = ", ".join(authors[:3]) + ", et al."
            else:
                author_str = ", ".join(authors)

            # Replace any {} in LaTeX titles
            title = re.sub(r"{|}", "", title)

            # Format issue information
            issue_info = []
            if volume:
                issue_info.append(volume)
            if number:
                issue_info.append(f"({number})")
            if pages:
                issue_info.append(f":{pages}")

            issue_str = "".join(issue_info)

            # Assemble the reference
            return f"{author_str}. {title}. {journal}. {year};{issue_str}."

        except Exception as e:
            return f"Error formatting reference {self.key}: {str(e)}"


def parse_bibtex(content: str) -> List[BibEntry]:
    """Parse BibTeX content into BibEntry objects."""
    entries = []
    # Simple regex pattern to match BibTeX entries
    pattern = re.compile(r"@(\w+)\s*{\s*([^,]+),\s*((?:.|\n)*?)\n}", re.MULTILINE)

    for match in pattern.finditer(content):
        entry_type, key, fields_text = match.groups()

        # Parse fields
        fields = {}
        current_field = None
        current_value = []
        in_braces = 0

        # Split by lines and process
        for line in fields_text.split("\n"):
            line = line.strip()
            if not line or line.startswith("%"):
                continue

            # Check if this line starts a new field
            if "=" in line and in_braces == 0:
                # Save previous field if exists
                if current_field:
                    fields[current_field] = "".join(current_value).strip(",").strip()
                    current_value = []

                # Parse new field
                field_parts = line.split("=", 1)
                current_field = field_parts[0].strip().lower()
                current_value.append(field_parts[1].strip())
            else:
                # Continue previous field
                current_value.append(line)

            # Track brace nesting
            in_braces += line.count("{") - line.count("}")

        # Add the last field
        if current_field:
            fields[current_field] = "".join(current_value).strip(",").strip()

        entries.append(BibEntry(entry_type.lower(), key, fields))

    return entries


def find_duplicate_references(
    entries: List[BibEntry],
) -> List[Tuple[BibEntry, BibEntry]]:
    """Find potential duplicate references in the list of entries."""
    duplicates = []

    # Compare each pair of entries
    for i, entry1 in enumerate(entries):
        for entry2 in entries[i + 1 :]:
            # Check if titles are similar
            title1 = entry1.fields.get("title", "").lower()
            title2 = entry2.fields.get("title", "").lower()

            # Simple similarity check - can be improved with better algorithms
            if title1 and title2 and (title1 in title2 or title2 in title1):
                duplicates.append((entry1, entry2))

    return duplicates


def extract_citations(typst_content: str) -> Set[str]:
    """Extract citation keys from a Typst document."""
    # Find all citation keys in the format @key or @key[page]
    citation_pattern = re.compile(r"@([a-zA-Z0-9_-]+)(?:\[\d+\])?")
    return set(citation_pattern.findall(typst_content))


def main():
    """Main function for CLI usage."""
    parser = argparse.ArgumentParser(
        description="Format references for NIH grant applications"
    )
    parser.add_argument("input_file", nargs="?", help="Input BibTeX file")
    parser.add_argument("--output", "-o", help="Output file (default: stdout)")
    parser.add_argument(
        "--format",
        choices=["nih", "bibtex", "apa"],
        default="nih",
        help="Output format (default: nih)",
    )
    parser.add_argument(
        "--check-duplicates",
        action="store_true",
        help="Check for potential duplicate references",
    )
    parser.add_argument(
        "--extract-citations",
        metavar="FILE",
        help="Extract citation keys from a Typst document",
    )
    parser.add_argument(
        "--sort",
        choices=["first-author", "year", "key"],
        help="Sort references by given criteria",
    )

    args = parser.parse_args()

    # Extract citations from Typst document
    if args.extract_citations:
        try:
            with open(args.extract_citations, "r", encoding="utf-8") as f:
                content = f.read()

            citations = extract_citations(content)
            print(f"Found {len(citations)} unique citations:")
            for citation in sorted(citations):
                print(f"  {citation}")
            return
        except Exception as e:
            print(f"Error extracting citations: {str(e)}", file=sys.stderr)
            sys.exit(1)

    # Check if input file is provided for other operations
    if not args.input_file:
        parser.print_help()
        sys.exit(1)

    # Read and parse input file
    try:
        with open(args.input_file, "r", encoding="utf-8") as f:
            content = f.read()

        entries = parse_bibtex(content)
        print(
            f"Parsed {len(entries)} references from {args.input_file}", file=sys.stderr
        )

        # Check for duplicates
        if args.check_duplicates:
            duplicates = find_duplicate_references(entries)
            if duplicates:
                print(
                    f"Found {len(duplicates)} potential duplicate references:",
                    file=sys.stderr,
                )
                for entry1, entry2 in duplicates:
                    print(
                        f"  Potential duplicate: {entry1.key} and {entry2.key}",
                        file=sys.stderr,
                    )
                    print(
                        f"    Title 1: {entry1.fields.get('title', '')}",
                        file=sys.stderr,
                    )
                    print(
                        f"    Title 2: {entry2.fields.get('title', '')}",
                        file=sys.stderr,
                    )
            else:
                print("No potential duplicates found.", file=sys.stderr)
            return

        # Sort references if requested
        if args.sort:
            if args.sort == "first-author":
                entries.sort(key=lambda e: e.get_first_author_last_name())
            elif args.sort == "year":
                entries.sort(key=lambda e: e.fields.get("year", "0"))
            elif args.sort == "key":
                entries.sort(key=lambda e: e.key)

        # Format references
        formatted = []
        for entry in entries:
            if args.format == "nih":
                formatted.append(entry.format_nih_style())
            # Add other format options as needed

        # Output
        output = "\n\n".join(formatted)
        if args.output:
            with open(args.output, "w", encoding="utf-8") as f:
                f.write(output)
            print(
                f"Wrote {len(entries)} formatted references to {args.output}",
                file=sys.stderr,
            )
        else:
            print(output)

    except Exception as e:
        print(f"Error processing references: {str(e)}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
