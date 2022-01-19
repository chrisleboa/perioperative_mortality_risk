# Counts of data by categorty

# Author: Chris LeBoa
# Version: 2021-11-13

# Libraries
library(tidyverse)
#===============================================================================

data_percent %>%
  arrange(desc(`Percent Reporting`)) %>%
  ggplot() +
  geom_col(aes(x = reorder(Variable, `Percent Reporting`), y = `Percent Reporting`)) +
  scale_y_continuous(expand=c(0,0)) +
  coord_flip() +
  labs(
    title = "Percentage of studies reporting characteristic",
    x = ""
  )

plot_2 <-
  data_tab2 %>%
  arrange(desc(`Percent Reporting`)) %>%
  ggplot(aes(x = reorder(Variable, `Percent Reporting`), y = `Percent Reporting`, fill = Group)) +
  geom_bar( stat = "identity", width = .8) +
 # geom_text(aes(label = paste(`Percent Reporting`, "%")), vjust = -0.25) +
 # coord_flip() +
  facet_grid(~Group, switch = "y", scales = "free_x", space = "free_x") +
  theme_minimal() +
  theme(panel.spacing = unit(0, "lines"),
        strip.background = element_blank(),
        strip.placement = "outside",
        axis.text.x = element_text(angle = 90, vjust = 1, hjust=1, size = 12),
        text = element_text(size = 12),
        plot.title = element_text(size = 14),
        legend.position = "none"
        ) +
  scale_y_continuous(expand=c(0,0)) +
  facet_grid(~Group,
             scales = "free", # Let the x axis vary across facets.
             space = "free" )+ #,  # Let the width of facets vary and force all bars to have the same width.
           #  switch = "both") +
  labs(
    y = "Percentage of studies reporting characteristic",
    x = ""
  )

plot_2
