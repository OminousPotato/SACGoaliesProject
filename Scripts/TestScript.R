library(tidyverse)
library(ggplot2)

data <- read.csv("./Data/hockeyReference.csv")

colors <- read.csv("./Data/colors.csv")

teamData <- read.csv("Data/teamData.csv")

clean_data <- data %>% 
  filter(GP >= 20) %>% 
  select(Player, Tm, GP, SV., SO, GSAA)

clean_teamData <- teamData %>% 
  mutate(Diff = GF - GA) %>% 
  select(Tm, Diff, GF, GA)

clean_data <- merge(clean_data, clean_teamData, by="Tm")

complete_data <- merge(clean_data, colors, by="Tm")

avgSV = mean(clean_data$SV.)

avgSO = mean(clean_data$SO)

upper_quadrant <- complete_data %>% 
  filter(SV. > avgSV & SO > avgSO)

############################################################
## GSAA Plot
############################################################

# ggplot(upper_quadrant, aes(x = reorder(Player, GSAA), y = GSAA, fill=Color)) +
#   geom_bar(stat="identity") +
#   scale_fill_identity() +
#   labs(
#     title = "Goalies with Most Goals Saved Above Average",
#     x = "",
#     y = "Goals Saved Above Average",
#     caption = "Data from hockey-reference\nData Viz by Brian^2 and Matt Roepke",
#     subtitle = "Colored by Team"
#   ) +
#   theme_bw() +
#   theme(
#     axis.text.x=element_text(angle=45, hjust=1),
#     plot.title = element_text(hjust = .5),
#     plot.subtitle = element_text(hjust = .5)
#   )
# 
# ggsave("Charts/GSAA_v2.png")

############################################################
## Shutouts and Save % Plot
############################################################

# ggplot(complete_data, aes(x=SV., y=SO, color=Color)) +
#   geom_point() +
#   xlim(.875, .94) +
#   ylim(0, 10) +
#   geom_hline(yintercept = avgSO) +
#   geom_vline(xintercept = avgSV) +
#   scale_color_identity() +
#   labs(
#     title = "Standout NHL Goalies from 2021-22 Season",
#     x = "Save Percentage",
#     y = "Shutouts Recorded",
#     caption = "Data from hockey-reference\nData Viz by Brian^2 and Matt Roepke"
#   ) +
#   theme_bw() +
#   theme(plot.title = element_text(hjust = .5))
# 
# 
# ggsave("Charts/Version2.png")

