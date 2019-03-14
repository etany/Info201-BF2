library(dplyr)
library(shiny)
library(DT)

data<-read.csv("./data/mcd35.csv")
category <- data$CATEGORY
cal <- select(data,CAL)
cal_range <-range(data$CAL)
fat <- select(data, FAT)
fat_range <- range(data$FAT)

shinyApp(ui = ui, server = server)
