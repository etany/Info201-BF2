# McDonald's Nutritional Data UI
# Group BF2 Final Project

library(shiny)
library(dplyr)
library(ggplot2)

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
      titlePanel("About"),
      hr(),
      p(em("This project is in the process of being built"))
    )
  )
)
