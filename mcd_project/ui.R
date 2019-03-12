# McDonald's Nutritional Data UI
# Group BF2 Final Project

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(
  fluidPage(theme = shinytheme("united"),

    # Tab page one
    tabPanel(
      # Tab label
      "Nutrition for all items",
      # Application title
      titlePanel("Nutrition for all items"),

      # Sidebar
      sidebarLayout(
        sidebarPanel(
          # Sidebar code goes here
          selectInput(
            "x_var",
            label = "Select a nutrition",
            choices = list(
              "Calories" = "CAL", 
              "Fat" = "FAT",
              "Saturated Fat" = "SFAT",
              "Trans Fat" = "TFAT",
              "Chloride" = "CHOL",
              "Salt" = "SALT",
              "Carbon" = "CARB",
              "Fiber" = "FBR",
              "Sugar" = "SGR",
              "Protein" = "PRO"
            )
          ),
          
          selectInput(
            "cat_var",
            label = "Select a category",
            choices = list(
              "Burger" = "BURGER", 
              "Chicken" = "CHICKEN",
              "Breakfast" = "BREAKFAST",
              "Salad" = "SALAD",
              "Snackside" = "SNACKSIDE",
              "Beverage" = "BEVERAGE",
              "McCafe" = "MCCAFE",
              "Dessert" = "DESSERT",
              "Condiment" = "CONDIMENT",
              "All Day Breakfast" = "ALLDAYBREAKFAST",
              "Biscuit" = "ADBISCUIT",
              "Muffin" = "ADBMUFFIN",
              "Happy Meal" = "HAPPYMEAL",
              "Signature" = "SIGNATURE",
              "McPick 2A" = "MCPICK2A",
              "McPick 2B" = "MCPICK2B",
              "McPick 2C" = "MCPICK2C"
            )
          )
        ),

        # Shows graphic in main panel of tab
        mainPanel(
           plotlyOutput("firstPlot"), width = 12, height = 20
        )
      ), position = "right", style='width: 800px; height: 900px'
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
