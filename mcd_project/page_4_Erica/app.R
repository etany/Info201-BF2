library(dplyr)
library(shiny)
library(DT)

data<-read.csv("../data/mcd35.csv")
category <- data$CATEGORY

shinyApp(ui = ui, server = server)
