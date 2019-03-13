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

  filtered_dv <- reactive({
    data_dv <- mcd_df %>%
      # Removing duplicate items that appear in multiple categories
      distinct(ITEM, .keep_all = T) %>%
      # Calculating the percentage dv of each nutritional category for the
      # selected menu item.Values from the FDA:
      # www.fda.gov/ICECI/Inspections/InspectionGuides/ucm114098.htm#ATTACHMENT_8
      mutate(
        dvCAL = (round(CAL / 2000, digits = 2)) * 100,
        dvFAT = (round(FAT / 65, digits = 2)) * 100,
        dvSFAT = (round(SFAT / 20, digits = 2)) * 100,
        dvCHOL = (round(CHOL / 300, digits = 2)) * 100,
        dvSALT = (round(SALT / 2400, digits = 2)) * 100,
        dvCARB = (round(CARB / 300, digits = 2)) * 100,
        dvFBR = (round(FBR / 25, digits = 2)) * 100,
        dvPRO = (round(PRO / 50, digits = 2)) * 100
      ) %>%
      # Filtering based on selected food item
      filter(ITEM == input$item_selected) %>%
      # Using tidyr to reshape the data format to allow graphing
      select(ITEM, contains("dv")) %>%
      gather(., dv, dvvalue, -1) %>%
      # Filtering based on selected nutritional categories
      filter(dv %in% input$cat_selected) %>%
      # Rename the columns to better display on the plot
      mutate(dv = sub("dvCAL", "Calories", dv),
             dv = sub("dvFAT", "Fat", dv),
             dv = sub("dvSFAT", "Saturated Fat", dv),
             dv = sub("dvCHOL", "Cholesterol", dv),
             dv = sub("dvSALT", "Sodium", dv),
             dv = sub("dvCARB", "Carbohydrates", dv),
             dv = sub("dvFBR", "Fiber", dv),
             dv = sub("dvPRO", "Protein", dv)
      )
    data_dv
  })
  # Creating the plot
  output$dv_plot_2 <- renderPlotly({
    plot <- ggplot(filtered_dv()) +
      geom_col(mapping = aes(x = dv, y = dvvalue,
                             # Adding conditional color to the bars
                             fill = ifelse(dvvalue > 100,
                                           "Greater than the daily
                                           recomended value",
                                           "Below the daily
                                           recomended value"),
                             text = paste0("For one serving of the ", ITEM,
                                           ", its \n", dv,  " accounted for ",
                                           dvvalue, "% of the daily
                                           suggested amount"))) +
      scale_fill_manual(values = c("#00BFC4", "#F8766D")) +
      xlab("Nutritional Categories") +
      ylab("% of Daily Value*") +
      labs(fill = "Daily Nutritional Value")
    # Coverting the ggplot to an interactive plot using plotly
    ggplotly(plot, tooltip = "text")
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
