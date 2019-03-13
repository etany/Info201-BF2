# Scatter nutritional facts by total fat content
# Khalifa - Page 3 - Server

################################### Set up ###################################

# Load in packages
library(shiny)
library(ggplot2)
library(dplyr)
source("plot_by_fat.R")

# Load in the data
data <- read.csv("mcd35.csv", stringsAsFactors = F)

# Rename the columns in the data
colnames(data)[2:12] <- c("Calories", "Fat", "Saturated Fat", "Trans Fat",
                          "Cholesterol", "Salt", "Carbohydrates", "Fiber",
                          "Sugar", "Protein", "Category")

# Start a shinyServer that creates a scatterplot
# It should use an `input` with features: `x_var`
shinyServer(function(input, output) {
  output$scatter <- renderPlot({
    plot_by_fat(data, input$x_var, input$totalfat)
    })
})