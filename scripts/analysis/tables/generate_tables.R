#!/usr/bin/env Rscript

# generate_tables.R - Script for generating tables for NIH grant reports
# This script creates formatted tables for inclusion in grant reports and publications.

# Load required libraries
library(tidyverse)
library(kableExtra)
library(xtable)
library(flextable)
library(pander)

# Define function to create demographic tables
create_demographic_table <- function(data, filename = NULL, format = "html") {
  # Create table
  table <- data %>%
    select(Group, N, Age, Sex, IQ, SES) %>%
    kable(
      caption = "Demographic Characteristics by Group",
      format = format,
      booktabs = TRUE,
      align = "lccccc"
    ) %>%
    kable_styling(
      bootstrap_options = c("striped", "hover", "condensed"),
      full_width = FALSE,
      position = "center"
    ) %>%
    add_header_above(c(" " = 1, "Sample" = 1, "Demographics" = 4))

  # Save if filename is provided
  if (!is.null(filename)) {
    if (format == "latex") {
      save_kable(table, file = filename)
    } else {
      cat(table, file = filename)
    }
  }

  return(table)
}

# Define function to create statistical results tables
create_stats_table <- function(
  model_results,
  filename = NULL,
  format = "html"
) {
  # Create table
  table <- model_results %>%
    select(Predictor, Estimate, SE, t_or_z, p_value, CI_lower, CI_upper) %>%
    mutate(
      p_value = ifelse(p_value < 0.001, "<0.001", sprintf("%.3f", p_value)),
      CI = paste0(
        "[",
        sprintf("%.2f", CI_lower),
        ", ",
        sprintf("%.2f", CI_upper),
        "]"
      )
    ) %>%
    select(-CI_lower, -CI_upper) %>%
    kable(
      caption = "Statistical Model Results",
      format = format,
      booktabs = TRUE,
      col.names = c("Predictor", "Estimate", "SE", "t/z", "p-value", "95% CI"),
      align = "lccccc"
    ) %>%
    kable_styling(
      bootstrap_options = c("striped", "hover", "condensed"),
      full_width = FALSE,
      position = "center"
    )

  # Save if filename is provided
  if (!is.null(filename)) {
    if (format == "latex") {
      save_kable(table, file = filename)
    } else {
      cat(table, file = filename)
    }
  }

  return(table)
}

# Define function to create correlation tables
create_correlation_table <- function(
  correlation_matrix,
  p_values = NULL,
  filename = NULL,
  format = "html"
) {
  # Format correlation matrix with significance stars
  if (!is.null(p_values)) {
    formatted_matrix <- matrix(
      NA,
      nrow = nrow(correlation_matrix),
      ncol = ncol(correlation_matrix)
    )
    for (i in 1:nrow(correlation_matrix)) {
      for (j in 1:ncol(correlation_matrix)) {
        if (i == j) {
          formatted_matrix[i, j] <- "—"
        } else {
          stars <- ""
          if (!is.na(p_values[i, j])) {
            if (p_values[i, j] < 0.001) stars <- "***" else if (
              p_values[i, j] < 0.01
            )
              stars <- "**" else if (p_values[i, j] < 0.05) stars <- "*"
          }
          formatted_matrix[i, j] <- paste0(
            sprintf("%.2f", correlation_matrix[i, j]),
            stars
          )
        }
      }
    }

    dimnames(formatted_matrix) <- dimnames(correlation_matrix)

    table <- kable(
      formatted_matrix,
      caption = "Correlation Matrix with Significance Levels",
      format = format,
      booktabs = TRUE,
      align = "c"
    ) %>%
      kable_styling(
        bootstrap_options = c("striped", "hover", "condensed"),
        full_width = FALSE,
        position = "center"
      ) %>%
      add_footnote(
        c("* p < 0.05, ** p < 0.01, *** p < 0.001"),
        notation = "symbol"
      )
  } else {
    table <- kable(
      correlation_matrix,
      caption = "Correlation Matrix",
      format = format,
      booktabs = TRUE,
      digits = 2,
      align = "c"
    ) %>%
      kable_styling(
        bootstrap_options = c("striped", "hover", "condensed"),
        full_width = FALSE,
        position = "center"
      )
  }

  # Save if filename is provided
  if (!is.null(filename)) {
    if (format == "latex") {
      save_kable(table, file = filename)
    } else {
      cat(table, file = filename)
    }
  }

  return(table)
}

# Example usage (commented out)
#
# # Create sample demographic data
demographics <- data.frame(
  Group = c("TD", "ADHD", "ASD"),
  N = c(50, 48, 45),
  Age = c("12.4 (3.2)", "12.1 (3.5)", "11.8 (3.3)"),
  Sex = c("25M/25F", "30M/18F", "32M/13F"),
  IQ = c("112.3 (12.5)", "108.6 (13.2)", "106.8 (15.4)"),
  SES = c("46.8 (11.2)", "43.2 (12.5)", "44.5 (13.1)")
)
#
# # Create and save demographic table
create_demographic_table(demographics, "demographic_table.html")
