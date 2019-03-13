# McDonald's Nutritional Data UI
# Group BF2 Final Project

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

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

# Define UI
shinyUI(navbarPage(

    # App title
    "McDonald's Nutritional Information",

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
            inputId = "x_nutr_all",
            label = "Select a nutrition",
            choices = list(
              "Calories",
              "Fat",
              "Saturated Fat",
              "Trans Fat",
              "Cholesterol",
              "Salt",
              "Carbohydrates",
              "Fiber",
              "Sugar",
              "Protein"
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
      "tabTwo",
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

    # Page three plot nutrition by total fat
    tabPanel(
      # Tab label
      "Total Fat vs. Nutrition",
      # Add a titlePanel to your tab
      titlePanel("Select Data"),

      # Create a sidebar layout for this tab (page)
      sidebarLayout(

        # Create a sidebarPanel for your controls
        sidebarPanel(

          # Make a sliderInput widget for looking at a specified total fat range
          sliderInput(inputId = "totalfat",
                      label = "Select Total Fat Range",
                      min = min(mcd_df$Fat),
                      max = max(mcd_df$Fat),
                      value = c(min(mcd_df$Fat),
                                max(mcd_df$Fat)
                                )
                      ),

          # Add dropdown to select nutrition variable for x axis
          selectInput(
            inputId = "x_nutr_fat",
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

        # Display scatter plot on main panel
        mainPanel(
          plotOutput("scatter")
        )
      )
    ),

    # Tab page four
    tabPanel(
      # Tab label
      "tabFour",
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
))
