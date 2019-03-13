# Scatter nutritional facts by total fat content
# Khalifa - Page 3 - plot function

library(shiny)
library(ggplot2)
library(dplyr)

# Load in the data
# plot_data <- read.csv("mcd35.csv", stringsAsFactors = F)
# plot_data <- data.frame(data)

plot_by_fat <- function(data, x_input, totalfat_input) {

  # Store x values to plot
  x <- data[[x_input]]

  # Create a ggplot scatter
  p <- ggplot(data, aes(x = x, y = data$Fat)) +
    geom_point(aes(col = Category, size = Calories)) +
    ylim(c(min(data$Fat), max(data$Fat))) +
    labs(
      x = x_input,
      y = "Total Fat (grams)",
      title = "Scatterplot",
      subtitle = paste0("McDonald's Dataset: Total Fat vs. Total ", x_input),
      caption = "Source: McDonald's"
    ) +
    scale_y_continuous(limits = totalfat_input) +
    theme(legend.key = element_blank(), legend.key.size = unit(11, "point"))

  return(p)
}