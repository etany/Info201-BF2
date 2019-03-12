# McDonald's Nutritional Data Server
# Group BF2 Final Project

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Read in McDonald's data
  mcd_df   <- read.csv("./data/mcd35.csv", stringsAsFactors = F)

  output$firstPlot <- renderPlotly({
    # Make a function in a separate file in scripts folder and call it here.
    selected <- mcd_df %>% filter(CATEGORY == as.character(input$cat_var))
    plot <- plot_ly(selected, x = ~ (get(input$x_var)), y = ~ITEM, 
                    type = "scatter") %>% 
      layout(xaxis = list(title = "", tickfont = list(size = 5)), 
             yaxis = list(title = "", tickfont = list(size = 5)), 
             height = 600)
    plot
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
