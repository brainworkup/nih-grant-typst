#!/usr/bin/env Rscript

#' Stop Signal Task Data Preprocessing Script
#'
#' This script preprocesses raw stop signal task data, applying quality control
#' criteria and calculating derived measures including SSRT.
#'
#' @author [Researcher Name]
#' @created 2025-03-20
#' @modified 2025-04-05
#'
#' @input Raw CSV files from stop signal task in data/raw/behavioral/
#' @output Processed CSV file with summary measures in data/cleaned/behavioral/
#' @log Processing log in data/cleaned/processing_logs/
#'
#' @dependencies
#'   - R (>= 4.2.0)
#'   - tidyverse (>= 2.0.0)
#'   - here (>= 1.0.0)
#'   - argparse (>= 2.1.0)
#'
#' @example
#'   Rscript data/scripts/preprocessing/behavioral_preproc_stop_signal.R \
#'     --input "data/raw/behavioral/" \
#'     --output "data/cleaned/behavioral/stop_signal_task_v1.0_2025-04-10.csv" \
#'     --log "data/cleaned/processing_logs/stop_signal_preprocessing_2025-04-10.log"

# Load libraries
suppressPackageStartupMessages({
  library(tidyverse)
  library(here)
  library(argparse)
  library(lubridate)
})

# Set up argument parser
parser <- ArgumentParser(description = "Preprocess stop signal task data")
parser$add_argument(
  "--input",
  type = "character",
  required = TRUE,
  help = "Directory containing raw stop signal task files"
)
parser$add_argument(
  "--output",
  type = "character",
  required = TRUE,
  help = "Output file path for processed data"
)
parser$add_argument(
  "--log",
  type = "character",
  required = TRUE,
  help = "Log file path"
)
args <- parser$parse_args()

# Initialize log file
log_conn <- file(args$log, open = "w")
writeLines(paste("Stop Signal Task Preprocessing Log", Sys.time()), log_conn)
writeLines(paste("Input directory:", args$input), log_conn)
writeLines(paste("Output file:", args$output), log_conn)
writeLines("", log_conn)

# Start processing timer
start_time <- Sys.time()
writeLines(paste("Processing started at:", start_time), log_conn)

# Find all raw data files
raw_files <- list.files(
  args$input,
  pattern = ".*StopSignal\\.csv$",
  full.names = TRUE
)
writeLines(paste("Found", length(raw_files), "raw data files"), log_conn)

