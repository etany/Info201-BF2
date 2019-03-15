# McDonald's Nutritional Data UI
# Group BF2 Final Project

library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(plotly)
library(tidyr)
library(DT)
library(shinydashboard)
library(styler)
library(lintr)

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

# Labels for nutritional categories
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


# Define McDonald's UI
shinyUI(fluidPage(
  # includeHTML("styles.html"),
  includeCSS("styles.css"),
  navbarPage(

    # App title
    h4("McDonald's Nutritional Information"),

    # Tab page one
    tabPanel(
      # Tab label
      h5("Nutrition For All Items"),
      # Page header
      titlePanel(h2("Nutrition for all items")),
      sidebarLayout(
        sidebarPanel(
          # Select nutritional categories from mcd_df
          selectInput(
            inputId = "x_nutr_all",
            label = h4("Select a nutrition"),
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

          # Select food category to compare w/nutritional info
          selectInput(
            "cat_var",
            label = h4("Select a category"),
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

        # Shows interactive scatter plot on main panel
        mainPanel(
           plotlyOutput("first_plot"), width = 5, height = 20
        )
      ), position = "right" # , style='width: 800px; height: 900px'
    ),

    # Tab page two
    tabPanel(

      # Tab label
      h5("Daily Values %"),

      # Page title
      titlePanel(h2("Select Data")),
      sidebarLayout(
        sidebarPanel(
          selectInput("item_selected",
                      label = h4("Food Item"),
                      choices = all_menu_items
                      ),
          selectizeInput("cat_selected",
                         label = h4("Nutritional Categories"),
                         choices = dv_nutr_cats,
                         multiple = T,
                         selected = dv_nutr_cats[c(1, 2, 6)]
                         )
        ),
        # Shows bar plot in main panel of tab
        mainPanel(
          h3("Comparison Between the Nutritional Value of
             McDonalds Items and the Suggested Daily Value*"
             ),
          plotlyOutput("dv_plot_2"),
          br(),
          p(em("*As Specified by the FDA Based on a 2,000 Calorie
               Intake for Adults and Children 4 or More Years of Age.",
               a("Source",
                 href = "https://www.fda.gov/ICECI/Inspections/
                          InspectionGuides/ucm114098.htm#ATTACHMENT_8"
                 )
            )),
          p("This plot serves to show what portion of the total daily
            nutritional value each single item from the McDonalds menu
            satisfies. If an item’s particular nutritional category exceeds
            the suggested daily intake, then it is highlighted in red. "
            )
          )
        )
    ),

    # Tab page three
    tabPanel(

      # Tab label
      h5("Total Fat vs. Nutrition"),

      titlePanel(h2("Select Data")),
      sidebarLayout(

        # SidebarPanel for controls
        sidebarPanel(

          # Widget for looking at a specified total fat range
          sliderInput(inputId = "totalfat",
                      label = h4("Select Total Fat Range"),
                      min = min(mcd_df$"Fat (g)"),
                      max = max(mcd_df$"Fat (g)"),
                      value = c(min(mcd_df$"Fat (g)"),
                                max(mcd_df$"Fat (g)")
                                )
                      ),

          # Dropdown to select nutrition variable for x axis
          selectInput(
            inputId = "x_nutr_fat",
            label = h4("Choose Nutrition Variable to Plot Against Total Fat"),
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

        # Display scatter plot of nutrition by total fat on main panel
        mainPanel(
          plotOutput("scatter_three")
        )
      )
    ),

    # Tab page four
    tabPanel(

      # Tab label
      h5("Table For McDonalds' Items"),

      # Page title with img. logo
      titlePanel(title = div(tags$img(src = "logo.png",
                                      height = "35px"
                                      ),
                             h2("Table for McDonald's items")
                             )
                 ),

      # Create a new Row in the UI for selectInputs
      fluidRow(
        column(3,
               selectInput(
                 "categ_2",
                 label = h4("Select a category"),
                 choices = list(
                   "All",
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
               )
      ),
      DT::dataTableOutput("table")
      ),

    # Tab five
    tabPanel(

      # Tab title
      h5("Project Overview"),

      # Page title
      titlePanel(h2("Project Overview")),
      hr(),
      p(h3("What major questions are we seeking to answer?"),
        "The major questions we sought to answer involved helping the user
        analyze a list of nutritional information for the McDonald’s menu and
        perhaps make decisions about what food item(s) to consume.
        For instance, our interactive plots allow the user to filter through
        the data and organize it in an efficient manner that helps them look
        at a specific range of values and decide what food items fit within
        those restrictions.",
        br(),
        h4("The main question we were looking to answer is: "),
        "What food item should we recommend that our user consume from the list
        of McDonald’s food items?
        Our first interactive plot gives the user an overview of all the
        nutritional information for each category of food.
        The user is able to select a nutritional category, and plot it against
        a specific food category to look at all the menu items that fall under
        that category.",
        br(), br(),
        "Our second interactive plot allows users to compare
        the nutritional information for each item and category to the
        recommended FDA daily values, visually and clearly identifying those
        nutritional categories for a particular item which exceed the daily
        recommended value. ",
        br(), br(),
        "The third interactive plot allows users to select
        another nutritional category to be plotted against fat.
        The user is also able to filter through a range of values for the
        y-variable and order to look at a specific set of information for
        each category.
        This plot is useful for those wanting to look at a specified range
        of information and decide which food categories are more nutritional.",
        br(), br(),
        "The final graphic provides an alternate method for a user
        to select an item to eat while at McDonalds.
        If they are for example aiming to reduce their cholesterol intake, they
        can easily filter items
        by “least amount of cholesterol”, and then pick an item from a
        particular food group.",
        br(),
        h4("What data will you use to answer those questions?"),
        "In order to analyze the nutritional information of McDonalds items,
        we used several sources of data.
        Primarily, we used the available nutrition information from the
        McDonalds website, which listed the calories, as well as other
        nutritional categories such as fiber, protein and sodium levels for
        each item on the menu.",
        br(),
        hr(),

        "This data was collected from a repository on GitHub, where a user
        collected the original data from the McDonalds website.",
        br(),
        a("Source GitHub",
          href = "https://github.com/pffy/data-mcdonalds-nutritionfacts"
          ),
        a("Source McDonalds",
          href = "https://www.mcdonalds.com/us/en-us/about-our-food/
          nutrition-calculator.html"
          ),
        br(),
        "To compare the nutritional information for each item to the daily
        recommended value, we used data from the US FDA, where the daily
        recommended nutritional values were supplied based on the latest
        scientific studies.
        These daily values were Based on 2,000 Calorie Intake for Adults
        and Children 4 or More Years of Age.",
        br(),
        a("FDA Source",
          href = "https://www.fda.gov/ICECI/Inspections/InspectionGuides/
          ucm114098.htm#ATTACHMENT_8"
          )
        )
    ),

    # Tab page six
    tabPanel(

      # Tab label
      h5("About Us"),

      # Page title
      titlePanel(h2("About us")),
      hr(),
      p("This project is created by a group of Univeristy of Washington
        students enrolled in Informatics 201.",
        br(),
        h3(" Our team members:"),
        hr(),
        h4("Jiafei Li"),
        "Jiafei is a senior student pursuing Psychology and minoring in
        Informatics.", br(),
        br(),
        h4("Erica Tan"),
        "Erica is a senior student pursuing Sociolgy and minoring in
        Infomatics.", br(),
        br(),
        h4("Khalifa Al-Maslamani"),
        "Khalifa is a junior student pursuing Economics.", br(),
        br(),
        h4("Kyryll Keydanskyy"),
        "Kyryll is a junior pursuing Biochemistry.", br(),
        br(),
        h4("Igor Podgorny"),
        "Igor is majoring in Geography with a focus on Geography ", br(),
        "Information Systems while aslo pursuing a minor in Informatics",
        hr()
        )
      )
    )
))
