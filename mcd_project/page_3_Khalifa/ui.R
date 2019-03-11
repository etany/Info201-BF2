# ui.R

################################### Set up ###################################

# Load in packages
library(shiny)
library(ggplot2)
library(dplyr)

shinyUI(navbarPage(
  "McDonald's Analysis",
  # Create a tabPanel to show the scatter plot
  tabPanel(
    "Total Fat vs. Nutrition",
    # Add a titlePanel to your tab
    titlePanel("Select Data"),
    
    # Create a sidebar layout for this tab (page)
    sidebarLayout(
      
      # Create a sidebarPanel for your controls
      sidebarPanel(
        
        # Make a sliderInput widget for looking at a specified total fat range
        sliderInput("totalfat",
                    label = "Select Total Fat Range", min = min(data$Fat),
                    max = max(data$Fat), value = c(
                      min(data$Fat),
                      max(data$Fat)
                    )
        ),
        
        # Add a `selectInput` that allows you to select another nutrition variable
        selectInput(
          "x_var",
          label = "Choose Nutrition Variable to Plot Against Total Fat",
          choices = list(
            "Total Saturated Fats" = "Saturated Fat",
            "Total Trans Fats" = "Trans Fat",
            "Total Cholesterol" = "Cholesterol",
            "Total Salt" = "Salt",
            "Total Carbohydrates" = "Carbohydrates",
            "Total Fiber" = "Fiber",
            "Total Sugar" = "Sugar",
            "Total Protein" = "Protein"
          )
        )
      ),
      
      # Create a main panel, in which you should display your 
      # scatter plot
      mainPanel(
        plotOutput("scatter")
      )
    )
  )
))