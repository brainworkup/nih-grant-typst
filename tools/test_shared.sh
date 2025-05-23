#!/bin/bash

echo "Testing shared components compilation..."
  # Create a test file that imports shared components
  cat > test_shared.typ << EOF
  #import "templates/shared/specific_aims.typ": specific_aims_example
  #import "templates/shared/budget.typ": budget_example
  #import "templates/shared/biosketch.typ": biosketch_example

  = Test Document
  This document tests that all shared components compile correctly.

  #specific_aims_example
  #pagebreak()
  #budget_example
  #pagebreak()
  #biosketch_example
  EOF
