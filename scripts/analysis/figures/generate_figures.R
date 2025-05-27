#!/usr/bin/env Rscript

#' Z-Score Visualization for NIH Grant Applications
#'
#' This script generates a visually appealing normal distribution plot
#' that highlights different z-score cutoffs and their corresponding
#' percentiles. Useful for explaining statistical thresholds in grant
#' applications.
#'
#' Author: Your Name
#' Date: 2025-05-22

# Load required libraries
library(tidyverse)
library(ggplot2)
library(dplyr)
library(patchwork)
library(viridis)
library(scales)

# Set a clean modern theme
theme_set(
  theme_minimal(base_size = 14) +
    theme(
      plot.title = element_text(face = "bold", size = 16),
      plot.subtitle = element_text(size = 12, color = "gray30"),
      plot.caption = element_text(size = 8, color = "gray50"),
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      legend.position = "bottom",
      plot.background = element_rect(fill = "white", color = NA),
      axis.title = element_text(face = "bold"),
      plot.margin = margin(20, 20, 20, 20)
    )
)

# Create a function to generate the Gaussian distribution plot
create_gaussian_plot <- function(save_path = NULL, width = 10, height = 7) {
  # Create sequence of z-scores
  z_scores <- seq(-4, 4, by = 0.01)

  # Create data frame with z-scores and corresponding density values
  gaussian_df <- tibble(
    z = z_scores,
    density = dnorm(z_scores),
    # Calculate cumulative probability for each z-score
    cumulative_prob = pnorm(z_scores)
  )

  # Define critical z-score cutoffs and their labels
  cutoffs <- tribble(
    ~z,
    ~label,
    ~percentile,
    ~color,
    -1.96,
    "z = -1.96\n(2.5%)",
    0.025,
    "#FF5252",
    -1.645,
    "z = -1.645\n(5%)",
    0.05,
    "#FF9800",
    0,
    "z = 0\n(50%)",
    0.5,
    "#2196F3",
    1.645,
    "z = 1.645\n(95%)",
    0.95,
    "#FF9800",
    1.96,
    "z = 1.96\n(97.5%)",
    0.975,
    "#FF5252"
  )

  # Generate the main distribution plot
  p1 <- ggplot(gaussian_df, aes(x = z, y = density)) +
    # Fill the curve with a solid color
    geom_area(
      fill = "#E3F2FD",
      alpha = 0.7
    ) +

    # Add the distribution curve
    geom_line(color = "black", linewidth = 1) +

    # Add vertical lines for critical z-values
    geom_vline(
      data = cutoffs,
      aes(xintercept = z, color = color),
      linetype = "dashed",
      linewidth = 0.8
    ) +
    scale_color_identity() +

    # Add labels for critical values
    geom_label(
      data = cutoffs,
      aes(x = z, y = dnorm(z) + 0.03, label = label, color = color),
      fill = "white",
      alpha = 0.9,
      fontface = "bold",
      size = 3.5
    ) +

    # Add title and labels
    labs(
      title = "Normal Distribution with Critical Z-Score Cutoffs",
      subtitle = "Visualizing common statistical thresholds used in research",
      x = "Z-Score",
      y = "Density",
      caption = "Created with R and ggplot2 for NIH grant applications"
    ) +

    # Set axis limits and remove legend
    coord_cartesian(ylim = c(0, 0.45)) +
    guides(fill = "none")

  # Create a cumulative distribution function plot
  p2 <- ggplot(gaussian_df, aes(x = z, y = cumulative_prob)) +
    geom_line(linewidth = 1, color = "#673AB7") +

    # Add horizontal lines for percentiles
    geom_hline(
      data = cutoffs,
      aes(yintercept = percentile, color = color),
      linetype = "dashed",
      linewidth = 0.6
    ) +
    scale_color_identity() +

    # Add labels for percentiles
    geom_label(
      data = cutoffs,
      aes(
        x = ifelse(z < 0, z - 0.5, z + 0.5),
        y = percentile,
        label = scales::percent(percentile, accuracy = 0.1),
        color = color
      ),
      fill = "white",
      alpha = 0.9,
      fontface = "bold",
      size = 3.5
    ) +

    # Add title and labels
    labs(
      title = "Cumulative Distribution Function",
      subtitle = "Probability of observing a value less than or equal to Z",
      x = "Z-Score",
      y = "Cumulative Probability"
    ) +

    # Format y-axis as percentage
    scale_y_continuous(labels = scales::percent) +
    coord_cartesian(ylim = c(0, 1))

  # Combine plots using patchwork
  combined_plot <- p1 /
    p2 +
    plot_layout(heights = c(2, 1)) +
    plot_annotation(
      title = "Statistical Significance Thresholds in Normal Distributions",
      subtitle = "Visualizing both probability density and cumulative probability",
      theme = theme(
        plot.title = element_text(size = 18, face = "bold"),
        plot.subtitle = element_text(size = 14, color = "gray30")
      )
    )

  # Save the plot if a path is provided
  if (!is.null(save_path)) {
    ggsave(
      filename = save_path,
      plot = combined_plot,
      width = width,
      height = height,
      dpi = 300
    )
    cat("Plot saved to:", save_path, "\n")
  }

  return(combined_plot)
}

