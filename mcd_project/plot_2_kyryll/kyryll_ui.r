library(shiny)
library(dplyr)
library(ggplot2)
library(shinythemes)

mcd_df <- read.csv("../data/mcd35.csv", stringsAsFactors = F)

nutr_cats <- c("Calories" = "CAL",
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

all_menu_items <- unique(mcd_df$ITEM)

ui <- fluidPage( theme = shinytheme("united"),
             # Tab page one
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
                                  selected = dv_nutr_cats[1])
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
             )
  )
