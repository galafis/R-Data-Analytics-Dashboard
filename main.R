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

# Generate sample data
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

# Data processing functions
process_sales_data <- function(data) {
  data %>%
    group_by(region) %>%
    summarise(
      total_sales = sum(sales),
      avg_customers = mean(customers),
      .groups = 'drop'
    )
}

# Visualization functions
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

# Main execution
main <- function() {
  cat("🚀 Starting Data Analytics Dashboard\n")
  cat("👨‍💻 Created by Gabriel Demetrios Lafis\n\n")
  
  # Generate and process data
  raw_data <- generate_sample_data()
  processed_data <- process_sales_data(raw_data)
  
  # Create visualizations
  sales_plot <- create_sales_plot(raw_data)
  
  # Save plots
  ggsave("plots/sales_trend.png", sales_plot, width = 12, height = 8, dpi = 300)
  
  # Print summary statistics
  cat("📊 Data Summary:\n")
  print(summary(raw_data))
  
  cat("\n📈 Regional Analysis:\n")
  print(processed_data)
  
  cat("\n✅ Analysis complete! Check plots/ directory for visualizations.\n")
}

# Run main function
if (!interactive()) {
  main()
}
