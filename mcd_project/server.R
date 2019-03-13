# McDonald's Nutritional Data Server
# Group BF2 Final Project

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
#source("page_3_Khalifa/plot_by_fat.R")

# Read in McDonald's data
mcd_df <- read.csv("./data/mcd35.csv", stringsAsFactors = F)

# Rename columns with full names
mcd_df <- mcd_df %>%
  select("Item" = "ITEM",
         "Calories" = "CAL",
         "Fat" = "FAT",
         "Saturated Fat" = "SFAT",
         "Trans Fat" = "TFAT",
         "Cholesterol" = "CHOL",
         "Salt" = "SALT",
         "Carbohydrates" = "CARB",
         "Fiber" = "FBR",
         "Sugar" = "SGR",
         "Protein" = "PRO",
         "Category" = "CATEGORY"
  )

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$firstPlot <- renderPlotly({
    # Make a function in a separate file in scripts folder and call it here.
    selected <- mcd_df %>% filter(Category == as.character(input$cat_var))
    plot <- plot_ly(selected, x = ~ (get(input$x_nutr_all)), y = ~Item,
                    type = "scatter") %>%
      layout(xaxis = list(title = "", tickfont = list(size = 5)),
             yaxis = list(title = "", tickfont = list(size = 5)),
             height = 600)
    plot
  })

  output$secondPlot <- renderPlot({
    # Make a function in a separate file in scripts folder and call it here.
  })

  output$scatter <- renderPlot({
    # Store x values to plot
    x <- mcd_df[[input$x_nutr_fat]]

    # Create a ggplot scatter
    p <- ggplot(mcd_df, aes(x = x, y = mcd_df$Fat)) +
      geom_point(aes(col = Category, size = Calories)) +
      ylim(c(min(mcd_df$Fat), max(mcd_df$Fat))) +
      labs(
        x = input$x_nutr_fat,
        y = "Total Fat (grams)",
        title = "Scatter Plot",
        subtitle = paste0("McDonald's Dataset: Total Fat vs. Total ",
                          input$x_nutr_fat
                          ),
        caption = "Source: McDonald's"
      ) +
      scale_y_continuous(limits = input$totalfat) +
      theme(legend.key = element_blank(), legend.key.size = unit(11, "point"))

    return(p)
  })

  output$fourthPlot <- renderPlot({
    # Make a function in a separate file in scripts folder and call it here.
  })

})
