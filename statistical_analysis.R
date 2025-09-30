# Advanced Statistical Analysis Module
# Author: Gabriel Demetrios Lafis
# Description: Comprehensive statistical analysis with machine learning capabilities

# Load required libraries
library(forecast)
library(corrplot)
library(cluster)
library(caret)
library(randomForest)
library(e1071)

# ============================================
# TIME SERIES ANALYSIS
# ============================================

#' Perform comprehensive time series analysis
#' @param data Data frame containing sales time series
#' @return List with decomposition, forecast, and model
#' @author Gabriel Demetrios Lafis
perform_time_series_analysis <- function(data) {
  ts_data <- ts(data$sales, frequency = 365)
  
  # Decomposition
  decomp <- decompose(ts_data)
  
  # Forecasting
  forecast_model <- auto.arima(ts_data)
  forecast_result <- forecast(forecast_model, h = 30)
  
  return(list(
    decomposition = decomp,
    forecast = forecast_result,
    model = forecast_model
  ))
}

# ============================================
# CLUSTERING ANALYSIS
# ============================================

#' Perform K-means clustering analysis
#' @param data Data frame with sales and customers
#' @param centers Number of clusters (default: 3)
#' @return K-means clustering result
#' @author Gabriel Demetrios Lafis
perform_clustering <- function(data, centers = 3) {
  cluster_data <- data %>%
    select(sales, customers) %>%
    scale()
  
  # K-means clustering
  kmeans_result <- kmeans(cluster_data, centers = centers, nstart = 25)
  
  return(kmeans_result)
}

#' Perform hierarchical clustering
#' @param data Data frame with numerical variables
#' @param k Number of clusters to cut
#' @return Hierarchical clustering result
#' @author Gabriel Demetrios Lafis
perform_hierarchical_clustering <- function(data, k = 3) {
  cluster_data <- data %>%
    select(sales, customers) %>%
    scale()
  
  # Hierarchical clustering
  dist_matrix <- dist(cluster_data, method = "euclidean")
  hc_result <- hclust(dist_matrix, method = "ward.D2")
  clusters <- cutree(hc_result, k = k)
  
  return(list(
    hclust = hc_result,
    clusters = clusters
  ))
}

# ============================================
# CORRELATION ANALYSIS
# ============================================

#' Perform correlation analysis
#' @param data Data frame with numerical variables
#' @return Correlation matrix
#' @author Gabriel Demetrios Lafis
perform_correlation_analysis <- function(data) {
  # Select numerical columns
  numerical_data <- data %>%
    select_if(is.numeric)
  
  # Calculate correlation matrix
  cor_matrix <- cor(numerical_data, use = "complete.obs")
  
  return(cor_matrix)
}

#' Plot correlation matrix
#' @param cor_matrix Correlation matrix
#' @author Gabriel Demetrios Lafis
plot_correlation_matrix <- function(cor_matrix) {
  corrplot(cor_matrix, 
           method = "color",
           type = "upper",
           order = "hclust",
           tl.col = "black",
           tl.srt = 45,
           addCoef.col = "black",
           number.cex = 0.7)
}

# ============================================
# PREDICTIVE MODELING (MACHINE LEARNING)
# ============================================

#' Build predictive model for sales forecasting
#' @param data Training data
#' @param method Model type: "rf" (Random Forest), "svm" (SVM), or "lm" (Linear Model)
#' @return Trained model
#' @author Gabriel Demetrios Lafis
build_predictive_model <- function(data, method = "rf") {
  # Prepare data
  model_data <- data %>%
    mutate(
      day_of_week = weekdays(date),
      month = format(date, "%m"),
      day_of_year = as.numeric(format(date, "%j"))
    ) %>%
    select(-date)
  
  # Convert categorical variables to factors
  model_data$region <- as.factor(model_data$region)
  model_data$product <- as.factor(model_data$product)
  model_data$day_of_week <- as.factor(model_data$day_of_week)
  model_data$month <- as.factor(model_data$month)
  
  # Split data
  set.seed(123)
  train_index <- createDataPartition(model_data$sales, p = 0.8, list = FALSE)
  train_data <- model_data[train_index, ]
  test_data <- model_data[-train_index, ]
  
  # Train model
  if (method == "rf") {
    model <- randomForest(sales ~ ., data = train_data, ntree = 100, importance = TRUE)
  } else if (method == "svm") {
    model <- svm(sales ~ ., data = train_data, kernel = "radial")
  } else if (method == "lm") {
    model <- lm(sales ~ ., data = train_data)
  } else {
    stop("Invalid method. Choose 'rf', 'svm', or 'lm'.")
  }
  
  # Make predictions on test set
  predictions <- predict(model, newdata = test_data)
  
  # Calculate performance metrics
  rmse <- sqrt(mean((predictions - test_data$sales)^2))
  mae <- mean(abs(predictions - test_data$sales))
  r_squared <- cor(predictions, test_data$sales)^2
  
  return(list(
    model = model,
    predictions = predictions,
    test_data = test_data,
    metrics = list(
      RMSE = rmse,
      MAE = mae,
      R_squared = r_squared
    )
  ))
}

