# McDonald's Nutritional Data UI
# Group BF2 Final Project

library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(plotly)
library(tidyr)

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

dv_nutr_cats <- c("Calories" = "dvCAL",
                  "Fat" = "dvFAT",
                  "Saturated Fat" = "dvSFAT",
                  "Cholesterol" = "dvCHOL",
                  "Sodium" = "dvSALT",
                  "Carbohydrates" = "dvCARB",
                  "Fiber" = "dvFBR",
                  "Protein" = "dvPRO"
)

all_menu_items <- unique(mcd_df$"Item")

# Define UI
shinyUI(navbarPage(theme = shinytheme("united"),

# Define UI for application that draws a histogram
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
              "Fat (g)",
              "Saturated Fat (g)",
              "Trans Fat (g)",
              "Cholesterol (mg)",
              "Sodium (mg)",
              "Carbohydrates (g)",
              "Fiber (g)",
              "Sugar (g)",
              "Protein (g)"
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
      "Daily Values %",
      # Application title
      titlePanel("Select Data"),
      # Sidebar
      sidebarLayout(
        sidebarPanel(
          selectInput("item_selected",
                      label = "Food Item",
                      choices = all_menu_items),
          selectizeInput("cat_selected",
                         label = "Nutritional Categories",
                         choices = dv_nutr_cats,
                         multiple = T,
                         selected = dv_nutr_cats[c(1, 2, 6)])
        ),
        # Shows graphic in main panel of tab
        mainPanel(
          h3("Comparison Between the Nutritional Value of
                      McDonalds Items and the Suggested Daily Value*"),
          plotlyOutput("dv_plot_2"),
          p(em("*As Specified by the FDA Based on a 2,000 Calorie
                        Intake for Adults and Children 4 or More Years of Age.",
               a("Source",
                 href = "https://www.fda.gov/ICECI/Inspections/
                          InspectionGuides/ucm114098.htm#ATTACHMENT_8"))),
          p("This plot serves to show what portion of the total daily
                     nutritional value each single item from the McDonalds menu
                     satisfies. If an item’s particular nutritional category
                     exceeds the suggested daily intake, then it is
                     highlighted in red. ")
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
                      min = min(mcd_df$"Fat (g)"),
                      max = max(mcd_df$"Fat (g)"),
                      value = c(min(mcd_df$"Fat (g)"),
                                max(mcd_df$"Fat (g)")
                                )
                      ),

          # Add dropdown to select nutrition variable for x axis
          selectInput(
            inputId = "x_nutr_fat",
            label = "Choose Nutrition Variable to Plot Against Total Fat",
            choices = list(
              "Total Saturated Fats" = "Saturated Fat (g)",
              "Total Trans Fats" = "Trans Fat (g)",
              "Total Cholesterol" = "Cholesterol (mg)",
              "Total Salt" = "Sodium (mg)",
              "Total Carbohydrates" = "Carbohydrates (g)",
              "Total Fiber" = "Fiber (g)",
              "Total Sugar" = "Sugar (g)",
              "Total Protein" = "Protein (g)"
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
      titlePanel(title=div(tags$img(src = "logo.png", height = "35px"),
                           "Table for McDonald's items")),


      # Create a new Row in the UI for selectInputs
      fluidRow(
        column(3, selectInput("category",
                              "Category:",
                              c("All", unique(as.character(category))
                                )
                             )
               )
      ),
      DT::dataTableOutput("table")
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
      h4("Kyryll Keydanskyy"),
      h6(""),
      h4("Igor Podgorny"),
      h6(""),
      p(em("This project is in the process of being built"))
    )
))