# Create a shaded regions plot highlighting specific areas
create_shaded_regions_plot <- function(
  save_path = NULL,
  width = 10,
  height = 6
) {
  # Create sequence of z-scores
  z_scores <- seq(-4, 4, by = 0.01)

  # Create data frame with z-scores and corresponding density values
  gaussian_df <- tibble(
    z = z_scores,
    density = dnorm(z_scores)
  )

  # Define regions to shade with finite bounds
  regions <- tribble(
    ~start,
    ~end,
    ~region_name,
    ~fill_color,
    ~alpha,
    -4,
    -1.96,
    "p < 0.025",
    "#E57373",
    0.7,
    -1.96,
    -1.645,
    "0.025 < p < 0.05",
    "#FFB74D",
    0.6,
    -1.645,
    1.645,
    "0.05 < p < 0.95",
    "#81C784",
    0.5,
    1.645,
    1.96,
    "0.95 < p < 0.975",
    "#FFB74D",
    0.6,
    1.96,
    4,
    "p > 0.975",
    "#E57373",
    0.7
  )

  # Function to calculate area under the curve for each region
  calculate_area <- function(start_z, end_z) {
    # Calculate the probability (area)
    prob <- pnorm(end_z) - pnorm(start_z)
    return(prob)
  }

  # Add probability values to regions
  regions <- regions %>%
    rowwise() %>%
    mutate(
      probability = calculate_area(start, end),
      label_z = (start + end) / 2,
      label_y = dnorm(label_z) / 2
    ) %>%
    ungroup()

  # Create base plot
  p <- ggplot(gaussian_df, aes(x = z, y = density)) +
    # Add base ribbon for entire distribution
    geom_ribbon(
      aes(x = z, ymin = 0, ymax = density),
      fill = "#BBDEFB",
      alpha = 0.3
    )

  # Add shaded regions one by one
  for (i in 1:nrow(regions)) {
    region <- regions[i, ]

    # Filter data for this region
    region_data <- gaussian_df %>%
      filter(z >= region$start, z <= region$end)

    # Add shaded region
    p <- p +
      geom_ribbon(
        data = region_data,
        aes(x = z, ymin = 0, ymax = density),
        fill = region$fill_color,
        alpha = region$alpha,
        inherit.aes = FALSE
      )
  }

  # Add the distribution curve
  p <- p + geom_line(color = "black", linewidth = 1)

  # Add region labels
  for (i in 1:nrow(regions)) {
    region <- regions[i, ]

    label_data <- data.frame(
      x = region$label_z,
      y = region$label_y,
      label = paste0(
        region$region_name,
        "\n",
        scales::percent(region$probability, accuracy = 0.1)
      )
    )

    p <- p +
      geom_label(
        data = label_data,
        aes(x = x, y = y, label = label),
        fill = region$fill_color,
        color = "white",
        fontface = "bold",
        size = 3.5,
        inherit.aes = FALSE
      )
  }

  # Add title and labels
  p <- p +
    labs(
      title = "Critical Regions in the Normal Distribution",
      subtitle = "Highlighting common statistical thresholds and their probabilities",
      x = "Z-Score",
      y = "Density",
      caption = "Created with R and ggplot2 for NIH grant applications"
    ) +
    # Set axis limits and theme adjustments
    coord_cartesian(ylim = c(0, 0.45)) +
    guides(alpha = "none") +
    theme(legend.position = "none")

  # Save the plot if a path is provided
  if (!is.null(save_path)) {
    ggsave(
      filename = save_path,
      plot = p,
      width = width,
      height = height,
      dpi = 300
    )
    cat("Shaded plot saved to:", save_path, "\n")
  }

  return(p)
}

# Generate all plots
main <- function() {
  # Create output directory if it doesn't exist
  dir.create("outputs/figures", recursive = TRUE, showWarnings = FALSE)

  # Generate and save plots
  gaussian_plot <- create_gaussian_plot("outputs/figures/gaussian_z_scores.png")
  shaded_plot <- create_shaded_regions_plot(
    "outputs/figures/gaussian_regions.png"
  )

  # Print success message
  cat("Successfully generated the following files:\n")
  cat("1. outputs/figures/gaussian_z_scores.png\n")
  cat("2. outputs/figures/gaussian_regions.png\n")

  # Display plots in RStudio (if running interactively)
  if (interactive()) {
    print(gaussian_plot)
    print(shaded_plot)
  }
}

# Run the main function if this script is executed
if (!interactive() || getOption("run_main", FALSE)) {
  main()
}