#' Extract feature importance from model
#' @param model_result Result from build_predictive_model
#' @return Feature importance data frame
#' @author Gabriel Demetrios Lafis
get_feature_importance <- function(model_result) {
  if (inherits(model_result$model, "randomForest")) {
    importance_df <- as.data.frame(importance(model_result$model))
    importance_df$feature <- rownames(importance_df)
    importance_df <- importance_df %>%
      arrange(desc(IncNodePurity))
    return(importance_df)
  } else {
    warning("Feature importance only available for Random Forest models.")
    return(NULL)
  }
}

# ============================================
# STATISTICAL TESTS
# ============================================

#' Perform comprehensive statistical tests
#' @param data Data frame with variables to test
#' @return List of test results
#' @author Gabriel Demetrios Lafis
perform_statistical_tests <- function(data) {
  results <- list()
  
  # Normality test (Shapiro-Wilk)
  results$normality_sales <- shapiro.test(sample(data$sales, min(5000, nrow(data))))
  results$normality_customers <- shapiro.test(sample(data$customers, min(5000, nrow(data))))
  
  # ANOVA test - comparing sales across regions
  results$anova_region <- aov(sales ~ region, data = data)
  results$anova_region_summary <- summary(results$anova_region)
  
  # ANOVA test - comparing sales across products
  results$anova_product <- aov(sales ~ product, data = data)
  results$anova_product_summary <- summary(results$anova_product)
  
  # T-test examples - comparing top regions
  region_levels <- unique(data$region)
  if (length(region_levels) >= 2) {
    region1_data <- data %>% filter(region == region_levels[1])
    region2_data <- data %>% filter(region == region_levels[2])
    results$ttest_regions <- t.test(region1_data$sales, region2_data$sales)
  }
  
  return(results)
}

# ============================================
# REPORT GENERATION
# ============================================

#' Generate automated statistical report
#' @param data Data frame to analyze
#' @param output_file Output file path (default: "reports/statistical_report.txt")
#' @author Gabriel Demetrios Lafis
generate_statistical_report <- function(data, output_file = "reports/statistical_report.txt") {
  # Create reports directory if it doesn't exist
  if (!dir.exists("reports")) {
    dir.create("reports")
  }
  
  # Open connection to file
  report <- file(output_file, open = "wt")
  
  # Write header
  writeLines("========================================", report)
  writeLines("STATISTICAL ANALYSIS REPORT", report)
  writeLines("Generated by: Gabriel Demetrios Lafis", report)
  writeLines(paste("Date:", Sys.time()), report)
  writeLines("========================================\n", report)
  
  # Descriptive statistics
  writeLines("\n--- DESCRIPTIVE STATISTICS ---", report)
  capture.output(summary(data), file = report, append = TRUE)
  
  # Correlation analysis
  writeLines("\n--- CORRELATION ANALYSIS ---", report)
  cor_matrix <- perform_correlation_analysis(data)
  capture.output(print(cor_matrix), file = report, append = TRUE)
  
  # Statistical tests
  writeLines("\n--- STATISTICAL TESTS ---", report)
  test_results <- perform_statistical_tests(data)
  capture.output(print(test_results$anova_region_summary), file = report, append = TRUE)
  capture.output(print(test_results$anova_product_summary), file = report, append = TRUE)
  
  # Close file
  close(report)
  
  cat("✅ Statistical report generated:", output_file, "\n")
  return(output_file)
}

# ============================================
# MODULE INITIALIZATION
# ============================================

cat("📊 Advanced Statistical Analysis Module Loaded\n")
cat("👨‍💻 Created by Gabriel Demetrios Lafis\n")
cat("✨ Features: Time Series, Clustering, ML, Correlation, Testing, Reporting\n")
