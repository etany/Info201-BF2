library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)
library(plotly)

# Read in the data 
mcd_df <- read.csv("../data/mcd35.csv", stringsAsFactors = F)

# Reactively filtering the nutrtion information based on user selection
server <- function(input, output) {
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

}