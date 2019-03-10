#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

function(input, output) {
  output$table <- DT::renderDataTable(DT::datatable({
    data <- data
    if (input$category != "All") {
      data <- data[data$CATEGORY == input$category,]
    } 
    data
  }))
}