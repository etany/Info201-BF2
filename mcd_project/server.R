# McDonald's Nutritional Data Server
# Group BF2 Final Project

library(shiny)
library(dplyr)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Read in McDonald's data
  mcd_df   <- read.csv("./data/mcd35.csv", stringsAsFactors = F)

  output$firstPlot <- renderPlot({
    # Make a function in a separate file in scripts folder and call it here.
  })

  output$secondPlot <- renderPlot({
    # Make a function in a separate file in scripts folder and call it here.
  })

  output$thirdPlot <- renderPlot({
    # Make a function in a separate file in scripts folder and call it here.
  })

  output$fourthPlot <- renderPlot({
    # Make a function in a separate file in scripts folder and call it here.
  })

})
