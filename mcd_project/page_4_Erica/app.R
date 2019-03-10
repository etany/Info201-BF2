library(dplyr)
library(shiny)
library(DT)

data<-read.csv("~/Info201-BF2/mcd_project/data/mcd35.csv")
category <- data$CATEGORY

shinyApp(ui = ui, server = server)