# Function to process a single file
process_file <- function(file_path, log_conn) {
  # Log the current file
  writeLines(paste("\nProcessing file:", basename(file_path)), log_conn)

  # Read the data
  tryCatch(
    {
      data <- read_csv(file_path, show_col_types = FALSE)
      writeLines(paste("  Read", nrow(data), "trials"), log_conn)

      # Extract subject info from the first row
      subject_id <- unique(data$subject_id)[1]
      session_date <- unique(data$session_date)[1]
      age <- unique(data$age)[1]
      group <- unique(data$group)[1]

      # Filter out practice trials (usually first 10)
      data <- data %>% filter(trial_number > 10)
      writeLines(
        paste("  Removed practice trials. Remaining trials:", nrow(data)),
        log_conn
      )

      # Remove anticipatory responses (RT < 100ms)
      data_filtered <- data %>%
        filter(is.na(rt) | rt >= 100)

      anticipatory_count <- nrow(data) - nrow(data_filtered)
      writeLines(
        paste(
          "  Removed",
          anticipatory_count,
          "anticipatory responses (<100ms)"
        ),
        log_conn
      )
      data <- data_filtered

      # Identify go and stop trials
      go_trials <- data %>% filter(trial_type == "go")
      stop_trials <- data %>% filter(trial_type == "stop")

      writeLines(paste("  Go trials:", nrow(go_trials)), log_conn)
      writeLines(paste("  Stop trials:", nrow(stop_trials)), log_conn)

      # Calculate go trial metrics
      go_rt <- go_trials %>%
        filter(!is.na(rt)) %>%
        pull(rt)

      mean_go_rt <- mean(go_rt, na.rm = TRUE)
      sd_go_rt <- sd(go_rt, na.rm = TRUE)

      # Remove RT outliers (>3SD from mean)
      rt_upper_limit <- mean_go_rt + 3 * sd_go_rt
      data_filtered <- data %>%
        filter(is.na(rt) | rt <= rt_upper_limit)

      outlier_count <- nrow(data) - nrow(data_filtered)
      writeLines(
        paste("  Removed", outlier_count, "RT outliers (>3SD)"),
        log_conn
      )
      data <- data_filtered

      # Recalculate after outlier removal
      go_trials <- data %>% filter(trial_type == "go")
      stop_trials <- data %>% filter(trial_type == "stop")

      go_rt <- go_trials %>%
        filter(!is.na(rt)) %>%
        pull(rt)

      mean_go_rt <- mean(go_rt, na.rm = TRUE)
      sd_go_rt <- sd(go_rt, na.rm = TRUE)

      # Calculate accuracies
      go_accuracy <- mean(go_trials$correct, na.rm = TRUE)
      stop_accuracy <- mean(stop_trials$successful_stop, na.rm = TRUE)

      # Calculate omission and commission rates
      omission_rate <- sum(is.na(go_trials$response)) / nrow(go_trials)
      commission_rate <- 1 - stop_accuracy

      # Calculate mean SSD
      mean_ssd <- mean(stop_trials$ssd, na.rm = TRUE)

      # Calculate SSRT using integration method
      # 1. Rank-order go RTs
      sorted_go_rt <- sort(go_rt)

      # 2. Find the nth RT where n = number of go trials × p(respond|stop signal)
      n <- round(length(sorted_go_rt) * commission_rate)
      nth_rt <- sorted_go_rt[n]

      # 3. SSRT = nth go RT - mean SSD
      ssrt <- nth_rt - mean_ssd

      # Calculate post-error slowing
      # Create a lagged trial_type and correct column
      data <- data %>%
        mutate(
          prev_trial_type = lag(trial_type),
          prev_correct = lag(correct),
          prev_successful_stop = lag(successful_stop)
        )

      # Calculate RTs following different trial types
      post_correct_go_rt <- data %>%
        filter(
          trial_type == "go",
          prev_trial_type == "go",
          prev_correct == 1
        ) %>%
        pull(rt) %>%
        mean(na.rm = TRUE)

      post_error_go_rt <- data %>%
        filter(
          trial_type == "go",
          prev_trial_type == "stop",
          prev_successful_stop == 0
        ) %>%
        pull(rt) %>%
        mean(na.rm = TRUE)

      post_error_slowing <- post_error_go_rt - post_correct_go_rt

      # Apply exclusion criteria
      excluded <- FALSE
      exclusion_reason <- NA

      if (go_accuracy < 0.8) {
        excluded <- TRUE
        exclusion_reason <- "Go accuracy < 80%"
        writeLines("  EXCLUDED: Go accuracy < 80%", log_conn)
      } else if (stop_accuracy < 0.2 || stop_accuracy > 0.8) {
        excluded <- TRUE
        exclusion_reason <- paste0(
          "Stop accuracy outside range (",
          round(stop_accuracy * 100),
          "%)"
        )
        writeLines("  EXCLUDED: Stop accuracy outside 20%-80% range", log_conn)
      } else if (ssrt < 50 || ssrt > 500) {
        excluded <- TRUE
        exclusion_reason <- paste0("Invalid SSRT: ", round(ssrt), "ms")
        writeLines("  EXCLUDED: SSRT outside valid range", log_conn)
      } else if (anticipatory_count / nrow(data) > 0.1) {
        excluded <- TRUE
        exclusion_reason <- "Too many anticipatory responses"
        writeLines("  EXCLUDED: >10% anticipatory responses", log_conn)
      }

      # Create summary row
      summary_row <- tibble(
        subject_id = subject_id,
        group = group,
        age = age,
        session_date = session_date,
        ssrt = ssrt,
        mean_go_rt = mean_go_rt,
        sd_go_rt = sd_go_rt,
        go_accuracy = go_accuracy,
        stop_accuracy = stop_accuracy,
        omission_rate = omission_rate,
        commission_rate = commission_rate,
        mean_ssd = mean_ssd,
        post_error_slowing = post_error_slowing,
        excluded = excluded,
        exclusion_reason = exclusion_reason
      )

      # Log the results
      writeLines(paste("  Mean Go RT:", round(mean_go_rt), "ms"), log_conn)
      writeLines(
        paste("  Go Accuracy:", round(go_accuracy * 100), "%"),
        log_conn
      )
      writeLines(
        paste("  Stop Accuracy:", round(stop_accuracy * 100), "%"),
        log_conn
      )
      writeLines(paste("  SSRT:", round(ssrt), "ms"), log_conn)

      return(summary_row)
    },
    error = function(e) {
      writeLines(paste("  ERROR processing file:", e$message), log_conn)
      return(NULL)
    }
  )
}

# Process all files
all_results <- map_dfr(raw_files, ~ process_file(.x, log_conn))

# Write the results
dir.create(dirname(args$output), showWarnings = FALSE, recursive = TRUE)
write_csv(all_results, args$output)
writeLines(paste("\nProcessed data written to:", args$output), log_conn)
writeLines(paste("Total subjects processed:", nrow(all_results)), log_conn)
writeLines(paste("Subjects excluded:", sum(all_results$excluded)), log_conn)

# End processing timer
end_time <- Sys.time()
processing_time <- difftime(end_time, start_time, units = "mins")
writeLines(paste("\nProcessing completed at:", end_time), log_conn)
writeLines(
  paste("Total processing time:", round(processing_time, 2), "minutes"),
  log_conn
)

# Close log file
close(log_conn)
