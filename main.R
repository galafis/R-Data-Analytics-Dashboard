# Data Analytics Dashboard
# Author: Gabriel Demetrios Lafis
# Description: Advanced data analytics and visualization system

# Load required libraries
library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(plotly)
library(DT)

# Source statistical analysis module if available
if (file.exists("statistical_analysis.R")) {
  source("statistical_analysis.R")
}

# ============================================
# DATA GENERATION AND PROCESSING
# ============================================

#' Generate sample data for the dashboard
#' @author Gabriel Demetrios Lafis
generate_sample_data <- function() {
  set.seed(123)
  data.frame(
    date = seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "day"),
    sales = round(rnorm(365, mean = 1000, sd = 200), 2),
    customers = round(rnorm(365, mean = 50, sd = 10)),
    region = sample(c("North", "South", "East", "West"), 365, replace = TRUE),
    product = sample(c("Product A", "Product B", "Product C"), 365, replace = TRUE)
  )
}

#' Process sales data by region
#' @param data Data frame of raw data
#' @return Summary by region
#' @author Gabriel Demetrios Lafis
process_sales_data <- function(data) {
  data %>%
    group_by(region) %>%
    summarise(
      total_sales = sum(sales),
      avg_customers = mean(customers),
      .groups = 'drop'
    )
}

# ============================================
# VISUALIZATION HELPERS
# ============================================

#' Create sales trend plot using ggplot2
#' @param data Data frame with date and sales
#' @return ggplot object
#' @author Gabriel Demetrios Lafis
create_sales_plot <- function(data) {
  ggplot(data, aes(x = date, y = sales)) +
    geom_line(color = "#2E86AB", size = 1) +
    geom_smooth(method = "loess", color = "#A23B72", fill = "#F18F01", alpha = 0.3) +
    labs(
      title = "Sales Trend Analysis",
      subtitle = "Daily sales performance over time",
      x = "Date",
      y = "Sales ($)",
      caption = "Created by Gabriel Demetrios Lafis"
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray60")
    )
}

# ============================================
# MAIN EXECUTION PIPELINE
# ============================================

#' Main entry point for batch analysis and reporting
#' - Generates data
#' - Runs processing, ML, and statistical analyses
#' - Saves plots and generates reports
#' @author Gabriel Demetrios Lafis
main <- function() {
  cat("🚀 Starting Data Analytics Pipeline\n")
  cat("👨‍💻 Created by Gabriel Demetrios Lafis\n\n")

  # Generate and process data
  raw_data <- generate_sample_data()
  processed_data <- process_sales_data(raw_data)

  # Create visualizations
  sales_plot <- create_sales_plot(raw_data)

  # Ensure plots directory exists
  if (!dir.exists("plots")) dir.create("plots")

  # Save plots
  ggsave("plots/sales_trend.png", sales_plot, width = 12, height = 8, dpi = 300)

  # Optional: Advanced statistical analysis and ML if module is available
  if (exists("perform_time_series_analysis")) {
    ts_results <- perform_time_series_analysis(raw_data)
    cat("\n🔮 ARIMA 30-day forecast created.\n")
  }

  if (exists("perform_clustering")) {
    km <- perform_clustering(raw_data, centers = 3)
    cat("\n🧩 K-means clustering completed.\n")
  }

  if (exists("build_predictive_model")) {
    ml_rf <- build_predictive_model(raw_data, method = "rf")
    cat("\n🤖 Random Forest model trained. Metrics:\n")
    print(ml_rf$metrics)
  }

  if (exists("perform_correlation_analysis")) {
    cor_mat <- perform_correlation_analysis(raw_data)
    cat("\n🔗 Correlation analysis computed.\n")
  }

  if (exists("generate_statistical_report")) {
    report_path <- generate_statistical_report(raw_data)
    cat("\n📝 Report generated at:", report_path, "\n")
  }

  # Print summary statistics
  cat("\n📊 Data Summary:\n")
  print(summary(raw_data))

  cat("\n📈 Regional Analysis:\n")
  print(processed_data)

  cat("\n✅ Analysis complete! Check plots/ and reports/ directories.\n")
}

# Run main function when executed non-interactively
if (!interactive()) {
  main()
}
