library(tidyverse)
library(ggplot2)

data <- read.csv("./Data/hockeyReference.csv")


clean_data <- data %>% 
  filter(GP >= 20) %>% 
  select(Player, Tm, GP, SV., SO)


avgSV = mean(clean_data$SV.)

avgSO = mean(clean_data$SO)

upper_quadrant <- clean_data %>% 
  filter(SV. > avgSV & SO > avgSO)


ggplot(clean_data, aes(x=SV., y=SO)) + 
  geom_point() + 
  xlim(.875, .94) +
  ylim(0, 10) + 
  geom_hline(yintercept = avgSO) +
  geom_vline(xintercept = avgSV) + 
  labs(
    title = "Standout NHL Goalies from 2021-22 Season",
    x = "Save Percentage",
    y = "Shutouts Recorded",
    caption = "Data from hockey-reference\nData Viz by Brian^2 and Matt Roepke"
  ) +
  
  theme(plot.title = element_text(hjust = .5))

