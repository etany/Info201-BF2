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


# Start a shinyServer that creates a scatterplot
# It should use an `input` with features: `x_var`
shinyServer(function(input, output) {
  output$scatter <- renderPlot({
    plot_by_fat(data, input$x_var, input$totalfat)
    })
})