#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

fluidPage( theme = shinytheme("united"),
  titlePanel(title=div(tags$img(src = "logo.png", height = "35px"), 
             "Table for McDonald's items")),
  
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(3,selectInput("category", "Category:", 
                         c("All", unique(as.character(category)))
    )
    )
  ),
  
  DT::dataTableOutput("table")
)
  
  # Create a new row for the table.
