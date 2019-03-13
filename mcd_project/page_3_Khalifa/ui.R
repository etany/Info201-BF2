# Scatter nutritional facts by total fat content
# Khalifa - Page 3 - UI

################################### Set up ###################################

# Load in packages
library(shiny)
library(ggplot2)
library(dplyr)

# Load in the data
data <- read.csv("mcd35.csv", stringsAsFactors = F)
data <- data.frame(data)

# Rename the columns in the data
colnames(data)[2:12] <- c("Calories", "Fat", "Saturated Fat", "Trans Fat",
                          "Cholesterol", "Salt", "Carbohydrates", "Fiber",
                          "Sugar", "Protein", "Category")

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