# McDonald's Nutritional Data UI
# Group BF2 Final Project

library(shiny)
library(dplyr)
library(ggplot2)


# Assigning full names to the nutritional categories

nutr_cats <- c("Calories" = "CAL",
               "Fat" = "FAT",
               "Saturated Fat" = "SFAT",
               "Trans Fat" = "TFAT",
               "Cholesterol" = "CHOL",
               "Salt" = "SALT",
               "Carbohydrates" = "CARB",
               "Fiber" = "FBR",
               "Sugar" = "SGR",
               "Protein" = "PRO",
               "Category" = "CATEGORY")

# Define UI for application that draws a histogram
shinyUI(
  fluidPage( theme = shinytheme("united"),

    # Tab page one
    tabPanel(
      # Tab label
      "",
      # Application title
      titlePanel("panelTitle"),

      # Sidebar
      sidebarLayout(
        sidebarPanel(
          # Sidebar code goes here
        ),

        # Shows graphic in main panel of tab
        mainPanel(
           plotOutput("firstPlot")
        )
      )
    ),

    # Tab page two
    tabPanel(
      # Tab label
      "",
      # Application title
      titlePanel("panelTitle"),

      # Sidebar
      sidebarLayout(
        sidebarPanel(
          # Sidebar code goes here
        ),

        # Shows graphic in main panel of tab
        mainPanel(
          plotOutput("secondPlot")
        )
      )
    ),

    # Tab page three
    tabPanel(
      # Tab label
      "",
      # Application title
      titlePanel("panelTitle"),

      # Sidebar
      sidebarLayout(
        sidebarPanel(
          # Sidebar code goes here
        ),

        # Shows graphic in main panel of tab
        mainPanel(
          plotOutput("thirdPlot")
        )
      )
    ),

    # Tab page four
    tabPanel(
      # Tab label
      "",
      # Application title
      titlePanel("panelTitle"),

      # Sidebar
      sidebarLayout(
        sidebarPanel(
          # Sidebar code goes here
        ),

        # Shows graphic in main panel of tab
        mainPanel(
          plotOutput("fourthPlot")
        )
      )
    ),

    # Tab page five: about tab
    tabPanel(
      # Tab label
      "about",
      # Application title
      titlePanel("About us"),
      hr(),
      h2("This project is brought to you by a group of Univeristy of Washington students enrolled in Info201."),
      h3(" Our team members include: "),
      h4("Jiafei Li"),
      h6( "Jiafei is a senior student pursuing Sociolgy and minoring in Infomatics." ),
      h4("Erica Tan"),
      h6( "Erica is a senior student pursuing Sociolgy and minoring in Infomatics."),
      h4("Khalifa Al-Maslamani"),
      h6(""),
      h4("Kyryll Keydansky"),
      h6(""),
      h4("Igor Podgorny"),
      h6(""),
      p(em("This project is in the process of being built"))
    )
  )
)
