# 📈 R Data Analytics Dashboard

<div align="center">

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Shiny](https://img.shields.io/badge/Shiny-276DC3?style=for-the-badge&logo=r&logoColor=white)
![ggplot2](https://img.shields.io/badge/ggplot2-276DC3?style=for-the-badge&logo=r&logoColor=white)

**Advanced Data Analytics Dashboard built with R and Shiny**

[🇺🇸 English](#english) | [🇧🇷 Português](#português)

</div>

---

## 🇺🇸 English

### 📋 Overview

A comprehensive data analytics dashboard built with R, featuring advanced statistical analysis, interactive visualizations, and machine learning capabilities.

### ✨ Features

- 📊 **Interactive Visualizations** - Dynamic charts and graphs with ggplot2
- 🤖 **Machine Learning** - Predictive modeling and clustering
- 📈 **Statistical Analysis** - Advanced statistical methods
- 🔄 **Real-time Data** - Live data processing and updates
- 📱 **Responsive Dashboard** - Shiny-based interactive interface
- 📋 **Reporting** - Automated report generation

### 🚀 Quick Start

```bash
# Clone repository
git clone https://github.com/galafis/R-Data-Analytics-Dashboard.git
cd R-Data-Analytics-Dashboard

# Install required packages
R -e "install.packages(c('shiny', 'shinydashboard', 'ggplot2', 'dplyr', 'plotly', 'DT', 'forecast', 'corrplot', 'cluster', 'caret', 'randomForest', 'e1071'))"

# Run analysis
Rscript main.R

# Start Shiny dashboard
R -e "shiny::runApp('dashboard.R')"
```

### 📁 Project Structure

```
R-Data-Analytics-Dashboard/
├── main.R                    # Main analysis pipeline
├── dashboard.R               # Interactive Shiny dashboard
├── statistical_analysis.R    # Advanced statistical methods
├── plots/                    # Generated visualizations
├── reports/                  # Generated reports
└── README.md                 # This file
```

### 📊 Modules

#### main.R
- Data generation and processing
- Visualization creation
- Pipeline orchestration

#### dashboard.R
- Interactive web-based dashboard
- Real-time data exploration
- Dynamic visualizations with Plotly

#### statistical_analysis.R
- Time series analysis (ARIMA forecasting)
- Machine learning models (Random Forest, SVM)
- Clustering algorithms (K-means, Hierarchical)
- Correlation analysis
- Statistical testing (ANOVA, t-tests)
- Automated reporting

### 🎯 Usage Examples

**Run complete analysis pipeline:**
```R
Rscript main.R
```

**Launch interactive dashboard:**
```R
R -e "shiny::runApp('dashboard.R')"
```

**Use statistical module:**
```R
source('main.R')
source('statistical_analysis.R')

data <- generate_sample_data()
ts_results <- perform_time_series_analysis(data)
ml_model <- build_predictive_model(data, method = 'rf')
generate_statistical_report(data)
```

### 📦 Dependencies

**Core packages:**
- shiny
- shinydashboard
- ggplot2
- dplyr
- plotly
- DT

**Statistical/ML packages:**
- forecast
- corrplot
- cluster
- caret
- randomForest
- e1071

---

## 🇧🇷 Português

### 📋 Visão Geral

Um dashboard abrangente de análise de dados construído com R, com análise estatística avançada, visualizações interativas e recursos de machine learning.

### ✨ Funcionalidades

- 📊 **Visualizações Interativas** - Gráficos dinâmicos com ggplot2
- 🤖 **Machine Learning** - Modelagem preditiva e clustering
- 📈 **Análise Estatística** - Métodos estatísticos avançados
- 🔄 **Dados em Tempo Real** - Processamento de dados ao vivo
- 📱 **Dashboard Responsivo** - Interface interativa baseada em Shiny
- 📋 **Relatórios** - Geração automatizada de relatórios

### 🚀 Início Rápido

```bash
# Clonar repositório
git clone https://github.com/galafis/R-Data-Analytics-Dashboard.git
cd R-Data-Analytics-Dashboard

# Instalar pacotes necessários
R -e "install.packages(c('shiny', 'shinydashboard', 'ggplot2', 'dplyr', 'plotly', 'DT', 'forecast', 'corrplot', 'cluster', 'caret', 'randomForest', 'e1071'))"

# Executar análise
Rscript main.R

# Iniciar dashboard Shiny
R -e "shiny::runApp('dashboard.R')"
```

### 📁 Estrutura do Projeto

```
R-Data-Analytics-Dashboard/
├── main.R                    # Pipeline principal de análise
├── dashboard.R               # Dashboard interativo Shiny
├── statistical_analysis.R    # Métodos estatísticos avançados
├── plots/                    # Visualizações geradas
├── reports/                  # Relatórios gerados
└── README.md                 # Este arquivo
```

### 📊 Módulos

#### main.R
- Geração e processamento de dados
- Criação de visualizações
- Orquestração do pipeline

#### dashboard.R
- Dashboard interativo baseado em web
- Exploração de dados em tempo real
- Visualizações dinâmicas com Plotly

#### statistical_analysis.R
- Análise de séries temporais (previsão ARIMA)
- Modelos de machine learning (Random Forest, SVM)
- Algoritmos de clustering (K-means, Hierárquico)
- Análise de correlação
- Testes estatísticos (ANOVA, testes t)
- Relatórios automatizados

### 🎯 Exemplos de Uso

**Executar pipeline completo de análise:**
```R
Rscript main.R
```

**Iniciar dashboard interativo:**
```R
R -e "shiny::runApp('dashboard.R')"
```

**Usar módulo estatístico:**
```R
source('main.R')
source('statistical_analysis.R')

data <- generate_sample_data()
ts_results <- perform_time_series_analysis(data)
ml_model <- build_predictive_model(data, method = 'rf')
generate_statistical_report(data)
```

### 📦 Dependências

**Pacotes principais:**
- shiny
- shinydashboard
- ggplot2
- dplyr
- plotly
- DT

**Pacotes estatísticos/ML:**
- forecast
- corrplot
- cluster
- caret
- randomForest
- e1071

---

## 👨‍💻 Author

**Gabriel Demetrios Lafis**

- 🌐 GitHub: [@galafis](https://github.com/galafis)

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

<div align="center">

**Made with ❤️ by Gabriel Demetrios Lafis**

</div>
