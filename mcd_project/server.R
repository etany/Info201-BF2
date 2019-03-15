# McDonald's Nutritional Data Server
# Group BF2 Final Project

library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(plotly)
library(tidyr)
library(DT)
library(lintr)
library(styler)

# Read in McDonald's data
mcd_df <- read.csv("./data/mcd35.csv", stringsAsFactors = F)

# Rename columns with full names
mcd_df <- mcd_df %>%
  select("Item" = "ITEM",
         "Calories" = "CAL",
         "Fat (g)" = "FAT",
         "Saturated Fat (g)" = "SFAT",
         "Trans Fat (g)" = "TFAT",
         "Cholesterol (mg)" = "CHOL",
         "Sodium (mg)" = "SALT",
         "Carbohydrates (g)" = "CARB",
         "Fiber (g)" = "FBR",
         "Sugar (g)" = "SGR",
         "Protein (g)" = "PRO",
         "Category" = "CATEGORY")

all_menu_items <- unique(mcd_df$"Item")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$first_plot <- renderPlotly({
    # Make a function in a separate file in scripts folder and call it here.
    selected <- mcd_df %>%
      filter(Category == as.character(input$cat_var))
    plot <- plot_ly(selected,
                    x = ~ (get(input$x_nutr_all)),
                    y = ~Item,
                    type = "scatter"
                    ) %>%
      layout(xaxis = list(title = input$x_nutr_all,
                          tickfont = list(size = 5)
                          ),
             yaxis = list(title = "",
                          tickfont = list(size = 5)
                          ),
             height = 600)

    return(plot)

  })

  filtered_dv <- reactive({
    data_dv <- mcd_df %>%
      # Removing duplicate items that appear in multiple categories
      distinct(Item, .keep_all = T) %>%
      # Calculating the percentage dv of each nutritional category for the
      # selected menu item.Values from the FDA:
      # *
      # www.fda.gov/ICECI/Inspections/InspectionGuides/
      # ucm114098.htm#ATTACHMENT_8
      # *
      mutate(
        dvCAL = (round(.$"Calories" / 2000, digits = 2)) * 100,
        dvFAT = (round(.$"Fat (g)" / 65, digits = 2)) * 100,
        dvSFAT = (round(.$"Saturated Fat (g)" / 20, digits = 2)) * 100,
        dvCHOL = (round(.$"Cholesterol (mg)" / 300, digits = 2)) * 100,
        dvSALT = (round(.$"Sodium (mg)" / 2400, digits = 2)) * 100,
        dvCARB = (round(.$"Carbohydrates (g)" / 300, digits = 2)) * 100,
        dvFBR = (round(.$"Fiber (g)" / 25, digits = 2)) * 100,
        dvPRO = (round(.$"Protein (g)" / 50, digits = 2)) * 100
      ) %>%
      # Filtering based on selected food item
      filter(Item == input$item_selected) %>%
      # Using tidyr to reshape the data format to allow graphing
      select(Item, contains("dv")) %>%
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

    return(data_dv)

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
                                           recomended value"
                                           ),
                             text = paste0("For one serving of the ", Item,
                                           ", its \n", dv,  " accounted for ",
                                           dvvalue, "% of the daily
                                           suggested amount"
                                           )
                             )
               ) +
      scale_fill_manual(values = c("#00BFC4", "#F8766D")) +
      xlab("Nutritional Categories") +
      ylab("% of Daily Value*") +
      labs(fill = "Daily Nutritional Value")
    # Coverting the ggplot to an interactive plot using plotly
    ggplotly(plot, tooltip = "text")

  })

  output$scatter_three <- renderPlot({
    # Store x values to plot
    x <- mcd_df[[input$x_nutr_fat]]

    # Create a ggplot scatter
    p <- ggplot(mcd_df,
                aes(x = x, y = mcd_df$"Fat (g)")
                ) +
      geom_point(aes(
        col = mcd_df$"Category",
        size = mcd_df$"Calories")
        ) +
      ylim(
        c(min(mcd_df$"Fat (g)"),
          max(mcd_df$"Fat (g)")
          )
        ) +
      labs(
        x = input$x_nutr_fat,
        y = "Total Fat (g)",
        title = paste0("McDonald's Dataset: Total Fat vs. Total ",
                       input$x_nutr_fat
                       ),
        caption = "Source: McDonald's"
      ) +
      scale_y_continuous(limits = input$totalfat) +
      theme(legend.key = element_blank(),
            legend.key.size = unit(11, "point")
            ) +
      labs(col = "Food Category", size = "Amount of Calories")

    return(p)

  })

  output$table <- DT::renderDataTable(DT::datatable({
    data <- mcd_df
    if (input$categ_2 != "All") {
      data <- mcd_df[mcd_df$Category == input$categ_2,]
    }

    return(data)

  }))

})
