# Interactive Data Analytics Dashboard
# Author: Gabriel Demetrios Lafis
# Description: Shiny-based interactive dashboard for data analytics

# Load required libraries
library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(plotly)
library(DT)

# Source data processing functions
if (file.exists("main.R")) {
  source("main.R")
}

# Generate sample data
generate_dashboard_data <- function() {
  set.seed(123)
  data.frame(
    date = seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "day"),
    sales = round(rnorm(365, mean = 1000, sd = 200), 2),
    customers = round(rnorm(365, mean = 50, sd = 10)),
    region = sample(c("North", "South", "East", "West"), 365, replace = TRUE),
    product = sample(c("Product A", "Product B", "Product C"), 365, replace = TRUE)
  )
}

# UI Definition
ui <- dashboardPage(
  skin = "blue",
  
  # Header
  dashboardHeader(title = "R Data Analytics Dashboard"),
  
  # Sidebar
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Data Explorer", tabName = "data", icon = icon("table")),
      menuItem("Visualizations", tabName = "viz", icon = icon("chart-line")),
      menuItem("About", tabName = "about", icon = icon("info-circle"))
    )
  ),
  
  # Body
  dashboardBody(
    tabItems(
      # Dashboard Tab
      tabItem(
        tabName = "dashboard",
        fluidRow(
          valueBoxOutput("totalSalesBox"),
          valueBoxOutput("avgCustomersBox"),
          valueBoxOutput("totalRecordsBox")
        ),
        fluidRow(
          box(
            title = "Sales Trend",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            plotlyOutput("salesTrendPlot", height = 350)
          )
        ),
        fluidRow(
          box(
            title = "Regional Distribution",
            status = "success",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("regionPlot", height = 300)
          ),
          box(
            title = "Product Performance",
            status = "info",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("productPlot", height = 300)
          )
        )
      ),
      
      # Data Explorer Tab
      tabItem(
        tabName = "data",
        fluidRow(
          box(
            title = "Data Table",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            DTOutput("dataTable")
          )
        )
      ),
      
      # Visualizations Tab
      tabItem(
        tabName = "viz",
        fluidRow(
          box(
            title = "Sales Distribution",
            status = "warning",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("salesDistPlot", height = 350)
          ),
          box(
            title = "Customer Distribution",
            status = "danger",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("customerDistPlot", height = 350)
          )
        )
      ),
      
      # About Tab
      tabItem(
        tabName = "about",
        fluidRow(
          box(
            title = "About This Dashboard",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            h3("R Data Analytics Dashboard"),
            p("A comprehensive data analytics dashboard built with R and Shiny."),
            br(),
            h4("Features:"),
            tags$ul(
              tags$li("Interactive visualizations with Plotly"),
              tags$li("Real-time data exploration"),
              tags$li("Statistical analysis"),
              tags$li("Responsive design")
            ),
            br(),
            h4("Author:"),
            p("Gabriel Demetrios Lafis"),
            p(tags$a(href = "https://github.com/galafis", "GitHub: @galafis"))
          )
        )
      )
    )
  )
)

# Server Logic
server <- function(input, output, session) {
  
  # Load data
  data <- reactive({
    generate_dashboard_data()
  })
  
  # Value Boxes
  output$totalSalesBox <- renderValueBox({
    valueBox(
      paste0("$", format(sum(data()$sales), big.mark = ",")),
      "Total Sales",
      icon = icon("dollar-sign"),
      color = "green"
    )
  })
  
  output$avgCustomersBox <- renderValueBox({
    valueBox(
      round(mean(data()$customers), 1),
      "Avg Customers/Day",
      icon = icon("users"),
      color = "blue"
    )
  })
  
  output$totalRecordsBox <- renderValueBox({
    valueBox(
      nrow(data()),
      "Total Records",
      icon = icon("database"),
      color = "purple"
    )
  })
  
  # Sales Trend Plot
  output$salesTrendPlot <- renderPlotly({
    plot_ly(data(), x = ~date, y = ~sales, type = "scatter", mode = "lines",
            line = list(color = "#2E86AB", width = 2)) %>%
      layout(
        title = "Sales Trend Over Time",
        xaxis = list(title = "Date"),
        yaxis = list(title = "Sales ($)"),
        hovermode = "x unified"
      )
  })
  
  # Regional Plot
  output$regionPlot <- renderPlotly({
    region_summary <- data() %>%
      group_by(region) %>%
      summarise(total_sales = sum(sales), .groups = "drop")
    
    plot_ly(region_summary, labels = ~region, values = ~total_sales, type = "pie") %>%
      layout(title = "Sales by Region")
  })
  
  # Product Plot
  output$productPlot <- renderPlotly({
    product_summary <- data() %>%
      group_by(product) %>%
      summarise(total_sales = sum(sales), .groups = "drop")
    
    plot_ly(product_summary, x = ~product, y = ~total_sales, type = "bar",
            marker = list(color = "#A23B72")) %>%
      layout(
        title = "Sales by Product",
        xaxis = list(title = "Product"),
        yaxis = list(title = "Total Sales ($)")
      )
  })
  
  # Sales Distribution Plot
  output$salesDistPlot <- renderPlotly({
    plot_ly(data(), x = ~sales, type = "histogram",
            marker = list(color = "#F18F01")) %>%
      layout(
        title = "Sales Distribution",
        xaxis = list(title = "Sales ($)"),
        yaxis = list(title = "Frequency")
      )
  })
  
  # Customer Distribution Plot
  output$customerDistPlot <- renderPlotly({
    plot_ly(data(), x = ~customers, type = "histogram",
            marker = list(color = "#C73E1D")) %>%
      layout(
        title = "Customer Distribution",
        xaxis = list(title = "Customers"),
        yaxis = list(title = "Frequency")
      )
  })
  
  # Data Table
  output$dataTable <- renderDT({
    datatable(
      data(),
      options = list(
        pageLength = 25,
        scrollX = TRUE,
        order = list(list(0, "desc"))
      ),
      filter = "top",
      rownames = FALSE
    )
  })
}

# Run the application
shinyApp(ui = ui, server = server)
