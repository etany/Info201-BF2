# Scatter nutritional facts by total content
# Khalifa - Page 3

library(shiny)
library(ggplot2)
library(dplyr)

# Load in the data
data <- read.csv("mcd35.csv", stringsAsFactors = F)
data <- data.frame(data)

# Rename the columns in the data
colnames(data)[2:12] <- c("Calories", "Fat", "Saturated Fat",
                          "Trans Fat", "Cholesterol", "Salt", "Carbohydrates", "Fiber",
                          "Sugar", "Protein", "Category")

plot_by_fat <- function() {
  # Store x values to plot
  x <- data[[input$x_var]]

  # Create a ggplot scatter
  p <- ggplot(data, aes(x = x, y = data$Fat)) +
    geom_point(aes(col = Category, size = Calories)) +
    ylim(c(min(data$Fat), max(data$Fat))) +
    labs(
      x = input$x_var,
      y = "Total Fat (grams)",
      title = "Scatterplot",
      subtitle = paste0("McDonald's Dataset: Total Fat vs. Total ", input$x_var),
      caption = "Source: McDonald's"
    ) +
    scale_y_continuous(limits = input$totalfat) +
    theme(legend.key=element_blank(), legend.key.size=unit(11,"point"))

  p
}