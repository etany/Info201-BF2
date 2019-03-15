#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

server <- function(input, output) {
  filtered <- reactive({
    data <- data %>%
      filter(cal > input$cal[1] & cal < input$cal[2])%>%
      filter(fat> input$fat[1] & fat < input$fat[2])
    return(data)
  })  }

function(input, output) {
  output$table <- DT::renderDataTable(DT::datatable({
    data <- data
    if (input$category != "All") {
      data <- data[data$CATEGORY == input$category,]
    } 
    data
  }))
  

}